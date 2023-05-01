//
//  AccessToken.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public struct AccessToken: RawRepresentable {
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    public var rawValue: String
}
