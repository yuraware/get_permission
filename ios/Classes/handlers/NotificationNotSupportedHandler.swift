//
//  NotificationNotSupportedHandler.swift
//  get_permission
//
//  Created by Yuri on 08.01.2022.
//

import Foundation
import UserNotifications

//
//
//
class NotificationNotSupportedHandler: HandlerProtocol {
    func checkStatus(_ type: PermissionType) -> PermissionStatus {
        return .notSupported
    }
    
    func checkAvailability(_ type: PermissionType, completion: (PermissionAvailability) -> ()) {
        completion(PermissionAvailability.nonApplicable)
    }
    
    func request(_ type: PermissionType, completion: @escaping (PermissionStatus) -> ()) {
        completion(.notSupported)
    }
}
