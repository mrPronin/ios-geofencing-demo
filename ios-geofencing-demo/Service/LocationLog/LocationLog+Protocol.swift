//
//  LocationLog+Protocol.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation

public protocol LocationLogService {
    func add(logItem: String)
    var logs: [String] { get }
    func removeLogs()
}
