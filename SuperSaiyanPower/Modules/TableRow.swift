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
            Spacer(minLength: 20)
            
            CircleView(kiPower: String(character.kiPower))

            Spacer(minLength: 20)
            Text(character.name)
        }.frame(height: 150)
    }
}

struct TableRow_Previews: PreviewProvider {
    static var previews: some View {
        TableRow(character: .goku)
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
