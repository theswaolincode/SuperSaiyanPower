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
        }
        .onOpenURL(perform: { (url) in
            let charactersList = isToggle ? superSaiyanCharacters : characters
            guard let activeCharacter = charactersList.filter({$0.url == url}).first else { return }
            activeUUID = activeCharacter.id
        })
    }
}

struct CircleView: View {
    let kiPower: String
    
    var body: some View {
        ZStack() {
            Circle()
                .trim(from: 0.2, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .frame(width: 150, height: 100)
                .padding(6)
            VStack {
                Text("KI POWER")
                    .bold()
                Text("\(kiPower)")
            }
            
        }
        .padding(6)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
