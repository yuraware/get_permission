//
//  NotImplementedHandler.swift
//  get_permission
//
//  Created by Yuri on 17.01.2022.
//

import Foundation

// Use a reference https://developer.apple.com/documentation/contacts/requesting_authorization_to_access_contacts
// Remember to add the NSContactsUsageDescription key
// to your app’s Info.plist file
//
class NotImplementedHandler: HandlerProtocol {
    
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus {
        return .notSupported
    }
    
    func checkAvailability(_ type: PermissionType, completion: (PermissionAvailability) -> ()) {
         completion(PermissionAvailability.nonApplicable)
    }
    
    func request(_ type: PermissionType, options: [Int]?, completion: @escaping (PermissionStatus) -> ()) {
        completion(.notSupported)
    }
}

