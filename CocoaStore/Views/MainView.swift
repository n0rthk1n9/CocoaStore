//
//  MainView.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 23.04.24.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      CocoaStoreView()
        .tag("store")
        .tabItem {
          Label("Store", systemImage: "storefront")
        }
      LiveOnStageView()
        .tag("live")
        .tabItem {
          Label("Live", systemImage: "record.circle")
        }
      ProfileView()
        .tag("profile")
        .tabItem {
          Label("Profile", systemImage: "person.crop.circle")
        }
    }
  }
}

#Preview {
  MainView()
}
