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
                    self?.locationLogService.add(logItem: "didExitRegion \(Date()) lat: \(circularRegion.center.latitude) lon: \(circularRegion.center.longitude)")
                }
                print("region: \(region.identifier)")
                self?.locationService.stopMonitoring()
                self?.locationService.requestLocation()
            }
            .store(in: &subscriptions)
        
        locationService.didUpdateLocation
            .sink { [weak self] location in
                
                print("coordinate: \(location.coordinate)")
                
                if let lastJourneyLocation = self?.journeyStorageService.locations.last {
                    let lastLocation = CLLocation(
                        latitude: lastJourneyLocation.coordinate.latitude,
                        longitude: lastJourneyLocation.coordinate.longitude
                    )
                    let distance = location.distance(from: lastLocation)
                    
                    if distance < CLLocationDistance(Constants.trackingRadius) {
                        return
                    }
                    if location.coordinate == lastJourneyLocation.coordinate {
                        return
                    }
                }

                self?.locationLogService.add(logItem: "didUpdateLocation \(Date()) lat: \(location.coordinate.latitude) lon: \(location.coordinate.longitude)")
                
                let journeyLocation = Journey.Location(coordinate: location.coordinate)
                self?.journeyStorageService.add(location: journeyLocation)
                self?.locationService.startMonitoring(for: journeyLocation.region)
            }
            .store(in: &subscriptions)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
}
