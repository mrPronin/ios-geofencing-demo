//
//  LocationStorage+Service.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation

public extension Journey {
    struct StorageService: JourneyStorageService {
        // MARK: - Public
        public func addLocation(_ location: Journey.Location) {
            var savedLocations = locations
            savedLocations.append(location)
            save(locations: savedLocations)
        }
        
        public var locations: [Journey.Location] {
            guard let savedData = UserDefaults.standard.data(forKey: StorageKeys.savedJourneyLocations.rawValue) else { return [] }
            if let savedLocations = try? JSONDecoder().decode(Array.self, from: savedData) as [Location] {
              return savedLocations
            }
            return []
        }
        
        public func removeLocations() {
            UserDefaults.standard.set(nil, forKey: StorageKeys.savedJourneyLocations.rawValue)
        }
        
        // MARK: - Private
        private func save(locations: [Location]) {
            do {
              let data = try JSONEncoder().encode(locations)
                UserDefaults.standard.set(data, forKey: StorageKeys.savedJourneyLocations.rawValue)
            } catch {
              print("error encoding geotifications")
            }
        }
    }
}
