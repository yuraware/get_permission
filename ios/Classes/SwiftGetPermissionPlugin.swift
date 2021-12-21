import Flutter
import UIKit

public class SwiftGetPermissionPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "get_permission", binaryMessenger: registrar.messenger())
        let instance = SwiftGetPermissionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        guard let arguments = call.arguments as? ArgumentsParser,
              let permission = arguments.parseInt(),
              let type = PermissionType(rawValue: permission) else {
            fatalError("Integer argument should be passed to the plugin")
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
        default:
            fatalError("Not implemented method channel: \(call.method)")
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
            fatalError()
        }
    }
}
