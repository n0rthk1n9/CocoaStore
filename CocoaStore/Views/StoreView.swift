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
          Text("CocoaHeads Meetup Tickets Subscriptions")
        } header: {
          Label("Subscriptions (Auto-Renewable)", systemImage: "ticket")
        }
        Section {
          Text("Subscriptions (Non-Renewing")
        } header: {
          Label("Subscriptions (Non-Renewing)", systemImage: "ticket")
        }
        Section {
          Text("Profile Pic Decoration")
        } header: {
          Label("Consumables", systemImage: "ticket")
        }
      }
      .navigationTitle("CocoaStore")
    }
  }
}

#Preview {
  StoreView()
}
