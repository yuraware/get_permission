//
//  AppTrackingTransparencyHandler.swift
//  get_permission
//
//  Created by Yuri on 17.01.2022.
//

import Foundation
import AppTrackingTransparency

// Use a reference https://developer.apple.com/documentation/apptrackingtransparency
// Remember to add the NSUserTrackingUsageDescription key
// to your app’s Info.plist file
//
class AppTrackingTransparencyHandler: HandlerProtocol {
    
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus {
        return status()
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
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { authStatus in
                completion(self.permissionStatus(from: authStatus))
            }
        } else {
            completion(.notSupported)
        }
    }

    @available(iOS 14, *)
    func permissionStatus(from authStatus: ATTrackingManager.AuthorizationStatus) -> PermissionStatus {
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
    
    func status() -> PermissionStatus {
        if #available(iOS 14, *) {
            let trackingStatus = ATTrackingManager.trackingAuthorizationStatus
            return permissionStatus(from: trackingStatus)
        } else {
            return .notSupported
        }
    }
}
