//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by Daniel Ayala on 28/5/21.
//

import Intents
import Foundation
import SwiftUI


class IntentHandler: INExtension, CharacterSelectionIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        return self
    }
    
    
    func provideDGCharacters(for intent: CharacterSelectionIntent, with completion: @escaping (INObjectCollection<Character>?, Error?) -> Void) {
        
        var charactersList = [DGCharacter]()
        
        DGCharactersWidgetProvider.loadDGCharacters { response in
            switch response {
            case .Failure(let error):
                charactersList = [DGCharacter(id: error.localizedDescription, name: "Failed", bio: "UPS")]
            case .Success(let superSaiyanResponse):
                charactersList = superSaiyanResponse
            }
        }
        let characters: [Character] = charactersList.map { character in
            let hero = Character(identifier: character.id, display: character.name)

            return hero
        }
        
        let collection = INObjectCollection(items: characters)
        
        completion(collection, nil)
        
    }

    
}

enum DGCharactersProviderResponse {
    case Success(response: [DGCharacter])
    case Failure(error: Error)
}

struct DGCharactersModelResponse: Decodable {
    var characters: [DGCharacter]
}

struct DGCharacter: Decodable, Hashable {
    var id: String
    var name: String
    var bio: String
}

class DGCharactersWidgetProvider {
    static func loadDGCharacters(completion: ((DGCharactersProviderResponse) -> Void)?) {
        let urlString = "https://605cf4ab6d85de00170db5b1.mockapi.io/api/v1/characters"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            parseResponse(data: data, urlResponse: urlResponse, error: error, completion: completion)
        }
        task.resume()
    }
    
    static func parseResponse(data: Data?, urlResponse: URLResponse?, error: Error?, completion: ((DGCharactersProviderResponse) -> Void)?) {
        
        guard error == nil, let content = data else {
            print("error getting data from API")
            let response = DGCharactersProviderResponse.Failure(error: error!)
            completion?(response)
            return
        }
        
        var dCharactersModelResponse: DGCharactersModelResponse
        do {
            dCharactersModelResponse = try JSONDecoder().decode(DGCharactersModelResponse.self, from: content)
        } catch {
            print("error parsing URL from data")
            let response = DGCharactersProviderResponse.Failure(error: error)
            completion?(response)
            return
        }
        
        completion?(DGCharactersProviderResponse.Success(response: dCharactersModelResponse.characters))

    }
}


