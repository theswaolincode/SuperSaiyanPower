//
//  TimerView.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 18/4/21.
//

import SwiftUI
import WidgetKit

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
        .containerBackground(for: .widget) { }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(date: Date())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
