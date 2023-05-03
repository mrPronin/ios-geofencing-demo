//
//  JourneyLocation.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 26.04.23.
//

import Foundation
import CoreLocation

public extension Journey {
    struct Location: Codable {
        // MARK: - Public
        let identifier: UUID
        let coordinate: CLLocationCoordinate2D
        
        // MARK: - Codable
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let latitude = try container.decode(Double.self, forKey: .latitude)
            let longitude = try container.decode(Double.self, forKey: .longitude)
            coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            identifier = try container.decode(UUID.self, forKey: .identifier)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(coordinate.latitude, forKey: .latitude)
            try container.encode(coordinate.longitude, forKey: .longitude)
            try container.encode(identifier, forKey: .identifier)
        }
        
        // MARK: - Init
        init(coordinate: CLLocationCoordinate2D) {
            identifier = UUID()
            self.coordinate = coordinate
        }
        
        // MARK: - Private
        private enum CodingKeys: String, CodingKey {
          case latitude, longitude, identifier
        }
    }
}

// MARK: - Tracking region
public extension Journey.Location {
    var region: CLCircularRegion {
      let region = CLCircularRegion(
        center: coordinate,
        radius: CLLocationDistance(Constants.trackingRadius),
        identifier: identifier.uuidString
      )

      region.notifyOnEntry = false
      region.notifyOnExit = true
      return region
    }
}
