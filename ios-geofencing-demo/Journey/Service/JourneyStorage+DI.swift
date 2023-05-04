//
//  JourneyStorage+DI.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation

private struct JourneyStorageProviderKey: InjectionKey {
    static var currentValue: JourneyStorageService = Journey.StorageService()
}

extension InjectedValues {
    var journeyStorageProvider: JourneyStorageService {
        get { Self[JourneyStorageProviderKey.self] }
        set { Self[JourneyStorageProviderKey.self] = newValue }
    }
}
