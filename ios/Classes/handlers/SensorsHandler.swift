//
//  SensorsHandler.swift
//  get_permission
//
//  Created by Yuri on 04.02.2022.
//

import Foundation
import CoreMotion


// Remember to add the NSMotionUsageDescription
// to your app’s Info.plist file
//
@available(iOS 11.0, *)
class SensorsHandler: HandlerProtocol {
    
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus {
        return permissionStatus(from: CMMotionActivityManager.authorizationStatus())
    }
    
    func checkAvailability(_ type: PermissionType, completion: (PermissionAvailability) -> ()) {
         completion(PermissionAvailability.nonApplicable)
    }
    
    func request(_ type: PermissionType, options: [Int]?, completion: @escaping (PermissionStatus) -> ()) {
        
        let status = checkStatus(type, options: options)
        guard status == .denied else {
            completion(status)
            return
        }
        
        let motionManager = CMMotionActivityManager()
        let now = Date()
        motionManager.queryActivityStarting(from: now, to: now, to: OperationQueue.main) { [self] activities, error in
            completion(self.permissionStatus(from: CMMotionActivityManager.authorizationStatus()))
        }
    }

    func permissionStatus(from authStatus: CMAuthorizationStatus) -> PermissionStatus {
        switch authStatus {
        case .authorized:
            return .authorized
        case .restricted:
            return .restricted
        case .denied, .notDetermined:
            return .denied
        @unknown default:
            fatalError("Not supported status in ATTrackingManager.AuthorizationStatus")
        }
    }
}
