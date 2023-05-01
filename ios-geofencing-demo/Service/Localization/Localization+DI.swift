//
//  Localization+ProviderKey.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

private struct LocalizationProviderKey: InjectionKey {
    static var currentValue: LocalizationService = Localization.Service()
}

extension InjectedValues {
    var localizationProvider: LocalizationService {
        get { Self[LocalizationProviderKey.self] }
        set { Self[LocalizationProviderKey.self] = newValue }
    }
}
