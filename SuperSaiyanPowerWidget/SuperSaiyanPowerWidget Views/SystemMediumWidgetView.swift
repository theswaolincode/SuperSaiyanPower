//
//  SystemMediumWidgetView.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 18/4/21.
//

import SwiftUI
import WidgetKit

struct SystemMediumWidgetView: View{
    let date: Date
    let character: CharacterDetail
    let showAll: Bool
    
    var body: some View {
        ZStack {
            HStack{
                if showAll {
                    TimerView(date: date)
                        .frame(minWidth: 0, maxWidth: 60, minHeight: 0, maxHeight: 200)
                }
                VStack {
                    Link(destination: character.url) {
                        Image(uiImage: character.image)
                            .resizable()
                            .scaledToFit()
                    }
                }
                SystemMediumWidgetDescriptionView(name: character.name, kiPower: String(character.kiPower), avatar: character.avatar)
            }
            .padding(.all)
        }
        .containerBackground(for: .widget) { }
    }
}


struct SystemMediumWidgetDescriptionView: View {
    let name: String
    let kiPower: String
    let avatar: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(name) \(avatar)")
                    .font(.caption)
                    .bold()
                
                Spacer()
                
                Text("KI: \(kiPower)")
                    .font(.caption)
                    .bold()
            }
            Spacer(minLength: 0)
        }
        .padding(.all)
        .background(ContainerRelativeShape().fill(Color.gray.opacity(0.1)))
    }
}

struct SystemMediumWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SystemMediumWidgetView(date: Date(), character: .goku, showAll: false)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
