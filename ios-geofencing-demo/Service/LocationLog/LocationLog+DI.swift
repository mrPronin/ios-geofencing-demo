//
//  LocationLog+DI.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation

private struct LocationLogProviderKey: InjectionKey {
    static var currentValue: LocationLogService = LocationLog.Service()
}

extension InjectedValues {
    var locationLogProvider: LocationLogService {
        get { Self[LocationLogProviderKey.self] }
        set { Self[LocationLogProviderKey.self] = newValue }
    }
}
