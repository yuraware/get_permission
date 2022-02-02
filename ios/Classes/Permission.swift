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
    case notificationOptions
    case notificationOptionAlert
    case notificationOptionBadge
    case notificationOptionSound
    case notificationOptionCarPlay
    case notificationOptionCriticalAlert
    case notificationOptionProvisional
    case notificationOptionAnnouncement
    case notificationOptionTimeSensitive
    case appTrackingTransparency
    case calendar
    case reminder
    case speech
    case locationAlways
    case locationWhenInUse
    case photos
    case photosWriteOnlyIOS
    case mediaLibrary
    case phone
}

enum NotificationOption: Int {
    case alert
    case badge
    case sound
    case carPlay
    case criticalAlert
    case provisional
    case announcement
    case timeSensitive
}

enum PermissionStatus: Int {
    case denied = 0
    case authorized
    case restricted
    case limited
    case permanentlyDenied // Not used on iOS
    case notSupported // In case of OS version does not supports permission
}

enum PermissionAvailability: Int {
    case enabled = 0
    case disabled
    case nonApplicable
}

