//
//  Endpoint.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public struct Endpoint<Kind: EndpointKind, Response: Codable, Payload: Encodable> {
    let method: Network.HTTPMethod
    let path: String
    let queryItems: [URLQueryItem]?
    let payload: Payload?
    public init(
        path: String,
        method: Network.HTTPMethod = .get,
        queryItems: [URLQueryItem]? = nil,
        payload: Payload? = nil
    ) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.payload = payload
    }
}

public extension Endpoint {
    func makeRequest(with data: Kind.RequestData?, host: URLHost = .default) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host.rawValue
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let payload = payload, let payloadData = try? JSONEncoder().encode(payload) {
            request.httpBody = payloadData
        }
        // TODO: inject required headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let data = data {
            Kind.prepare(&request, with: data)
        }
        return request
    }
}

