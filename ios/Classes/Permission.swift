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
    case notification
    case criticalAlert
}

enum PermissionStatus: Int {
    case denied = 0
    case authorized
    case restricted
    case limited
    case permanentlyDenied // Not used on iOS
    case notSupported // In case of OS version not supports it
}

enum PermissionAvailability: Int {
    case enabled = 0
    case disabled
    case nonApplicable
}

