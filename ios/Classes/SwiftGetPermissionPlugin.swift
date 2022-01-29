import Flutter
import UIKit

enum Methods: String, CaseIterable {
   case checkPermission = "checkPermission"
   case checkAvailability = "checkAvailability"
   case requestPermission = "requestPermission"
   case requestPermissions = "requestPermissions"
   case checkPermissions = "checkPermissions"
}

public class SwiftGetPermissionPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "get_permission", binaryMessenger: registrar.messenger())
        let instance = SwiftGetPermissionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        print("[GetPermission] Received call method: \(call.method), arguments: \(call.arguments ?? "(empty)")")
        
        switch (call.method) {
        case Methods.checkPermission.rawValue,
            Methods.checkAvailability.rawValue,
            Methods.requestPermission.rawValue:
            getPermission(from: call, result: result)
            break
        case Methods.requestPermissions.rawValue,
            Methods.checkPermissions.rawValue:
            getPermissions(from: call, result: result)
            break
        default:
            fatalError("Not implemented method channel: \(call.method)")
        }
        
    }
    
    private func getPermission(from call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        switch (call.method) {
        case Methods.checkPermission.rawValue:
            guard let permissionParams = call.arguments as? [Int], let firstValue = permissionParams.first,
                  let type = PermissionType(rawValue: firstValue) else {
                print("Integers array argument should be passed to the plugin")
                return;
            }
            var params = permissionParams
            if (permissionParams.count > 1) {
                params = Array(permissionParams[1...permissionParams.count])
            }
            
            checkPermission(type: type, options: params) { status in
                result(status)
            }
        case Methods.checkAvailability.rawValue:
            guard let permission = call.arguments as? Int,
                  let type = PermissionType(rawValue: permission) else {
                      print("Integer argument should be passed to the plugin")
                      return;
            }
            checkAvailability(type: type) { availability in
                result(availability)
            }
        case Methods.requestPermission.rawValue:
            guard let permissionParams = call.arguments as? [Int], let firstValue = permissionParams.first,
                  let type = PermissionType(rawValue: firstValue) else {
                print("Integers array argument should be passed to the plugin")
                return;
            }
            
            var params = permissionParams
            if (permissionParams.count > 1) {
                params = Array(permissionParams[1...permissionParams.count-1])
            }
            
            request(type: type, options: params) { status in
                result(status)
            }
        default:
            fatalError("Not implemented method channel: \(call.method)")
        }
    }
    
    private func getPermissions(from call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let permissionsIndices = call.arguments as? [Int] else {
            print("Integers array argument should be passed to the plugin")
            return;
        }
        
        let permissions = permissionsIndices.compactMap { PermissionType(rawValue: $0) }
        
        switch (call.method) {
        case Methods.requestPermissions.rawValue:
            var results = [Int: Int]()
            for permissionType in permissions {
                let handler = handler(for: permissionType)
                handler.request(permissionType, options: nil) { status in
                    results[permissionType.rawValue] = status.rawValue
                    if results.values.count == permissions.count {
                        result(results)
                    }
                }
            }
        case Methods.checkPermissions.rawValue:
            var results = [Int: Int]()
            for permissionType in permissions {
                let handler = handler(for: permissionType)
                results[permissionType.rawValue] = handler.checkStatus(permissionType, options: nil).rawValue
                if results.values.count == permissions.count {
                    result(results)
                }
            }
        default:
            fatalError("Not implemented method channel: \(call.method)")
        }
    }

    private func request(type: PermissionType, options: [Int]? = nil, result: @escaping FlutterResult) {
        let handler = handler(for: type)
        handler.request(type, options: options) { status in
            result(status.rawValue)
        }
    }

    private func checkPermission(type: PermissionType, options: [Int]? = nil, result: FlutterResult) {
        result(handler(for: type).checkStatus(type, options: options).rawValue)
    }

    private func checkAvailability(type: PermissionType, result: FlutterResult) {
        let handler = handler(for: type)
        handler.checkAvailability(type) { availability in
            result(availability.rawValue)
        }
    }

    private func handler(for type: PermissionType) -> HandlerProtocol {
        switch (type) {
        case .camera, .microphone:
            return AudioVideoHandler()
        case .contacts:
            return ContactsHandler()
        case .notification:
            return NotificationsHandler()
        case .notificationOptionAlert:
            if #available(iOS 10.0, *) {
                return NotificationOptionHandler(option: .alert)
            } else {
                return NotificationNotSupportedHandler()
            }
        case .notificationOptionBadge:
            if #available(iOS 10.0, *) {
                return NotificationOptionHandler(option: .badge)
            } else {
                return NotificationNotSupportedHandler()
        }
        case .notificationOptionSound:
            if #available(iOS 10.0, *) {
                return NotificationOptionHandler(option: .sound)
            } else {
                return NotificationNotSupportedHandler()
        }
        case .notificationOptionCarPlay:
            if #available(iOS 10.0, *) {
                return NotificationOptionHandler(option: .carPlay)
            } else {
                return NotificationNotSupportedHandler()
        }
        case .notificationOptionCriticalAlert:
            if #available(iOS 12.0, *) {
                return NotificationOptionHandler(option: .criticalAlert)
            } else {
                return NotificationNotSupportedHandler()
        }
        case .notificationOptionProvisional:
            if #available(iOS 12.0, *) {
                return NotificationOptionHandler(option: .provisional)
            } else {
                return NotificationNotSupportedHandler()
        }
        case .notificationOptionAnnouncement:
            if #available(iOS 13.0, *) {
                return NotificationOptionHandler(option: .announcement)
            } else {
                return NotificationNotSupportedHandler()
        }
        case .notificationOptionTimeSensitive:
            if #available(iOS 15.0, *) {
                return NotificationOptionHandler(option: .timeSensitive)
            } else {
                return NotificationNotSupportedHandler()
        }
        case .notificationOptions:
            return NotificationCustomOptionHandler()
        case .appTrackingTransparency:
            return AppTrackingTransparencyHandler()
        case .calendar, .reminder:
            return EventHandler()
        case .speech:
            return SpeechHandler()
        case .locationAlways, .locationWhenInUse:
            return LocationHandler()
        case .photos:
            return PhotoHandler(writeOnly: false)
        case .photosWriteOnlyIOS:
            return PhotoHandler(writeOnly: true)
        }
        
    }
}
