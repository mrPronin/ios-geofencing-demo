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
    class ViewModel: ObservableObject {
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
        
        @Published public var images: [Flickr.Image] = []
        public func loadImages() {
            let locations = journeyStorageService.locations.map { (latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude) }
            guard !locations.isEmpty else {
                images = []
                return
            }
            flickrService.imagesFor(locations: locations)
                .receive(on: DispatchQueue.main)
                .catch { [weak self] (error) -> Just<[Flickr.Image]> in
                    self?.alert = AlertData(title: "Error", message: error.localizedDescription)
                    return Just([])
                }
                .assign(to: &$images)
        }
        
        // MARK: - Init
        init() {
            locationService.didFailWithError
                .receive(on: DispatchQueue.main)
                .map { AlertData(title: "Error", message: $0.localizedDescription) }
                .assign(to: &$alert)
        }
        
        // MARK: - Private
        private func enable() {
            locationService.stopMonitoring()
            journeyStorageService.removeLocations()
            locationService.requestLocation()
            
            images = []
        }
        
        private func disable() {
            locationService.stopMonitoring()
        }
        
        @Injected(\.flickrService) private var flickrService: FlickrService
        @Injected(\.journeyStorageProvider) private var journeyStorageService: JourneyStorageService
        @Injected(\.locationProvider) private var locationService: LocationService
    }
}

public struct AlertData: Identifiable {
    public let id = UUID()
    public let title: String
    public let message: String
}
