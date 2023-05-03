//
//  LocationService+Protocol.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation
import CoreLocation
import Combine

public protocol LocationService {
    func requestLocation()
    func startMonitoring(for region: CLRegion)
    func stopMonitoring()
    var didUpdateLocation: AnyPublisher<CLLocation, Never> { get }
    var didFailWithError: AnyPublisher<Error, Never> { get }
    var locationManagerDidChangeAuthorization: AnyPublisher<CLLocationManager, Never> { get }
    var didExitRegion: AnyPublisher<CLRegion, Never> { get }
    func startUpdatingLocation()
    func stopUpdatingLocation()
}
