//
//  CharactersView.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 27/3/21.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var viewModel = CharactersViewModel()
    @State var firstAppear: Bool = true
        
    var body: some View {
        NavigationView {
            List(self.viewModel.response?.characters ?? [CharactersProviderResource.Charcacter(id: "", name: "placeholder", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc pellentesque egestas risus, in convallis ex fringilla quis. Cras iaculis leo ipsum, sed molestie metus tincidunt at. Morbi ullamcorper justo vel nulla sollicitudin, eget euismod ipsum semper. Nullam condimentum, ante congue eleifend placerat, quam justo rhoncus eros, eu ornare tellus purus in metus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In id enim ullamcorper, eleifend diam non, vulputate diam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras tincidunt quam ex, at euismod turpis gravida at. Donec eu malesuada elit. Proin vel elementum libero, ac porttitor lectus TEST.")]) { character in
                VStack {
                    if character.name == "placeholder" {
                        Text(character.name)
                            .redacted(reason: .placeholder)
                        Spacer()
                        Text(character.bio)
                            .redacted(reason: .placeholder)
                    }else{
                        Text(character.name)
                            .bold()
                            .font(.largeTitle)
                        Spacer()
                        Text(character.bio)
                            .font(.title3)
                    }
                    HStack {
                        TextField("Placeholderrrrr", text: .constant(""))
                        Divider()
                        TextField("Placeholder", text: .constant(""))
                    }
                    
                }
            }.onAppear(perform: {
                if !self.firstAppear { return }
                self.firstAppear = false
                self.viewModel.fetchCharacterList()
            }).navigationTitle("Dragon Ball Characters")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
