//
//  ContentView.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 17/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var gokuActive: Bool = false
    @State var vegetaActive: Bool = false
    @State var trunksActive: Bool = false
    @State var gohanActive: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            List {
                NavigationLink(
                    destination: DetailView(character: .goku),isActive: $gokuActive){
                    TableRow(character: .goku)
                }
                
                NavigationLink(
                    destination: DetailView(character: .vegeta),isActive: $vegetaActive){
                    TableRow(character: .vegeta)
                }
                
                NavigationLink(
                    destination: DetailView(character: .trunks),isActive: $trunksActive){
                    TableRow(character: .trunks)
                }
                
                NavigationLink(
                    destination: DetailView(character: .gohan),isActive: $gohanActive){
                    TableRow(character: .gohan)
                }
            }
            .navigationTitle("Super Saiyan Power")
            .onOpenURL(perform: { (url) in
                self.gokuActive = url == CharacterDetail.goku.url
                self.vegetaActive = url == CharacterDetail.vegeta.url
                self.trunksActive = url == CharacterDetail.trunks.url
                self.gohanActive = url == CharacterDetail.gohan.url
            })
        }
        
    }
}

struct TableRow: View {
    let character: CharacterDetail
    
    var body: some View {
        HStack {
            Image(uiImage: character.image)
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Text(character.name)
        }.frame(height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
