//
//  StoreView.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 27.04.24.
//

import SwiftUI

struct StoreView: View {
  var body: some View {
    NavigationStack {
      List {
        Section {
          NavigationLink("CocoaHeads Meetup Tickets Subscriptions") {
            AutoRenewableSubscriptionStoreView()
          }
        } header: {
          Label("Subscriptions (Auto-Renewable)", systemImage: "ticket")
        }
        Section {
          NavigationLink("Profile Pic Decoration") {
            ConsumablesStoreView()
          }
        } header: {
          Label("Consumables", systemImage: "carrot")
        }
      }
      .navigationTitle("CocoaStore")
    }
  }
}

#Preview {
  StoreView()
}
