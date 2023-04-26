//
//  JourneyViewModel.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 26.04.23.
//

import SwiftUI

public extension Journey {
    class ViewModel: ObservableObject {
        // MARK: - Public
        @Published private(set) public var isLocationTrackingEnabled = false
        public func startStopLocationTracking() {
            isLocationTrackingEnabled.toggle()
            if isLocationTrackingEnabled {
              enable()
            } else {
              disable()
            }
        }
        
        // MARK: - Private

        func enable() {
        }

        func disable() {
        }

    }
}
