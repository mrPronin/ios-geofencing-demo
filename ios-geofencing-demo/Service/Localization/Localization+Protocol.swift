//
//  Localization+Protocol.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public protocol LocalizationService {
    func localizedString(with key: String) -> String
}
