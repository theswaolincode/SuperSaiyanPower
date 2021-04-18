//
//  CharactersAPI.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 27/3/21.
//

import Combine
import Foundation

class CharactersProvider: Provider {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension CharactersProvider {
    struct ErrorResponse: Decodable {
        let error: String
    }
}

extension CharactersProvider {
    func fetchAPIResource<Resource>(_ resource: Resource) -> AnyPublisher<Resource.Response, APIError> where Resource: APIResource {
        guard let url = resource.url else {
            let error = APIError.invalidRequest(description: "Invalid `resource.url`: \(String(describing: resource.url))")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return fetch(url: url)
            .flatMap(decode)
            .eraseToAnyPublisher()
    }

    func decode<Response>(data: Data) -> AnyPublisher<Response, APIError> where Response: Decodable {
        if let response = try? JSONDecoder().decode(Response.self, from: data) {
            return Just(response).setFailureType(to: APIError.self).eraseToAnyPublisher()
        }
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            return Fail(error: .invalidRequest(description: errorResponse.error)).eraseToAnyPublisher()
        } catch {
            return Fail(error: .unknown).eraseToAnyPublisher()
        }
    }
}

struct CharactersProviderResource: APIResource {
    let serverPath = "605cf4ab6d85de00170db5b1.mockapi.io"
    let methodPath: String
    var queryItems: [URLQueryItem]?

    init() {
        methodPath = "/api/v1/characters"
    }
}

extension CharactersProviderResource {
    struct Response: Decodable{
        let characters: [Charcacter]
        
        init(characters: [Charcacter]) {
            self.characters = characters
        }
    }
    
    struct Charcacter: Decodable, Identifiable{
        var id: String
        let name: String
        let bio: String


        init(id: String, name: String, bio: String) {
            self.id = id
            self.name = name
            self.bio = bio
        }
    }
}

extension CharactersProviderResource {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
