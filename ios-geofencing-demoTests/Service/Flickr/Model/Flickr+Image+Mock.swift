//
//  Flickr+Image+Mock.swift
//  ios-geofencing-demoTests
//
//  Created by Pronin Oleksandr on 04.05.23.
//

import Foundation
@testable import ios_geofencing_demo

extension Flickr.Image {
    static var mocked: [Flickr.Image] {
        let testBundle = Bundle(for: JourneyViewModelTest.self)
        guard let path = testBundle.path(forResource: "flickr-mocked-response", ofType: "json") else {
            preconditionFailure()
        }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) else {
            preconditionFailure()
        }
        guard let decodedData = try? JSONDecoder().decode([Flickr.Image].self, from: jsonData) else {
            preconditionFailure()
        }
        return decodedData
    }
}
