//
//  Environment.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 07.05.23.
//

import Foundation

public enum ProjectEnvironment {}

extension ProjectEnvironment {
    enum Key: String {
        case flickrAPIKey = "FLICKR_API_KEY"
    }
}

extension ProjectEnvironment {
    static func string(forKey key: Key) -> String {
        guard let value = ProcessInfo.processInfo.environment[key.rawValue] else {
            fatalError("Environment variable \(key.rawValue) undefined!")
        }
        return value
    }
}
