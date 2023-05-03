//
//  GeofencingDemoSceneDelegate.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 25.04.23.
//

import UIKit
import Combine

class GeofencingDemoSceneDelegate: NSObject, UIWindowSceneDelegate {
    @Injected(\.locationProvider) private var locationService: LocationService
    @Injected(\.journeyStorageProvider) private var journeyStorageService: JourneyStorageService
    private var subscriptions = Set<AnyCancellable>()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        locationService.didExitRegion
            .sink { [weak self] region in
                self?.locationService.stopMonitoring()
                self?.locationService.requestLocation()
            }
            .store(in: &subscriptions)
        locationService.didUpdateLocation
            .map { Journey.Location(coordinate: $0.coordinate) }
            .sink { [weak self] location in
                self?.journeyStorageService.add(location: location)
                self?.locationService.startMonitoring(for: location.region)
            }
            .store(in: &subscriptions)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
}
