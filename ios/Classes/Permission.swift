//
//  Permission.swift
//  get_permission
//
//  Created by Yuri on 18.12.2021.
//

import Foundation

enum PermissionType: Int {
    case camera = 0
    case microphone
    case contacts
}

enum PermissionStatus: Int {
    case denied = 0
    case authorized
    case restricted
    case limited
    case permanentlyDenied
}

enum PermissionAvailability: Int {
    case enabled = 0
    case disabled
    case unsupported
}

