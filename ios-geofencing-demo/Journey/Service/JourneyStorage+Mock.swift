//
//  JourneyStorage+Mock.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 04.05.23.
//

import Foundation
@testable import ios_geofencing_demo

public extension Journey {
    struct StorageServiceMock: JourneyStorageService {
        // MARK: - Public
        public func add(location: Journey.Location) {}
        
        public var locations: [Journey.Location] {
            guard let url = Bundle.main.url(forResource: "mocked-journey", withExtension: "json") else { return [] }
            guard let jsonData = try? Data(contentsOf: url) else { return [] }
            do {
                let decodedData = try JSONDecoder().decode([Journey.Location].self, from: jsonData)
                return decodedData
            } catch {
                print(error)
                return []
            }
        }
        
        public func removeLocations() {}
    }
}
