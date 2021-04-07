//
//  CharactersViewModel.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 27/3/21.
//

import Foundation
import Combine

private var cancellables = Set<AnyCancellable>()


class CharactersViewModel: ObservableObject {
    let charactersProvider = CharactersProvider()
    @Published var response: CharactersProviderResource.Response?

    func fetchCharacterList() {
        charactersProvider.fetchAPIResource(CharactersProviderResource())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
                switch $0 {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Request completed")
                }
            }, receiveValue: {
                self.response = $0
            })
            .store(in: &cancellables)
    }
}
