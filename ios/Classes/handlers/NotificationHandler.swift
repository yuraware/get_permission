//
//  NotificationPermissionHandler.swift
//  get_permission
//
//  Created by Yuri on 08.01.2022.
//

import Foundation
import UserNotifications

// Use a reference https://developer.apple.com/documentation/usernotifications/asking_permission_to_use_notifications
// Checks notifications status for options: alert, sound, badge
//
class NotificationsHandler: HandlerProtocol {
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
        if #available(iOS 10.0, *) {
            let semaphore = DispatchSemaphore(value: 0)
            var status = PermissionStatus.denied
            let userNotificationCenter = UNUserNotificationCenter.current()
            userNotificationCenter.getNotificationSettings { (notificationSettings) in
                switch notificationSettings.authorizationStatus {
                case .authorized, .provisional, .ephemeral:
                    status = .authorized
                case .denied, .notDetermined:
                    status = .denied
                @unknown default:
                    fatalError("Not supported status")
                }
                semaphore.signal()
            }
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
            return status
            
        } else {
            let settings = UIApplication.shared.currentUserNotificationSettings
            guard let settings = settings else {
                return .denied
            }

            return settings.types.contains(.alert) ? .authorized : .denied
        }
    }
}
