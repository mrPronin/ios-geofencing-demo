//
//  LocationLog+Service.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation

public extension LocationLog {
    struct Service: LocationLogService {
        // MARK: - Public
        public func add(logItem: String) {
            var savedLogs = logs
            savedLogs.append(logItem)
            save(logs: savedLogs)
        }
        
        public var logs: [String] {
            guard let savedData = UserDefaults.standard.data(forKey: StorageKeys.savedLogs.rawValue) else { return [] }
            if let savedLocations = try? JSONDecoder().decode(Array.self, from: savedData) as [String] {
              return savedLocations
            }
            return []
        }
        
        public func removeLogs() {
            UserDefaults.standard.set(nil, forKey: StorageKeys.savedLogs.rawValue)
        }
        
        // MARK: - Private
        private func save(logs: [String]) {
            do {
              let data = try JSONEncoder().encode(logs)
                UserDefaults.standard.set(data, forKey: StorageKeys.savedLogs.rawValue)
            } catch {
              print("encoding error")
            }
        }
    }
}
