//
//  LiveActivityExample.swift
//  SuperSaiyanLiveActivity
//
//  Created by Daniel Ayala on 9/11/22.
//

import Foundation
import ActivityKit
import SwiftUI
import WidgetKit


struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<SuperSaiyanActivityAttributes>
    
    var body: some View {
        VStack {
            Spacer()
            Text(context.state.saiyanName)
            Spacer()
            HStack {
                Spacer()
                Label {
                    Text(context.attributes.description)
                } icon: {
                    Image(systemName: "figure.strengthtraining.traditional")
                        .foregroundColor(.indigo)
                }
                .font(.title2)
                Spacer()
                Label {
                    Text(timerInterval: context.state.superSaiyanTimer, countsDown: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 50)
                        .monospacedDigit()
                } icon: {
                    Image(systemName: "timer")
                        .foregroundColor(.indigo)
                }
                .font(.title2)
                Spacer()
            }
            Spacer()
        }
        .activitySystemActionForegroundColor(.indigo)
        .activityBackgroundTint(.cyan)
    }
}

struct SuperSaiyanLiveWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SuperSaiyanActivityAttributes.self) { context in
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Label("Active", systemImage: "figure.strengthtraining.traditional")
                        .foregroundColor(.indigo)
                        .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text(timerInterval: context.state.superSaiyanTimer, countsDown: true)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                            .monospacedDigit()
                    } icon: {
                        Image(systemName: "timer")
                            .foregroundColor(.indigo)
                    }
                    .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.center) { }
                
                DynamicIslandExpandedRegion(.bottom) {
                    Button {
                        // Deep link into your app.
                    } label: {
                        Label("Turn Off", systemImage: "power")
                    }
                    .foregroundColor(.indigo)
                }
            } compactLeading: {
                // Create the compact leading presentation.
                // ...
            } compactTrailing: {
                // Create the compact trailing presentation.
                // ...
            } minimal: {
                // Create the minimal presentation.
                // ...
            }
            .keylineTint(.yellow)
        }
    }
}

struct SuperSaiyanWidget_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenLiveActivityView(context: SuperSaiyanActivityAttributes(description: "Hola").previewContext(SuperSaiyanActivityAttributes.ContentState(saiyanName: "Manuel", superSaiyanTimer: Date()...Date().addingTimeInterval(1 * 60)), viewKind: .content) as! ActivityViewContext<SuperSaiyanActivityAttributes>)
    }
}
