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
        @Published public var alert: AlertData?
        
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
        private func enable() {
            locationManager.requestLocation()
            
//            locationManager.startUpdatingLocation()
        }
        
        private func disable() {
            // TODO: disable location tracking
        }
        
        private func startMonitoring(location: Journey.Location) {
            guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
                alert = AlertData(title: "Error", message: "Geofencing is not supported on this device!")
                return
            }
            locationManager.startMonitoring(for: location.region)
        }
        
        private func stopMonitoring() {
            locationManager.monitoredRegions.forEach { [weak self] region in
                self?.locationManager.stopMonitoring(for: region)
            }
        }
        
        private let locationManager: CLLocationManager
        @Injected(\.flickrService) private var flickrService: FlickrService
        @Injected(\.journeyStorageProvider) private var journeyStorageService: JourneyStorageService
        
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
        
        // Define initial journey location
        let initialJourneyLocation = Journey.Location(coordinate: location.coordinate)
        journeyStorageService.add(location: initialJourneyLocation)
        
        startMonitoring(location: initialJourneyLocation)
        
        flickrService.flickrPhotosSearch(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            .sink(receiveCompletion: { print ("completion: \($0)") }, receiveValue: { model in
//                print(model.photos.first)
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
        if manager.authorizationStatus != .authorizedAlways {
            let message = """
            Your journey will only be activated once you grant
            permission to access the device location.
            """
            alert = AlertData(title: "Warning", message: message)
          }
    }
}

public struct AlertData: Identifiable {
    public let id = UUID()
    public let title: String
    public let message: String
}
