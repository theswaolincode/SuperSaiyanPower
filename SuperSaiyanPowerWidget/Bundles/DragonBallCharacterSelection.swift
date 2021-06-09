//
//  DragonBallCharacterSelection.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 28/5/21.
//

import SwiftUI
import WidgetKit
import Intents

struct DragonBallCharacterSelectionProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DragonBallCharacterSelectionEntry {
        DragonBallCharacterSelectionEntry(date: Date(), config: CharacterSelectionIntent())
    }
    
    func getSnapshot(for configuration: CharacterSelectionIntent, in context: Context, completion: @escaping (DragonBallCharacterSelectionEntry) -> ()) {
        let entry = DragonBallCharacterSelectionEntry(date: Date(), config: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: CharacterSelectionIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DragonBallCharacterSelectionEntry] = []

        entries.append(DragonBallCharacterSelectionEntry(date: Date(), config: configuration))
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct DragonBallCharacterSelectionEntry: TimelineEntry {
    let date: Date
    let config: CharacterSelectionIntent
}

struct DragonBallCharacterSelection: View {
    var entry: DragonBallCharacterSelectionProvider.Entry

    var body: some View {
        Text("Hola")
    }
}
    
struct DragonBallCharacterSelectionWidget: Widget {
    let kind: String = "DragonBallCharacterSelectionWidget"
    
    var body: some WidgetConfiguration {
        
        IntentConfiguration(kind: kind, intent: CharacterSelectionIntent.self, provider: DragonBallCharacterSelectionProvider()) { entry in
            DragonBallCharacterSelection(entry: entry)
        }
        .configurationDisplayName("Characters")
        .description("Select a character to display bio in Widget")
        .supportedFamilies([.systemLarge])
    }
}
    

struct DragonBallCharacterSelection_Previews: PreviewProvider {
    static var previews: some View {
        DragonBallCharacterSelection(entry: DragonBallCharacterSelectionEntry(date: Date(), config: CharacterSelectionIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))    }
}
