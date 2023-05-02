//
//  Endpoint+flickrPhotosSearch.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

extension Endpoint where Kind == EndpointKinds.Public, Response == Flickr.PagedPhotosResponse, Payload == String {
    static func flickrPhotosSearch(latitude: Double, longitude: Double) -> Self {
        let parameters = [
            "method" : "flickr.photos.search",
            "api_key" : Constants.flickrAPIKey,
            "lat" : String(latitude),
            "lon" : String(longitude),
            "format" : "json",
            "content_type" : "1",
            "media" : "photos",
            "geo_context" : "2",
            "radius" : "2",
            "extras" : "url_c",
            "per_page" : "1",
            "nojsoncallback" : "1"
        ]
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return Endpoint(
            path: "services/rest",
            queryItems: queryItems
        )
    }
}
