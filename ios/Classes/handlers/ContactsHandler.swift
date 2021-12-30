//
//  ContactsHandler.swift
//  get_permission
//
//  Created by Yuri on 29.12.2021.
//

import Foundation
import Contacts

// Use a reference https://developer.apple.com/documentation/contacts/requesting_authorization_to_access_contacts
// Remember to add the NSContactsUsageDescription key
// to your app’s Info.plist file
//
class ContactsHandler: HandlerProtocol {
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
        
        CNContactStore().requestAccess(for: .contacts) { authorized, error in
            if authorized {
                completion(.authorized)
            } else {
                completion(.denied)
            }
        }
    }
    
    func status() -> PermissionStatus {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            return .authorized
        case .notDetermined, .denied:
            return .denied
        default:
            fatalError()
        }
    }
}

