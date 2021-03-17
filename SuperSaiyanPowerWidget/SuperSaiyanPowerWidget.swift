//
//  SuperSaiyanPowerWidget.swift
//  SuperSaiyanPowerWidget
//
//  Created by Daniel Ayala on 17/3/21.
//

import WidgetKit
import SwiftUI
import Intents

import WidgetKit
import SwiftUI
import Intents

private var lastEntry = SimpleEntry(date: Date(), character: .goku)

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
        var policy: TimelineReloadPolicy
        var entry: SimpleEntry
        let currentDate = Date()
        let selectedCharacter = character(for: configuration)
        
        if let diff = Calendar.current.dateComponents([.minute], from: lastEntry.date, to: Date()).minute, diff > 5 { print("Over 5 minute") }

        entry = SimpleEntry(date: currentDate, character: selectedCharacter)
        
        let timeToReload = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
        policy = .after(timeToReload)

        lastEntry = entry
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: policy)
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
}

struct SuperSaiyanPowerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image(uiImage: entry.character.image)
                .resizable()
                .scaledToFit()
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
//        .supportedFamilies([.systemSmall, .systemLarge])
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
    }
}
