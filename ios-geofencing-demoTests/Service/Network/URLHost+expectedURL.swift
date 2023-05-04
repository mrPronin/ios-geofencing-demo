//
//  URLHost+expectedURL.swift
//  ios-geofencing-demoTests
//
//  Created by Pronin Oleksandr on 04.05.23.
//

import Foundation
@testable import ios_geofencing_demo
import XCTest

public extension URLHost {
    func expectedURL(withPath path: String) throws -> URL {
        let url = URL(string: "https://" + rawValue + "/" + path)
        return try XCTUnwrap(url)
    }
}
