import UIKit
import AVFoundation
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      
      switch AVCaptureDevice.authorizationStatus(for: .video) {
          case .authorized:
          // The user has previously granted access to the camera.
          break
          case .notDetermined: // The user has not yet been asked for camera access.
              AVCaptureDevice.requestAccess(for: .video) { granted in
                  if granted {
                      //TODO request
                  }
              }
          
          case .denied: // The user has previously denied access.
              return

          case .restricted: // The user can't grant access due to restrictions.
              return
      }

      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
