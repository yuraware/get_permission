import Flutter
import UIKit

public class SwiftGetPermissionPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "get_permission", binaryMessenger: registrar.messenger())
        let instance = SwiftGetPermissionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
    
    private func checkPermission(type: PermissionType) {
        switch (type) {
        case .camera, .microphone:
            let handler = AudioVideoHandler()
            handler.checkStatus(type)
        case .contacts:
            fatalError()
        default:
            fatalError()
        }
    }
}
