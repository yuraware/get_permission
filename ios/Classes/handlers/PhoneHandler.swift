//
//  PhoneHandler.swift
//  get_permission
//
//  Created by Yuri on 02.02.2022.
//

import Foundation

import CoreTelephony

class PhoneHandler: HandlerProtocol {
    
    func checkStatus(_ type: PermissionType, options: [Int]?) -> PermissionStatus {
        return status(from: type)
    }
    
    func availableCalls(with carrier: CTCarrier?) -> Bool {
        guard let carrier = carrier,
              let networkCode = carrier.mobileNetworkCode,
              networkCode.isEmpty, networkCode != "65535" else {
            return false
        }
        return true
    }
    
    func avaialbePhoneCalls() -> Bool {
        let network = CTTelephonyNetworkInfo()
        if #available(iOS 12.0, *) {
            let providers = network.serviceSubscriberCellularProviders
            return !(providers?.filter({ provider in
                return availableCalls(with: providers?[provider.key])
            }).isEmpty ?? false)
        } else {
            return availableCalls(with: network.subscriberCellularProvider)
        }
    }
    
    func checkAvailability(_ type: PermissionType, completion: (PermissionAvailability) -> ()) {
        guard let url = URL(string: "tel://"), UIApplication.shared.canOpenURL(url) else {
            completion(.disabled)
            return
        }
        
        completion(.enabled)
    }
    
    func request(_ type: PermissionType, options: [Int]?, completion: @escaping (PermissionStatus) -> ()) {
        completion(.notSupported)
    }
    
    func status(from type: PermissionType) -> PermissionStatus {
        return .notSupported
    }
}
