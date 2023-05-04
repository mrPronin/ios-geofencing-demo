//
//  JourneyStorage+Mock.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 04.05.23.
//

import Foundation
@testable import ios_geofencing_demo

public extension Journey {
    class StorageServiceMock: JourneyStorageService {
        // MARK: - Public
        public var removeLocationsCalled: Bool = false
        public func add(location: Journey.Location) {}
        
        public var locations: [Journey.Location] = []
        
        public func removeLocations() {
            removeLocationsCalled = true
        }
    }
}
