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

struct TableRow_Previews: PreviewProvider {
    static var previews: some View {
        TableRow(character: .goku)
    }
}

