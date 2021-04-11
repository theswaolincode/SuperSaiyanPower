//
//  TableRow.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 11/4/21.
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
            
            Text(character.name)
        }.padding(.all).frame(height: 200)
    }
}

struct TableRow_Previews: PreviewProvider {
    static var previews: some View {
        TableRow(character: .goku)
            .previewLayout(.fixed(width: 500, height: 200))
    }
}
