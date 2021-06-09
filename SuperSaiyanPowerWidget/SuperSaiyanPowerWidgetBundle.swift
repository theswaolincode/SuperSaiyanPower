//
//  SuperSaiyanPowerWidgetBundle.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 7/4/21.
//

import SwiftUI
import WidgetKit

@main
struct SuperSaiyanPowerWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        SuperSaiyanPowerWidget()
        SuperSaiyanStagesWidget()
        DragonBallCharacterSelectionWidget()
    }
}

