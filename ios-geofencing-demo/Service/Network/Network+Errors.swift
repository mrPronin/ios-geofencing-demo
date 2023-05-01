//
//  Network+Errors.swift
//  ios-geofencing-demo
//
//  Created by Pronin Oleksandr on 01.05.23.
//

import Foundation

public extension Network {
    enum Errors: Error, Equatable {
        case invalidURL
        case badRequest
        case unauthorized
        case forbidden
        case notFound
        case error4xx(_ code: Int)
        case serverError
        case error5xx(_ code: Int)
        case decodingError
        case urlSessionFailed(_ error: URLError)
        case unknownError(_ code: Int)
        case other(description: String)
    }
    static func error(from statusCode: Int) -> Errors {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError(statusCode)
        }
    }
}

// MARK: - LocalizedError
extension Network.Errors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "network_error_invalid_url".localized
        case .badRequest: return "network_error_bad_request".localized
        case .unauthorized: return "network_error_unauthorized".localized
        case .forbidden: return "network_error_forbidden".localized
        case .notFound: return "network_error_link_not_found".localized
        case .error4xx(let code): return "network_error_with_code".localized(with: "\(code)")
        case .serverError: return "network_error_server_exception".localized
        case .error5xx(let code): return "network_error_with_code".localized(with: "\(code)")
        case .decodingError: return "network_error_decoding_failed".localized
        case .urlSessionFailed(let error): return "network_error_url_session_failed_with_error".localized(with: error.localizedDescription)
        case .unknownError: return "network_error_unknown".localized
        case .other(description: let description): return "network_error_other".localized(with: description)
        }
    }
}
