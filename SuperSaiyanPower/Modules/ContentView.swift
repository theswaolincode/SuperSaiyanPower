//
//  ContentView.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 17/3/21.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @State var activeUUID: UUID?
    
    @State private var isToggle : Bool = SuperSaiyanPowerStorage().getSuperSaiyanActiveState() ?? false
    
    var characters : [CharacterDetail] {
        return CharacterDetail.availableCharacters
    }
    
    var superSaiyanCharacters : [CharacterDetail] {
        return CharacterDetail.superSaiyanCharacters
    }
    
    var body: some View {
        
        NavigationView {
            List{
                Section(header: Text("Settings")) {
                    Toggle(isOn: $isToggle){
                        Text("Activate Super Saiyan Power !!! ")
                            .font(.title)
                            .foregroundColor(Color.white)
                        
                    }
                    .padding(.horizontal)
                    .background(isToggle ? Color.purple : Color.gray.opacity(0.5))
                    .cornerRadius(8.0)
                    .onChange(of: isToggle) { value in
                        SuperSaiyanPowerStorage().saveSuperSaiyanActiveState(isActive: isToggle)
                        WidgetCenter.shared.reloadTimelines(ofKind: "SuperSaiyanPowerWidget")
                        print(value)
                    }
                }
                
                Section(header: Text("Saiyans")) {
                    let charactersList = isToggle ? superSaiyanCharacters : characters
                    ForEach (charactersList) {character in
                        NavigationLink(destination: DetailView(character: character), tag: character.id, selection: $activeUUID){
                            TableRow(character: character)
                        }
                    }
                }
            }
            .navigationTitle("Super Saiyan Power")
            .onOpenURL(perform: { (url) in
                let charactersList = isToggle ? superSaiyanCharacters : characters
                guard let activeCharacter = charactersList.filter({$0.url == url}).first else { return }
                activeUUID = activeCharacter.id
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
