//
//  Flickr+Protocol.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation
import Combine

public protocol FlickrService {
    func imagesFor(locations: [(latitude: Double, longitude: Double)]) -> AnyPublisher<[Flickr.Image], Error>
}
