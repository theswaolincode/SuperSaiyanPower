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
        let policy: TimelineReloadPolicy
        
        policy = configuration.saiyans == .showAll ? .atEnd : .never
        entries = buildEntries(for: configuration)
        
        let timeline = Timeline(entries: entries, policy: policy)
        completion(timeline)
    }
    
    func buildEntries(for configuration: ConfigurationIntent) -> [SimpleEntry] {
        var entries: [SimpleEntry] = []
        let isSuperSaiyan = SuperSaiyanPowerStorage().getSuperSaiyanActiveState() ?? false
        let currentDate = Date()

        if configuration.saiyans == .showAll {
            var charactersList = [CharacterDetail]()
            charactersList = isSuperSaiyan ? CharacterDetail.superSaiyanCharacters : CharacterDetail.availableCharacters
            for (index, character) in charactersList.enumerated() {
                let entryDate = Calendar.current.date(byAdding: .minute, value: index, to: currentDate)!
                print(entryDate)
                entries.append(SimpleEntry(date: entryDate, character: character, showAll: true))
            }
            return entries
        }else {
            let selectedCharacter = character(for: configuration, isSuperSaiyan: isSuperSaiyan)
            entries.append(SimpleEntry(date: currentDate, character: selectedCharacter))
            return entries
        }
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
        case .systemMedium: SystemMediumWidgetView(date: entry.date, character: entry.character, showAll: entry.showAll)
        default: SystemDefaultWidgetView(date: entry.date, character: entry.character, showAll: entry.showAll)
            
        }
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
