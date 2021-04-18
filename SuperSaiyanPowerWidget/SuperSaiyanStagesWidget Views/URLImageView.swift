//
//  URLImageView.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 18/4/21.
//

import SwiftUI
import WidgetKit

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


struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(url: URL(string: "https://picsum.photos/200/300")!)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
