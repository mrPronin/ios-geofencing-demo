//
//  Location+Errors.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 03.05.23.
//

import Foundation

public extension Location {
    enum Errors: Error, Equatable {
        case notAuthorizedAlways
        case geofencingIsNotSupported
        case monitoringFailedFor(region: String)
        case locationManagerFailedWith(localizedDescription: String)
    }
}

// MARK: - LocalizedError
extension Location.Errors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notAuthorizedAlways: return "location_not_authorized_always".localized
        case .geofencingIsNotSupported: return "location_geofencing_is_not_supported".localized
        case .monitoringFailedFor(region: let region): return "location_monitoring_failed_for_region".localized(with: region)
        case .locationManagerFailedWith(localizedDescription: let localizedDescription): return "location_failed_with_error".localized(with: localizedDescription)
        }
    }
}
