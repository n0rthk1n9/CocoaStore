//
//  CocoaStoreView.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 27.04.24.
//

import SwiftUI

struct CocoaStoreView: View {
  @State private var isShowingSubscriptionStoreViewSheet = false

  var body: some View {
    NavigationStack {
      List {
        Section {
          Button("CocoaHeads Meetup Tickets Subscriptions") {
            isShowingSubscriptionStoreViewSheet.toggle()
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
      .sheet(isPresented: $isShowingSubscriptionStoreViewSheet) {
        AutoRenewableSubscriptionStoreView()
      }
    }
  }
}

#Preview {
  CocoaStoreView()
}
