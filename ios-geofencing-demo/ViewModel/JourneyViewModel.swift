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
        }
        
        func disable() {
        }
        
        let locationManager: CLLocationManager
        
    }
}
