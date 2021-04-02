//
//  SuperSaiyanProvider.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 31/3/21.
//

import Foundation
import SwiftUI

enum SuperSaiyanProviderResponse {
    case Success(response: [SuperSaiyanStage])
    case Failure(error: Error)
}

struct SuperSaiyanModelResponse: Decodable, Hashable {
    var ssstages: [SuperSaiyanStage]
}

struct SuperSaiyanStage: Decodable, Hashable {
    var ssURL: String
    var ssName: String
    var bio: String
}

class SuperSaiyanWidgetProvider {
    static func loadSaiyanStages(completion: ((SuperSaiyanProviderResponse) -> Void)?) {
        let urlString = "https://605cf4ab6d85de00170db5b1.mockapi.io/api/v1/characters"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            parseResponse(data: data, urlResponse: urlResponse, error: error, completion: completion)
        }
        task.resume()
    }
    
    static func parseResponse(data: Data?, urlResponse: URLResponse?, error: Error?, completion: ((SuperSaiyanProviderResponse) -> Void)?) {
        
        guard error == nil, let content = data else {
            print("error getting data from API")
            let response = SuperSaiyanProviderResponse.Failure(error: error!)
            completion?(response)
            return
        }
        
        var superSaiyanModelResponse: SuperSaiyanModelResponse
        do {
            superSaiyanModelResponse = try JSONDecoder().decode(SuperSaiyanModelResponse.self, from: content)
        } catch {
            print("error parsing URL from data")
            let response = SuperSaiyanProviderResponse.Failure(error: error)
            completion?(response)
            return
        }
        
        completion?(SuperSaiyanProviderResponse.Success(response: superSaiyanModelResponse.ssstages))

    }
}

