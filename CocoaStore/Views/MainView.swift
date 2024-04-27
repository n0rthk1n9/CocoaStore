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
      StoreView()
        .tag("store")
        .tabItem {
          Label("Store", systemImage: "storefront")
        }
    }
  }
}

#Preview {
  MainView()
}
