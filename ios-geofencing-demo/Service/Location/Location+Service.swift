//
//  Location+Service.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation
import CoreLocation
import Combine

public extension Location {
    class Service: NSObject, ObservableObject, LocationService {
        public var didUpdateLocation: AnyPublisher<CLLocation, Never> { _didUpdateLocation.eraseToAnyPublisher() }
        public var didFailWithError: AnyPublisher<Error, Never> { _didFailWithError.eraseToAnyPublisher() }
        public var locationManagerDidChangeAuthorization: AnyPublisher<CLLocationManager, Never> { _locationManagerDidChangeAuthorization.eraseToAnyPublisher() }
        public var didExitRegion: AnyPublisher<CLRegion, Never> { _didExitRegion.eraseToAnyPublisher() }
        
        
        // MARK: - Public
        public func requestLocation() { locationManager.requestLocation() }
        
        public func startMonitoring(for region: CLRegion) {
            guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
                _didFailWithError.send(Location.Errors.geofencingIsNotSupported)
                return
            }
            locationManager.startMonitoring(for: region)
        }
        
        public func stopMonitoring() {
            locationManager.monitoredRegions.forEach { [weak self] region in
                self?.locationManager.stopMonitoring(for: region)
            }
        }
        
        // MARK: - Init
        override init() {
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.allowsBackgroundLocationUpdates = true
            
            super.init()
            locationManager.delegate = self
        }

        // MARK: - Private
        private let locationManager: CLLocationManager
        
        private let _didUpdateLocation = PassthroughSubject<CLLocation, Never>()
        private let _didFailWithError = PassthroughSubject<Error, Never>()
        private let _locationManagerDidChangeAuthorization = PassthroughSubject<CLLocationManager, Never>()
        private let _didExitRegion = PassthroughSubject<CLRegion, Never>()
    }
}

// MARK: - CLLocationManagerDelegate

extension Location.Service: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        _didUpdateLocation.send(location)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        _didFailWithError.send(Location.Errors.locationManagerFailedWith(localizedDescription: error.localizedDescription))
    }
    
    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        guard let region = region else {
            _didFailWithError.send(Location.Errors.monitoringFailedFor(region: "unknown"))
            return
          }
        _didFailWithError.send(Location.Errors.monitoringFailedFor(region: region.identifier))
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus != .authorizedAlways {
            _didFailWithError.send(Location.Errors.notAuthorizedAlways)
            return
        }
    }
}
