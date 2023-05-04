//
//  Flickr+Mock.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 04.05.23.
//

import Foundation
import Combine
@testable import ios_geofencing_demo

public extension Flickr {
    class ServiceMock: FlickrService {
        var images: [Flickr.Image] = []
        var error: Error?
        
        // MARK: - Public
        public func imagesFor(locations: [(latitude: Double, longitude: Double)]) -> AnyPublisher<[Flickr.Image], Error> {
            if let error {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            return Just(images)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
