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
        SuperSaiyanStagesEntry(date: Date(), superSaiyanStages: [SuperSaiyanStage(ssURL: "", ssName: "", bio: "")])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SuperSaiyanStagesEntry) -> Void) {
        let entry = SuperSaiyanStagesEntry(date: Date(), superSaiyanStages: [SuperSaiyanStage(ssURL: "", ssName: "", bio: "")])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SuperSaiyanStagesEntry>) -> Void) {
        
        SuperSaiyanWidgetProvider.loadSaiyanStages() { saiyanStagesResponse in
            var entries: [SuperSaiyanStagesEntry] = []
            var policy: TimelineReloadPolicy

            switch saiyanStagesResponse {
            case .Failure:
                entries.append(SuperSaiyanStagesEntry(date: Date(), superSaiyanStages: [SuperSaiyanStage(ssURL: "", ssName: "", bio: "")]))
                policy = .after(Calendar.current.date(byAdding: .minute, value: 15, to: Date())!)
                break
            case .Success(let superSaiyanResponse):
                entries.append(SuperSaiyanStagesEntry(date: Date(), superSaiyanStages: superSaiyanResponse))
                
                let timeToReload = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
                policy = .after(timeToReload)
                break
            }
            
            let timeline = Timeline(entries: entries, policy: policy)
            completion(timeline)
        }
    }
}

struct SuperSaiyanStagesEntry: TimelineEntry {
    let date: Date
    let superSaiyanStages: [SuperSaiyanStage]
}

struct SuperSaiyanStagesWidgetEntryView : View {
    var entry: SuperSaiyanStagesProvider.Entry
    
    var body: some View {
        VStack {
            ForEach(entry.superSaiyanStages, id: \.self) { stage in
                HStack {
                if let url = URL(string: stage.ssURL) {
                    URLImageView(url: url)
                        .padding()
                }
                Text(stage.ssName)
                    .padding()
                Spacer()
                }
            }
        }
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
        let stagePreview = SuperSaiyanStage(ssURL: "image", ssName: "placeholder", bio: "placeholder")
        
        SuperSaiyanStagesWidgetEntryView(entry: SuperSaiyanStagesEntry(date: Date(), superSaiyanStages: [stagePreview, stagePreview, stagePreview]))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        
        SuperSaiyanStagesWidgetEntryView(entry: SuperSaiyanStagesEntry(date: Date(), superSaiyanStages: [stagePreview, stagePreview, stagePreview]))
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

struct URLImageView: View {
    let url: URL

    @ViewBuilder
    var body: some View {
        if let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            Image(systemName: "photo")
        }
    }
}

