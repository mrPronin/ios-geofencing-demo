//
//  FlickrPagedPhotosResponse.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public extension Flickr {
    struct PagedPhotosResponse: Codable {
        private let wrappedResponse: WrapperPagedPhotosResponse

        var page: Int {
            wrappedResponse.page
        }

        var pages: Int {
            wrappedResponse.pages
        }

        var perPage: Int {
            wrappedResponse.perPage
        }

        var totalPhotos: Int {
            wrappedResponse.totalPhotos
        }

        var photos: [Flickr.Image] {
            wrappedResponse.photos
        }
        
        enum CodingKeys: String, CodingKey {
            case wrappedResponse = "photos"
        }
    }

}

private extension Flickr {
    private struct WrapperPagedPhotosResponse: Codable {
        let page: Int
        let pages: Int
        let perPage: Int
        let totalPhotos: Int
        let photos: [Flickr.Image]
        
        enum CodingKeys: String, CodingKey {
            case page, pages, perPage = "perpage", totalPhotos = "total", photos = "photo"
        }
    }
}

