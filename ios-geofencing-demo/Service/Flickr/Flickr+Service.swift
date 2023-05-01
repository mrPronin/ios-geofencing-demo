//
//  Flickr+Service.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 02.05.23.
//

import Foundation
import Combine

public extension Flickr {
    struct Service: FlickrService {
        public func flickrPhotosSearch(latitude: Double, longitude: Double) -> AnyPublisher<Flickr.PagedPhotosResponse, Error> {
            return URLSession.shared.publisher(for: .flickrPhotosSearch(latitude: latitude, longitude: longitude))
                .eraseToAnyPublisher()
        }
    }
}
