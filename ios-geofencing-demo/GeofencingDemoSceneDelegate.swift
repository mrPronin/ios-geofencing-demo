//
//  GeofencingDemoSceneDelegate.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 25.04.23.
//

import UIKit
import Combine
import CoreLocation

class GeofencingDemoSceneDelegate: NSObject, UIWindowSceneDelegate {
    @Injected(\.locationProvider) private var locationService: LocationService
    @Injected(\.journeyStorageProvider) private var journeyStorageService: JourneyStorageService
    @Injected(\.locationLogProvider) private var locationLogService: LocationLogService
    private var subscriptions = Set<AnyCancellable>()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        locationService.didExitRegion
            .sink { [weak self] region in
                if let circularRegion = region as? CLCircularRegion {
                    self?.locationLogService.add(logItem: "didExitRegion lat:\n\(circularRegion.center.latitude)\nlon: \(circularRegion.center.longitude)")
                }
                print("region: \(region.identifier)")
                self?.locationService.stopMonitoring()
                self?.locationService.requestLocation()
            }
            .store(in: &subscriptions)
        
        locationService.didUpdateLocation
            .map { Journey.Location(coordinate: $0.coordinate) }
            .sink { [weak self] location in
                guard location.coordinate != self?.journeyStorageService.locations.last?.coordinate else { return }
                self?.locationLogService.add(logItem: "didUpdateLocation lat:\n\(location.coordinate.latitude)\nlon: \(location.coordinate.longitude)")
                print("coordinate: \(location.coordinate)")
                self?.journeyStorageService.add(location: location)
                self?.locationService.startMonitoring(for: location.region)
            }
            .store(in: &subscriptions)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
}
