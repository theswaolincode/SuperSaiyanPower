//
//  SuperSaiyanStagesWidget.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 23/3/21.
//

import WidgetKit
import SwiftUI
import Intents


struct SuperSaiyanStagesProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> SuperSaiyanStagesEntry {
        SuperSaiyanStagesEntry(date: Date(), character: .goku)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SuperSaiyanStagesEntry) -> Void) {
        let entry = SuperSaiyanStagesEntry(date: Date(), character: .goku)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SuperSaiyanStagesEntry>) -> Void) {
        let timeline = Timeline(entries: [SuperSaiyanStagesEntry(date: Date(), character: .goku)], policy: .atEnd)
        completion(timeline)
    }
}

struct SuperSaiyanStagesEntry: TimelineEntry {
    let date: Date
    let character: CharacterDetail
}

struct SuperSaiyanStagesWidgetEntryView : View {
    var entry: SuperSaiyanStagesProvider.Entry
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: entry.character.image)
                .resizable()
                .scaledToFit()
                Spacer()

                Text("Super Saiyan 1")
            }
            Spacer()
            
            HStack {
                Image(uiImage: entry.character.image)
                .resizable()
                .scaledToFit()
                Spacer()

                Text("Super Saiyan 2")
            }
            Spacer()

            HStack {
                Image(uiImage: entry.character.image)
                .resizable()
                .scaledToFit()
                Spacer()

                Text("Super Saiyan 3")
            }        }
        .padding(.all)
        }
    }

struct SuperSaiyanStagesWidget: Widget {
    let kind: String = "SuperSaiyanStagesWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SuperSaiyanStagesProvider()) { entry in
            SuperSaiyanStagesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Super Saiyan Stages")
        .description("Here you can see your favourite character Super Saiyan stages")
        .supportedFamilies([.systemLarge])
    }
}

struct SuperSaiyanStagesWidget_Previews: PreviewProvider {
    static var previews: some View {
        SuperSaiyanStagesWidgetEntryView(entry: SuperSaiyanStagesEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemLarge))

        SuperSaiyanStagesWidgetEntryView(entry: SuperSaiyanStagesEntry(date: Date(), character: .goku))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .redacted(reason: .placeholder)

        
    }
}

@main
struct SuperSaiyanPowerBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        SuperSaiyanPowerWidget()
        SuperSaiyanStagesWidget()
    }
}
