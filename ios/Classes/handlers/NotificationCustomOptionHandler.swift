//
//  NotificationCustomOptionHandler.swift
//  get_permission
//
//  Created by Yuri on 09.01.2022.
//

import Foundation

// Checks notification authorization with multiple options: badge, sound, alert,
// carPlay, criticalAlert, providesAppNotificationSettings,
// provisional, announcement (deprecated), timeSensitive (deprecated)
//
class NotificationCustomOptionHandler: HandlerProtocol {
    
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus {
        return status(options: options)
    }
    
    func checkAvailability(_ type: PermissionType, completion: (PermissionAvailability) -> ()) {
         completion(PermissionAvailability.nonApplicable)
    }
    
    func request(_ type: PermissionType, options: [Int]?, completion: @escaping (PermissionStatus) -> ()) {
                
        guard let intOptions = options else {
            fatalError("Authorization options should be provided")
        }

        let authorizationOptions = intOptions.compactMap { NotificationAuthorizationOption(rawValue: $0)?.option() }
        
        var authorizationOptionSet = UNAuthorizationOptions()
        authorizationOptions.forEach {authorizationOptionSet.insert($0)}

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: authorizationOptionSet) { granted, error in
            if error != nil {
                completion(.denied)
            }
            let completionStatus: PermissionStatus = granted ? .authorized : .denied
            completion(completionStatus)
        }
    }
    
    func status(options: [Int]?) -> PermissionStatus {
        guard let options = options else {
            return .denied
        }
        
        let authorizationOptions = options.compactMap { NotificationAuthorizationOption(rawValue: $0)?.option() }
        for option in authorizationOptions {
            let status = NotificationOptionHandler.status(option: option)
            if status != .authorized {
                return status
            }
        }
        return .authorized
    }
}

private enum NotificationAuthorizationOption: Int, CaseIterable {
    case alert
    case badge
    case sound
    case carPlay
    case criticalAlert
    case provisional
    case announcement
    case timeSensitive
    case unknown
    
    func option() -> UNAuthorizationOptions? {
        switch self {
        case .alert: return .alert
        case .badge: return .badge
        case .sound: return .sound
        case .carPlay: return .carPlay
        case .criticalAlert:
            if #available(iOS 12.0, *) {
                return .criticalAlert
            } else {
                return nil
            }
        case .provisional:
            if #available(iOS 12.0, *) {
                return .provisional
            } else {
                return nil
            }
        case .announcement:
                if #available(iOS 13.0, *) {
                    return .announcement
                } else {
                    return nil
                }
        case .timeSensitive:
                if #available(iOS 15.0, *) {
                    return .timeSensitive
                } else {
                    return nil
                }
        case .unknown:
            return nil
        }
    }
}
