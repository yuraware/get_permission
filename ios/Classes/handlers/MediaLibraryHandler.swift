//
//  MediaLibraryHandler.swift
//  get_permission
//
//  Created by Yuri on 31.01.2022.
//

import Foundation
import MediaPlayer
// Use a reference https://developer.apple.com/documentation/mediaplayer/mpmedialibrary/1621276-requestauthorization
//
class MediaLibraryHandler: HandlerProtocol {
    
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus {
        return status(from: type)
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
        
        MPMediaLibrary.requestAuthorization { authStatus in
            completion(self.permissionStatus(from: authStatus))
        }
    }
    
   
    func permissionStatus(from authStatus: MPMediaLibraryAuthorizationStatus) -> PermissionStatus {
        switch authStatus {
        case .authorized:
            return .authorized
        case .restricted:
            return .restricted
        case .denied, .notDetermined:
            return .denied
        @unknown default:
            fatalError("Not supported status in MPMediaLibraryAuthorizationStatus")
        }
    }
    
    func status(from type: PermissionType) -> PermissionStatus {
        return permissionStatus(from: MPMediaLibrary.authorizationStatus())
    }
}
