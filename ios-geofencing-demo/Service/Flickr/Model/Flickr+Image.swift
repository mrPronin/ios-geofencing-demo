//
//  FlickrImage.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public extension Flickr {
    struct Image: Codable {
        let id: String
        let title: String
        let url: URL?
        let height: CGFloat
        let width: CGFloat
        
        private enum CodingKeys: String, CodingKey {
            case id, title, url = "url_c", height = "height_c", width = "width_c"
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            url = try container.decode(URL.self, forKey: .url)
            height = try container.decode(CGFloat.self, forKey: .height)
            width = try container.decode(CGFloat.self, forKey: .width)
        }
    }
}

