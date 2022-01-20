//
//  SpeechHandler.swift
//  get_permission
//
//  Created by Yuri on 20.01.2022.
//

import Foundation
import Speech

// Use a reference https://developer.apple.com/documentation/speech/asking_permission_to_use_speech_recognition
// Remember to add the NSSpeechRecognitionUsageDescription
// to your app’s Info.plist file
//
class SpeechHandler: HandlerProtocol {
    
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus {
        return permissionStatus(from: SFSpeechRecognizer.authorizationStatus())
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
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            completion(self.permissionStatus(from: authStatus))
        }


    }

    func permissionStatus(from authStatus: SFSpeechRecognizerAuthorizationStatus) -> PermissionStatus {
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
