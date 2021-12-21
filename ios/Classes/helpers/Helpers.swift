//
//  Helpers.swift
//  get_permission
//
//  Created by Yuri on 21.12.2021.
//

import Foundation

protocol ArgumentsParser: Any {}

extension ArgumentsParser {
    func parseInt() -> Int? {
        if ((self as? Int) != nil) {
            return self as? Int
        }
        return nil
    }
}
