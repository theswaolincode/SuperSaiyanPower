//
//  SuperSaiyanPowerWidget.swift
//  SuperSaiyanPowerWidget
//
//  Created by Daniel Ayala on 17/3/21.
//

import WidgetKit
import SwiftUI
import Intents


struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), character: .goku)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), character: .goku)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let isSuperSaiyan = SuperSaiyanPowerStorage().getSuperSaiyanActiveState() ?? false

        if configuration.saiyans == .showAll {
            var charactersArray = [CharacterDetail]()
            charactersArray = isSuperSaiyan ? CharacterDetail.superSaiyanCharacters : CharacterDetail.availableCharacters
            for (index, character) in charactersArray.enumerated() {
                let entryDate = Calendar.current.date(byAdding: .minute, value: index, to: currentDate)!
                print(entryDate)
                entries.append(SimpleEntry(date: entryDate, character: character, showAll: true))
            }
        }else {
            let selectedCharacter = character(for: configuration, isSuperSaiyan: isSuperSaiyan)
            entries.append(SimpleEntry(date: currentDate, character: selectedCharacter))
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func character(for configuration: ConfigurationIntent, isSuperSaiyan: Bool) -> CharacterDetail {
        let character: CharacterDetail
        switch configuration.saiyans {
        case .goku: character = isSuperSaiyan ? .superSaiyanGoku : .goku
        case .vegeta: character = isSuperSaiyan ? .superSaiyanVegeta : .vegeta
        case .trunks: character = isSuperSaiyan ? .superSaiyanTrunks : .trunks
        case .gohan: character = isSuperSaiyan ? .superSaiyanGohan : .gohan
        default : return .goku
        }
        return character
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let character: CharacterDetail
    var showAll: Bool = false
}

struct SuperSaiyanPowerWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        switch widgetFamily {
        case .systemMedium: systemMediumLayout(entry: entry)
        default: systemDefault(entry: entry)
          
        }
    }
}

struct systemDefault: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Link(destination: entry.character.url) {
                Image(uiImage: entry.character.image)
                    .resizable()
                    .scaledToFit()
                    .widgetURL(entry.character.url)
            }
            if entry.showAll {
                TimerView(date: entry.date)
            }
        }
    }
}

struct systemMediumLayout: View{
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            HStack{
                if entry.showAll {
                    TimerView(date: entry.date)
                        .frame(minWidth: 0, maxWidth: 60, minHeight: 0, maxHeight: 200)
                }
                VStack {
                    Link(destination: entry.character.url) {
                        Image(uiImage: entry.character.image)
                            .resizable()
                            .scaledToFit()
                            .widgetURL(entry.character.url)
                    }
                }
                DescriptionView(name: entry.character.name, kiPower: String(entry.character.kiPower), avatar: entry.character.avatar)
            }
            .padding(.all)
        }
    }
}

struct TimerView: View {
    let date: Date
    
    var body: some View {
        VStack {
            Spacer()
            Text(date, style: .timer)
                .font(.caption)
                .bold()
                .padding(6)
                .opacity(0.8)
        }
        .padding(6)
    }
}

struct DescriptionView: View {
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


struct SuperSaiyanPowerWidget: Widget {
    let kind: String = "SuperSaiyanPowerWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SuperSaiyanPowerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Feel the Super Saiyan Power")
        .description("Discover Dragon Ball Saiyans.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct SuperSaiyanPowerWidget_Previews: PreviewProvider {
    static var previews: some View {
        SuperSaiyanPowerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        SuperSaiyanPowerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
                
        SuperSaiyanPowerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .redacted(reason: .placeholder)
        
        SuperSaiyanPowerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .redacted(reason: .placeholder)
        
    }
}
