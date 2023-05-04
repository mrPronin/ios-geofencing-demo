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
        @Published public var logs: String = ""
        public func loadLogs() {
//            logs = locationLogService.logs.joined(separator: "\n\n")
            logs = journeyStorageService.locations.enumerated().map { "#\($0.offset)\nlat: \($0.element.coordinate.latitude)\nlon: \($0.element.coordinate.longitude)" }.joined(separator: "\n\n")
        }
        @Published public var distance: Double = 0
        
        // MARK: - Init
        init() {
            locationService.didUpdateLocation
                .sink { [weak self] location in
                    self?.loadLogs()
                    
                    if let firstJourneyLocation = self?.journeyStorageService.locations.first {
                        let firstLocation = CLLocation(latitude: firstJourneyLocation.coordinate.latitude, longitude: firstJourneyLocation.coordinate.longitude)
                        let distance = location.distance(from: firstLocation)
                        
                        self?.distance = distance
                    }
                }
                .store(in: &subscriptions)
            
            locationService.didExitRegion
                .sink { [weak self] region in
                    self?.loadLogs()
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
            
            logs = ""
            locationLogService.removeLogs()
            
//            locationService.startUpdatingLocation()
        }
        
        private func disable() {
            locationService.stopMonitoring()
            
//            locationService.stopUpdatingLocation()
        }
        
        @Injected(\.flickrService) private var flickrService: FlickrService
        @Injected(\.journeyStorageProvider) private var journeyStorageService: JourneyStorageService
        @Injected(\.locationProvider) private var locationService: LocationService
        @Injected(\.locationLogProvider) private var locationLogService: LocationLogService
        
        var subscriptions = Set<AnyCancellable>()
    }
}

public struct AlertData: Identifiable {
    public let id = UUID()
    public let title: String
    public let message: String
}
