//
//  LocationStorage+Protocol.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation

public protocol JourneyStorageService {
    func addLocation(_ location: Journey.Location)
    var locations: [Journey.Location] { get }
    func removeLocations()
}
