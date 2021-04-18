//
//  MainView.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 27/3/21.
//

import SwiftUI


struct MainView: View {
    var body: some View {
        TabView {
            SaiyansView()
                .tabItem {
                    Label("Saiyans", systemImage: "list.dash")
                }

            CharactersView()
                .tabItem {
                    Label("DragonBall", systemImage: "list.dash")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
