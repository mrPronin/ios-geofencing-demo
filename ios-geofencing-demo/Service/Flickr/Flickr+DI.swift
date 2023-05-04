//
//  Flickr+DI.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 02.05.23.
//

import Foundation

private struct FlickrProviderKey: InjectionKey {
    static var currentValue: FlickrService = Flickr.ServiceMock()
}

extension InjectedValues {
    var flickrService: FlickrService {
        get { Self[FlickrProviderKey.self] }
        set { Self[FlickrProviderKey.self] = newValue }
    }
}
