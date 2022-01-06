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
        guard let permission = call.arguments as? Int,
              let type = PermissionType(rawValue: permission) else {
                  print("Integer argument should be passed to the plugin")
                  return;
        }
        
        switch (call.method) {
        case Methods.checkPermission.rawValue:
            checkPermission(type: type) { status in
                result(status)
            }
        case Methods.checkAvailability.rawValue:
            checkAvailability(type: type) { availability in
                result(availability)
            }
        case Methods.requestPermission.rawValue:
            request(type: type) { status in
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
                handler.request(permissionType) { status in
                    results[permissionType.rawValue] = status.rawValue
                    if results.values.count == permissions.count {
                        result(results)
                    }
                }
            }
        case Methods.checkPermissions.rawValue:
            fatalError("Not implemented method channel: \(call.method)")
        default:
            fatalError("Not implemented method channel: \(call.method)")
        }
    }

    private func request(type: PermissionType, result: @escaping FlutterResult) {
        let handler = handler(for: type)
        handler.request(type) { status in
            result(status.rawValue)
        }
    }

    private func checkPermission(type: PermissionType, result: FlutterResult) {
        result(handler(for: type).checkStatus(type).rawValue)
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
        }
    }
}
