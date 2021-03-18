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
                
                //                Spacer ()
                
                Text("KI: \(character.kiPower)")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .clipped()
                    .foregroundColor(.white)
            }
            
            Image(uiImage: character.image)
                .resizable()
                .scaledToFit()
        }.frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .topLeading)
        .background(Color.red)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: .goku)
    }
}
