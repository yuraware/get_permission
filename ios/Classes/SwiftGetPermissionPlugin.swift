import Flutter
import UIKit

public class SwiftGetPermissionPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "get_permission", binaryMessenger: registrar.messenger())
        let instance = SwiftGetPermissionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        print("[GetPermission] Received call method: \(call.method), arguments: \(call.arguments ?? "(empty)")")
        
        guard let permission = call.arguments as? Int,
              let type = PermissionType(rawValue: permission) else {
                  print("Integer argument should be passed to the plugin")
                  return;
        }

        switch (call.method) {
        case "checkPermission":
            checkPermission(type: type) { status in
                result(status)
            }
        case "checkAvailability":
            checkAvailability(type: type) { availability in
                result(availability)
            }
        case "requestPermission":
            request(type: type) { status in
                result(status)
            }
        case "requestPermissions":
            fatalError("Not implemented")
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
