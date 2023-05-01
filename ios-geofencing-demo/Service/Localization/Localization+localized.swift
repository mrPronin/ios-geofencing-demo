//
//  Localization+localized.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public extension String {
    var localized: String {
        InjectedValues[\.localizationProvider].localizedString(with: self)
    }
    
    func localized(with argument: String) -> String {
        return String.localizedStringWithFormat(InjectedValues[\.localizationProvider].localizedString(with: self), "\(argument)")
    }
}
