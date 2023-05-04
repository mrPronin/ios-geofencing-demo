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
        // MARK: - Public
        public func imagesFor(locations: [(latitude: Double, longitude: Double)]) -> AnyPublisher<[Flickr.Image], Error> {
            let empty = Just<[Flickr.Image]>([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
            guard let url = Bundle.main.url(forResource: "flickr-mocked-response", withExtension: "json") else { return empty }
            guard let jsonData = try? Data(contentsOf: url) else { return empty }
            do {
                let decodedData = try JSONDecoder().decode([Flickr.Image].self, from: jsonData)
                return Just(decodedData)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch {
                print(error)
                return empty
            }
        }
    }
}
