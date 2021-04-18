//
//  Provider.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 27/3/21.
//

import Combine
import Foundation

protocol Provider {
    var session: URLSession { get }
}

extension Provider {
    func fetch(url: URL) -> AnyPublisher<Data, APIError> {
        session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                if error.code.rawValue == -1009 {
                    return .offline
                }
                return .network(code: error.code.rawValue, description: error.localizedDescription)
            }
            .map(\.data)
            .eraseToAnyPublisher()
    }
}

protocol APIResource {
    associatedtype Response: Decodable
    var serverPath: String { get }
    var methodPath: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension APIResource {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = serverPath
        components.path = methodPath
        components.queryItems = queryItems
        return components.url
    }
}

enum APIError: Error {
    case offline
    case network(code: Int, description: String)
    case invalidRequest(description: String)
    case unknown
}
