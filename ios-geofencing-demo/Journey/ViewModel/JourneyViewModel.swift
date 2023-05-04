//
//  JourneyViewModel.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 26.04.23.
//

import SwiftUI
import CoreLocation
import Combine

public protocol JourneyViewModel: ObservableObject {
    var isLocationTrackingEnabled: Bool { get }
    var alert: AlertData? { get set }
    var images: [Flickr.Image] { get }
    var isLoading: Bool { get }
    var isJourneyExist: Bool { get }
    
    func startStopLocationTracking()
    func loadImages()
    func loadJourney()
}

public extension Journey {
    class ViewModel: JourneyViewModel {
        // MARK: - Public
        @Published private(set) public var isLocationTrackingEnabled = false
        @Published public var alert: AlertData?
        
        @Published private(set) public var images: [Flickr.Image] = []
        @Published private(set) public var isLoading = false
        
        @Published private(set) public var isJourneyExist: Bool = false
        
        public func startStopLocationTracking() {
            isLocationTrackingEnabled.toggle()
            if isLocationTrackingEnabled {
                enable()
            } else {
                disable()
            }
        }
        public func loadImages() {
            let locations = journeyStorageService.locations.map { (latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude) }
            guard !locations.isEmpty else {
                images = []
                return
            }
            isLoading = true
            flickrService.imagesFor(locations: locations)
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                })
                .catch { [weak self] (error) -> Just<[Flickr.Image]> in
                    self?.alert = AlertData(title: "Error", message: error.localizedDescription)
                    return Just([])
                }
//                .handleEvents(receiveOutput: { images in
//                    print(images)
//                })
                .assign(to: &$images)
        }
        public func loadJourney() {
            isJourneyExist = !journeyStorageService.locations.isEmpty
        }

        // MARK: - Init
        public init() {
            locationService.didFailWithError
                .receive(on: DispatchQueue.main)
                .map { AlertData(title: "Error", message: $0.localizedDescription) }
                .assign(to: &$alert)
        }
        
        // MARK: - Private
        private func enable() {
            journeyStorageService.removeLocations()
            locationService.stopMonitoring()
            locationService.requestLocation()
            
            images = []
        }
        
        private func disable() {
            locationService.stopMonitoring()
        }
        
        // MARK: - Dependency injection
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
