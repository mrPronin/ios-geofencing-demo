//
//  Location+DI.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation

private struct LocationProviderKey: InjectionKey {
    static var currentValue: LocationService = Location.Service()
}

extension InjectedValues {
    var locationProvider: LocationService {
        get { Self[LocationProviderKey.self] }
        set { Self[LocationProviderKey.self] = newValue }
    }
}
