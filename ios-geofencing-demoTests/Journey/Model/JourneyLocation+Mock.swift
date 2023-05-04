//
//  JourneyLocation+Mock.swift
//  ios-geofencing-demoTests
//
//  Created by Pronin Oleksandr on 04.05.23.
//

import Foundation
@testable import ios_geofencing_demo

extension Journey.Location {
    static var mocked: [Journey.Location] {
        let testBundle = Bundle(for: JourneyViewModelTest.self)
        guard let path = testBundle.path(forResource: "mocked-journey", ofType: "json") else {
            preconditionFailure()
        }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) else {
            preconditionFailure()
        }
        guard let decodedData = try? JSONDecoder().decode([Journey.Location].self, from: jsonData) else {
            preconditionFailure()
        }
        return decodedData
    }
}
