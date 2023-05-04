//
//  Location+Mock.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 04.05.23.
//

import Foundation
import CoreLocation
import Combine
@testable import ios_geofencing_demo

public extension Location {
    class ServiceMock: LocationService {
        
        var error: Error?
        var location: CLLocation?
        var region: CLRegion?
        var stopMonitoringCalled: Bool = false
        var requestLocationCalled: Bool = false
        
        public func requestLocation() {
            requestLocationCalled = true
        }
        
        public func startMonitoring(for region: CLRegion) {}
        
        public func stopMonitoring() {
            stopMonitoringCalled = true
        }
        
        public var didUpdateLocation: AnyPublisher<CLLocation, Never> {
            if let location {
                return Just(location).eraseToAnyPublisher()
            }
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        
        public var didFailWithError: AnyPublisher<Error, Never> {
            if let error {
                return Just(error)
                    .eraseToAnyPublisher()
            }
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        
        public var locationManagerDidChangeAuthorization: AnyPublisher<CLLocationManager, Never> {
            Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        
        public var didExitRegion: AnyPublisher<CLRegion, Never> {
            if let region {
                return Just(region).eraseToAnyPublisher()
            }
            return Empty(completeImmediately: true).eraseToAnyPublisher()
        }
        
        public func startUpdatingLocation() {}
        
        public func stopUpdatingLocation() {}
    }
}
