//
//  LocationHandler.swift
//  get_permission
//
//  Created by Yuri on 22.01.2022.
//

import Foundation
import CoreLocation

// Use a reference https://developer.apple.com/documentation/eventkit/accessing_the_event_store
// Remember to add the NSLocationWhenInUseUsageDescription,
// NSLocationAlwaysAndWhenInUseUsageDescription,
// NSLocationUsageDescription (MacOS not supported),
// NSLocationAlwaysUsageDescription
// to your app’s Info.plist file
//
class LocationHandler: NSObject, HandlerProtocol {
    
    private let locationManager = CLLocationManager()
    private var permissionType: PermissionType?
    
    private var requestCompletion: ((PermissionStatus) -> ())?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus {
        return CLLocationManager.locationServicesEnabled() ? .authorized : .denied
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
        
        permissionType = type
        
        requestCompletion = completion
        switch type {
        case .locationWhenInUse:
            locationManager.requestWhenInUseAuthorization()
        case .locationAlways:
            locationManager.requestAlwaysAuthorization()
        default:
            fatalError("Not supported permission type")
        }        
    }

    func permissionStatus(from authStatus: CLAuthorizationStatus) -> PermissionStatus {
        switch authStatus {
        case .authorized:
            return .authorized
        case .restricted:
            return .restricted
        case .denied, .notDetermined:
            return .denied
        case .authorizedAlways:
            return permissionType == .locationAlways ? .authorized : .denied
        case .authorizedWhenInUse:
            return permissionType == .locationWhenInUse ? .authorized : .denied
        @unknown default:
            fatalError("Not supported status in ATTrackingManager.AuthorizationStatus")
        }
    }
}

extension LocationHandler: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        requestCompletion?(permissionStatus(from: status))
    }
}
