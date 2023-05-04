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
        // MARK: - Public
        public func imagesFor(locations: [(latitude: Double, longitude: Double)]) -> AnyPublisher<[Flickr.Image], Error> {
            let fetchRequests = locations.map { location -> AnyPublisher<Flickr.Image?, Error> in
                flickrPhotosSearch(latitude: location.latitude, longitude: location.longitude)
                    .map { response -> Flickr.Image? in
                        response.photos.first
                    }
                    .eraseToAnyPublisher()
            }
            
            return Publishers.Sequence(sequence: fetchRequests)
                       .flatMap { $0 }
                       .collect()
                       .map { fetchedImages in
                           fetchedImages.compactMap { $0 }
                       }
                       .eraseToAnyPublisher()
        }
        // MARK: - Private
        public func flickrPhotosSearch(latitude: Double, longitude: Double) -> AnyPublisher<Flickr.PagedPhotosResponse, Error> {
            return URLSession.shared.publisher(for: .flickrPhotosSearch(latitude: latitude, longitude: longitude))
                .eraseToAnyPublisher()
        }
    }
}
