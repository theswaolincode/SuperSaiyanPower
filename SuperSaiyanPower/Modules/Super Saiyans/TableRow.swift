//
//  TableRow.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 27/3/21.
//

import SwiftUI


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
                .frame(width: 90, height: 90)
                .padding(6)
            VStack {
                Text("KI POWER")
                    .bold()
                    .font(.caption)
                Text("\(kiPower)")
            }
            
        }
        .padding(6)
    }
}

struct TableRow_Previews: PreviewProvider {
    static var previews: some View {
        TableRow(character: .goku)
    }
}

