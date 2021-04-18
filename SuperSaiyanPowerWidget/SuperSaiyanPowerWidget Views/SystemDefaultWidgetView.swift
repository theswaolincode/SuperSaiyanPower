//
//  SystemDefaultWidgetView.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 18/4/21.
//

import SwiftUI
import WidgetKit

struct SystemDefaultWidgetView: View {
    let date: Date
    let character: CharacterDetail
    let showAll: Bool
    
    var body: some View {
        ZStack {
            Image(uiImage: character.image)
                .resizable()
                .scaledToFit()
            if showAll {
                TimerView(date: date)
            }
        }.widgetURL(character.url)
    }
}

struct SystemDefaultWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SystemDefaultWidgetView(date: Date(), character: .goku, showAll: false)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
