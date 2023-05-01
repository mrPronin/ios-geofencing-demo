//
//  Localization+localized.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

// TODO: replace mocked implementation
public extension String {
    var localized: String {
        self
        //NSLocalizedString(self, bundle: .module, comment: "")
    }
    func localized(with argument: String) -> String {
        String(format: self, "\(argument)")
        //return String.localizedStringWithFormat(NSLocalizedString(self, bundle: .module, comment: ""), "\(argument)")
    }
}
