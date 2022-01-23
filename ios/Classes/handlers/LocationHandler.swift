//
//  LocationHandler.swift
//  get_permission
//
//  Created by Yuri on 22.01.2022.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, HandlerProtocol {
    
    let locationManager = CLLocationManager()
    
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
            return .authorized
        case .authorizedWhenInUse:
            return .authorized
        @unknown default:
            fatalError("Not supported status in ATTrackingManager.AuthorizationStatus")
        }
    }
}

extension LocationHandler: CLLocationManagerDelegate {
    
}