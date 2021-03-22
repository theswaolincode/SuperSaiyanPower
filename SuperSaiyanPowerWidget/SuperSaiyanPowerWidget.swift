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
        var offsetInterval = 0
        
        if configuration.saiyans == .showAll {
            var charactersArray = [CharacterDetail]()
            charactersArray = configuration.isSuperSaiyan as? Bool ?? false ? CharacterDetail.superSaiyanCharacters : CharacterDetail.availableCharacters
            for character in charactersArray {
                let entryDate = Calendar.current.date(byAdding: .minute, value: offsetInterval, to: currentDate)!
                print(entryDate)
                entries.append(SimpleEntry(date: entryDate, character: character, showAll: true))
                offsetInterval += 1
            }
        }else {
            let selectedCharacter = character(for: configuration)
            entries.append(SimpleEntry(date: currentDate, character: selectedCharacter))
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func character(for configuration: ConfigurationIntent) -> CharacterDetail {
        let isSuperSaiyan = configuration.isSuperSaiyan as? Bool ?? false
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
    
    
    var body: some View {
        ZStack {
            Link(destination: entry.character.url) {
                Image(uiImage: entry.character.image)
                    .resizable()
                    .scaledToFit()
                    .widgetURL(entry.character.url)
            }
            if entry.showAll {
                Text(entry.date, style: .timer)
            }
        }
    }
}


@main
struct SuperSaiyanPowerWidget: Widget {
    let kind: String = "SuperSaiyanPowerWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SuperSaiyanPowerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Feel the Super Saiyan Power")
        .description("Discover Dragon Ball Saiyans.")
    }
}

struct SuperSaiyanPowerWidget_Previews: PreviewProvider {
    static var previews: some View {
        SuperSaiyanPowerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        SuperSaiyanPowerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        SuperSaiyanPowerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        
        SuperSaiyanPowerWidgetEntryView(entry: SimpleEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .redacted(reason: .placeholder)

    }
}
