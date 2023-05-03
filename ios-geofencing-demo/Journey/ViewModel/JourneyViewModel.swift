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
        
        // MARK: - Init
        init() {
            locationService.didUpdateLocation
                .sink { [weak self] location in
                    print("coordinate: \(location.coordinate)")
                    
                    // Define initial journey location
                    let initialJourneyLocation = Journey.Location(coordinate: location.coordinate)
                    self?.journeyStorageService.add(location: initialJourneyLocation)
                    self?.locationService.startMonitoring(for: initialJourneyLocation.region)
                }
                .store(in: &subscriptions)
            
            locationService.didFailWithError
                .receive(on: DispatchQueue.main)
                .sink { [weak self] error in
                    self?.alert = AlertData(title: "Error", message: error.localizedDescription)
                }
                .store(in: &subscriptions)

//            flickrService.flickrPhotosSearch(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//                .sink(receiveCompletion: { print ("completion: \($0)") }, receiveValue: { model in
//                    print(model.photos.first)
//                })
//                .store(in: &subscriptions)
        }
        
        // MARK: - Private
        private func enable() {
            locationService.stopMonitoring()
            journeyStorageService.removeLocations()
            locationService.requestLocation()
            
//            locationManager.startUpdatingLocation()
        }
        
        private func disable() {
            locationService.stopMonitoring()
        }
        
        @Injected(\.flickrService) private var flickrService: FlickrService
        @Injected(\.journeyStorageProvider) private var journeyStorageService: JourneyStorageService
        @Injected(\.locationProvider) private var locationService: LocationService
        
        var subscriptions = Set<AnyCancellable>()
    }
}

public struct AlertData: Identifiable {
    public let id = UUID()
    public let title: String
    public let message: String
}
