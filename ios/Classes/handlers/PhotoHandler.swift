//
//  PhotoHandler.swift
//  get_permission
//
//  Created by Yuri on 29.01.2022.
//

import Foundation
import Photos

// Use a reference https://developer.apple.com/documentation/photokit/delivering_an_enhanced_privacy_experience_in_your_photos_app
// Remember to add the NSPhotoLibraryUsageDescription, NSPhotoLibraryAddUsageDescription
// to your app’s Info.plist file
//
class PhotoHandler: HandlerProtocol {
    
    let writeOnly: Bool
    
    init(writeOnly: Bool) {
        self.writeOnly = writeOnly
    }
    
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus {
        
        var authStatus: PHAuthorizationStatus
        
        if #available(iOS 14, *) {
            authStatus = PHPhotoLibrary.authorizationStatus(for: writeOnly ? .addOnly : .readWrite)
        } else {
            authStatus = PHPhotoLibrary.authorizationStatus()
        }
       
        return permissionStatus(from: authStatus)
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
            PHPhotoLibrary.requestAuthorization(for: writeOnly ? .addOnly : .readWrite) { authStatus in
                completion(self.permissionStatus(from: authStatus))
            }
        } else {
            PHPhotoLibrary.requestAuthorization { authStatus in
                completion(self.permissionStatus(from: authStatus))
            }
        }
    }

    func permissionStatus(from authStatus: PHAuthorizationStatus) -> PermissionStatus {
        switch authStatus {
        case .authorized:
            return .authorized
        case .restricted:
            return .restricted
        case .denied, .notDetermined:
            return .denied
        case .limited:
            return .limited
        @unknown default:
            fatalError("Not supported status in ATTrackingManager.AuthorizationStatus")
        }
    }
}
