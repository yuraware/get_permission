//
//  ContactsHandler.swift
//  get_permission
//
// Use a reference https://developer.apple.com/documentation/contacts/requesting_authorization_to_access_contacts
//
//  Created by Yuri on 29.12.2021.
//

import Foundation
import Contacts

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
        
    }
    
    func status() -> PermissionStatus {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            return .authorized
        case .notDetermined:
            return .denied
        case .denied:
            return .denied
        default:
            fatalError()
    }
}

