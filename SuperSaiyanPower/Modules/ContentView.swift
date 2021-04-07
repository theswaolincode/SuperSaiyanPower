//
//  ContentView.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 17/3/21.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @State var gokuActive: Bool = false
    @State var vegetaActive: Bool = false
    @State var trunksActive: Bool = false
    @State var gohanActive: Bool = false
    @State private var isToggle : Bool = SuperSaiyanPowerStorage().getSuperSaiyanActivation() ?? false
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $isToggle){
                    Text("Activate Super Saiyan Power !!! ")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                }.padding()
                .background(isToggle ? Color.purple : Color.gray)
                .cornerRadius(3.0)
                .onChange(of: isToggle) { value in
                    SuperSaiyanPowerStorage().saveSuperSaiyanActivation(active: isToggle)
                    WidgetCenter.shared.reloadTimelines(ofKind: "SuperSaiyanPowerWidget")
                    print(value)
                }
                
                NavigationLink(
                    destination: DetailView(character: isToggle ? .superSaiyanGoku : .goku), isActive: $gokuActive){
                    TableRow(character: isToggle ? .superSaiyanGoku : .goku)
                }
                
                NavigationLink(
                    destination: DetailView(character: isToggle ? .superSaiyanVegeta : .vegeta), isActive: $vegetaActive){
                    TableRow(character: isToggle ? .superSaiyanVegeta : .vegeta)
                }
                
                NavigationLink(
                    destination: DetailView(character: isToggle ? .superSaiyanTrunks : .trunks), isActive: $trunksActive){
                    TableRow(character: isToggle ? .superSaiyanTrunks : .trunks)
                }
                
                NavigationLink(
                    destination: DetailView(character: isToggle ? .superSaiyanGohan : .gohan), isActive: $gohanActive){
                    TableRow(character: isToggle ? .superSaiyanGohan : .gohan)
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
            
            CircleView(kiPower:String(character.kiPower))
            
            Text(character.name)
        }.frame(height: 200)
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
                .frame(width: 150, height: 125)
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
