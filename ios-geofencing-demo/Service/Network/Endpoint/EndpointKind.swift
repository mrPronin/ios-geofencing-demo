//
//  EndpointKind.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public protocol EndpointKind {
    associatedtype RequestData
    static func prepare(_ request: inout URLRequest, with data: RequestData)
}

public enum EndpointKinds {
    public enum Public: EndpointKind {
        public static func prepare(_ request: inout URLRequest, with _: Void) {
            // Here we can do things like assign a custom cache
            // policy for loading our publicly available data.
        }
    }
    
    public enum Private: EndpointKind {
        public static func prepare(_ request: inout URLRequest, with token: AccessToken) {
            // Here we can attach authentication data
            request.addValue("Bearer \(token.rawValue)", forHTTPHeaderField: "Authorization")
        }
    }
}
