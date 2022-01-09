//
//  NotificationOptionHandler.swift
//  get_permission
//
//  Created by Yuri on 09.01.2022.
//

import Foundation

// Checks notification authorization for options: badge, sound, alert,
// carPlay, criticalAlert, providesAppNotificationSettings,
// provisional, announcement (deprecated), timeSensitive (deprecated)
//
class NotificationOptionHandler: HandlerProtocol {
    
    let options: UNAuthorizationOptions
    
    init(options: UNAuthorizationOptions) {
        self.options = options
    }
    
    func checkStatus(_ type: PermissionType) -> PermissionStatus {
        return status()
    }
    
    func checkAvailability(_ type: PermissionType, completion: (PermissionAvailability) -> ()) {
         completion(PermissionAvailability.nonApplicable)
    }
    
    func request(_ type: PermissionType, completion: @escaping (PermissionStatus) -> ()) {
        let status = checkStatus(type)
        guard status != .denied else {
            completion(status)
            return
        }
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: options) { granted, error in
            if error != nil {
                completion(.denied)
            }
            let completionStatus: PermissionStatus = granted ? .authorized : .denied
            completion(completionStatus)
        }
    }
    
    func status() -> PermissionStatus {
        let semaphore = DispatchSemaphore(value: 0)
        var status = PermissionStatus.denied
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.getNotificationSettings { (notificationSettings) in
            
            var setting: UNNotificationSetting?
            
            if self.options == .badge {
                setting = notificationSettings.badgeSetting
            }
            if self.options == .sound {
                setting = notificationSettings.soundSetting
            }
            if self.options == .alert {
                setting = notificationSettings.alertSetting
            }
            if self.options == .carPlay {
                setting = notificationSettings.carPlaySetting
            }
            if #available(iOS 12.0, *), self.options == .criticalAlert {
                setting = notificationSettings.criticalAlertSetting
            }
            if #available(iOS 13.0, *), self.options == .announcement {
                setting = notificationSettings.announcementSetting
            }
            if #available(iOS 15.0, *), self.options == .timeSensitive {
                setting = notificationSettings.timeSensitiveSetting
            }
            //TODO: handle providesAppNotificationSettings

            switch setting {
            case .enabled:
                status = .authorized
            case .disabled:
                status = .denied
            case .notSupported, .none:
                status = .notSupported
            @unknown default:
                fatalError("Not supported status")
            }
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return status
    }
}



private enum NotificationAuthorizationOption: String, CaseIterable {
    case carPlay = "carPlay"
    case criticalAlert = "criticalAlert"
    case providesAppNotificationSettings = "providesAppNotificationSettings"
    case provisional = "provisional"
    case announcement = "announcement"
    case timeSensitive = "timeSensitive"
    case badge = "badge"
    case sound = "sound"
    case alert = "alert"
}
