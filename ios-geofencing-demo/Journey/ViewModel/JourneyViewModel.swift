//
//  JourneyViewModel.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 26.04.23.
//

import SwiftUI
import CoreLocation
import Combine

public extension Journey {
    class ViewModel: NSObject, ObservableObject {
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
        
        private let locationManager: CLLocationManager
        @Injected(\.flickrService) private var flickrService: FlickrService
        
        // debug
        var subscriptions = Set<AnyCancellable>()
        // debug
    }
}

// MARK: - CLLocationManagerDelegate
extension Journey.ViewModel: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("coordinate: \(location.coordinate)")
        flickrService.flickrPhotosSearch(latitude: 52.47340827974928, longitude: 13.3443475205514)
            .sink(receiveCompletion: { print ("completion: \($0)") }, receiveValue: { model in
                print(model.photos.first)
            })
            .store(in: &subscriptions)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: implement error handling
    }
    
    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        // TODO: implement error handling
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // TODO: implement alert if != authorizedAlways
    }
}
