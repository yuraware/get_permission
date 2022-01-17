//
//  EventHandler.swift
//  get_permission
//
//  Created by Yuri on 17.01.2022.
//

import Foundation
import EventKit

// Use a reference https://developer.apple.com/documentation/eventkit/accessing_the_event_store
// Remember to add the NSCalendarsUsageDescription, NSRemindersUsageDescription, NSContactsUsageDescription keys unless the app crashes
// to your app’s Info.plist file
//
class EventHandler: HandlerProtocol {
    
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

        let eventStore = EKEventStore()
        eventStore.requestAccess(to: ekEntityType(from: type)) { granted, error in
            if granted {
                completion(.authorized)
            } else {
                completion(.denied)
            }
        }
    }
    
    func ekEntityType(from type: PermissionType) -> EKEntityType {
        switch type {
        case .calendar:
            return .event
        case .reminder:
            return .reminder
        default:
            fatalError("Not supported permission type")
        }
    }

    func permissionStatus(from authStatus: EKAuthorizationStatus) -> PermissionStatus {
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
    
    func status(from type: PermissionType) -> PermissionStatus {
        let ekEntityType = ekEntityType(from: type)
        let authStatus = EKEventStore.authorizationStatus(for: ekEntityType)
        return permissionStatus(from: authStatus)
    }
}
