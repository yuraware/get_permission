//
//  CriticalAlertHandler.swift
//  get_permission
//
//  Created by Yuri on 09.01.2022.
//

import Foundation

// Use a reference https://developer.apple.com/documentation/usernotifications/asking_permission_to_use_notifications
//
//
class CriticalAlertHandler: HandlerProtocol {
    func checkStatus(_ type: PermissionType) -> PermissionStatus {
        return status()
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
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if error != nil {
                completion(.denied)
            }
            
            let completionStatus: PermissionStatus = granted ? .authorized : .denied
            completion(completionStatus)
        }
    }
    
    func status() -> PermissionStatus {
        if #available(iOS 12.0, *) {
            let semaphore = DispatchSemaphore(value: 0)
            var status = PermissionStatus.denied
            let userNotificationCenter = UNUserNotificationCenter.current()
            userNotificationCenter.getNotificationSettings { (notificationSettings) in
                
                switch notificationSettings.criticalAlertSetting {
                case .enabled:
                    status = .authorized
                case .disabled:
                    status = .denied
                case .notSupported:
                    status = .notSupported
                @unknown default:
                    fatalError("Not supported status")
                }
                semaphore.signal()
            }
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
            return status
            
        } else {
            return .permanentlyDenied
        }
    }
}
