//
//  AudioVideoPermissionHandler.swift
//  get_permission
//
//  Created by Yuri on 18.12.2021.
//

import Foundation
import AVFoundation

class AudioVideoHandler: HandlerProtocol {
    func checkStatus(_ type: PermissionType) -> PermissionStatus {
        return status(for: avMediaType(from: type))
    }
    
    func checkAvailability(_ type: PermissionType, completion: (PermissionAvailability) -> ()) {
         completion(PermissionAvailability.nonApplicable)
    }
    
    func request(_ type: PermissionType, completion: @escaping (PermissionStatus) -> ()) {
        let status = checkStatus(type)
        guard status == .denied else {
            completion(status)
            return
        }
        
        AVCaptureDevice.requestAccess(for: avMediaType(from: type)) { authorized in
            let completionStatus: PermissionStatus = authorized ? .authorized : .permanentlyDenied
            completion(completionStatus)
        }
    }
    
    func status(for type: AVMediaType) -> PermissionStatus {
        switch AVCaptureDevice.authorizationStatus(for: type) {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .denied
        case .restricted:
            return .restricted
        case .denied:
            return .permanentlyDenied
        @unknown default:
            fatalError()
        }
    }
    
    private func avMediaType(from type: PermissionType) -> AVMediaType {
        switch type {
        case .camera:
            return .video
        case .microphone:
            return .audio
        default:
            fatalError()
        }
    }
}

