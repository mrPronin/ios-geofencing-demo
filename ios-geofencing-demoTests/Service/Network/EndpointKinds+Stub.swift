//
//  EndpointKinds+Stub.swift
//  ios-geofencing-demoTests
//
//  Created by Pronin Oleksandr on 04.05.23.
//

import Foundation
@testable import ios_geofencing_demo

extension EndpointKinds {
    enum Stub: EndpointKind {
        static func prepare(_ request: inout URLRequest, with data: Void) {
            // No-op
        }
    }
}

