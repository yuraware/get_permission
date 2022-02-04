//
//  PermissionNotSupportedHandler.swift
//  get_permission
//
//  Created by Yuri on 08.01.2022.
//

import Foundation
import UserNotifications

// Handles not supported type
//
//
class PermissionNotSupportedHandler: HandlerProtocol {
    
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
