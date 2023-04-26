//
//  JourneyViewModel.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 26.04.23.
//

import SwiftUI
import CoreLocation

public extension Journey {
    class ViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        // MARK: - Public
        @Published private(set) public var isLocationTrackingEnabled = false
        public func startStopLocationTracking() {
            isLocationTrackingEnabled.toggle()
            if isLocationTrackingEnabled {
                enable()
            } else {
                disable()
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
        func enable() {
            locationManager.requestLocation()
//            locationManager.startUpdatingLocation()
        }
        
        func disable() {
            // TODO: disable location tracking
        }
        
        // MARK: - CLLocationManagerDelegate
        public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            // TODO: implement alert if != authorizedAlways
        }
        
        public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else { return }
            print("coordinate: \(location.coordinate)")
        }
        
        public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
            // TODO: implement error handling
        }
        
        public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            // TODO: implement error handling
        }
        
        let locationManager: CLLocationManager
        
    }
}
