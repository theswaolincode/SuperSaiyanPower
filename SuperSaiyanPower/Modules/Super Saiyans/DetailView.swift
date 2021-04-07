//
//  DetailView.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 18/3/21.
//

import SwiftUI

struct DetailView: View {
    
    let character: CharacterDetail
    
    var body: some View {
        List{
            VStack {
                VStack {
                    Text(character.name)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .clipped()
                    
                    Text("\(character.bio)")
                        .font(.callout)
                        .padding()
                                        
                    Text("KI: \(String(character.kiPower))")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .clipped()
                        .gradientForeground(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))])
                }
                
                Image(uiImage: character.image)
                    .resizable()
                    .scaledToFit()
                
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: .goku)
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}
