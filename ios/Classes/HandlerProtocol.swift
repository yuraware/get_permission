//
//  HandlerProtocol.swift
//  get_permission
//
//  Created by Yuri on 18.12.2021.
//

import Foundation

protocol HandlerProtocol {
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus
    func checkAvailability(_ type: PermissionType, completion: (PermissionAvailability) -> ())
    func request(_ type: PermissionType, options: [Int]?, completion: @escaping (PermissionStatus) -> ())
}
