//
//  Localization+Service.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public extension Localization {
    struct Service: LocalizationService {
        public init() {}
        public func localizedString(with key: String) -> String {
            /*
             In the future, it will be possible to download a file with localized thongs from a secure repository and be able to change it without publishing a new release.
            */
            NSLocalizedString(key, comment: "")
        }
    }
}
