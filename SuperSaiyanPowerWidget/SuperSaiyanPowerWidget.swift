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
        let selectedCharacter: CharacterDetail
        selectedCharacter = .goku
        
        if let diff = Calendar.current.dateComponents([.minute], from: lastEntry.date, to: Date()).minute, diff > 5 {
               //do something
            print("Over 5 minute")
           }

        if configuration.isSuperSaiyan as? Bool ?? false {
//            configuration.isSuperSaiyan = 0
//            configuration.didChangeValue(forKey: "isSuperSaiyan")
            entry = SimpleEntry(date: currentDate, character: selectedCharacter, isSuperSaiyan: configuration.isSuperSaiyan as? Bool ?? false)
            
            let timeToReload = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
            policy = .after(timeToReload)

        }else {
            entry = SimpleEntry(date: currentDate, character: selectedCharacter, isSuperSaiyan: configuration.isSuperSaiyan as? Bool ?? false)
            policy = .never
        }

        lastEntry = entry
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: policy)
        completion(timeline)

    }
    
//    func character(for configuration: DynamicCharacterSelectionIntent) -> CharacterDetail {
//        if let name = configuration.hero?.identifier, let character = CharacterDetail.characterFromName(name: name) {
//            // Save the last selected character to our App Group.
//            CharacterDetail.setLastSelectedCharacter(heroName: name)
//            return character
//        }
//        return .goku
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let character: CharacterDetail
    var isSuperSaiyan: Bool = false
    
}

struct SuperSaiyanPowerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            if entry.isSuperSaiyan {
                Image("goku_super_saiyan")
                    .resizable()
                    .scaledToFit()
                Text("\(entry.date, style: .timer)")
            }else {
                Image("goku_chilling")
                    .resizable()
                    .scaledToFit()
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
        .description("This is an example widget.")
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
