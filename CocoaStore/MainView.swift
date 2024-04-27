//
//  MainView.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 23.04.24.
//

import StoreKit
import SwiftUI

struct MainView: View {
  @State private var subscriptions: [Product]?

  var sortedSubscriptions: [Product] {
    subscriptions?.sorted { $0.price < $1.price } ?? []
  }

  var body: some View {
    List {
      ForEach(sortedSubscriptions) { subscription in
        HStack(alignment: .top) {
          Text("🎫")
          VStack(alignment: .leading) {
            HStack {
              Text(subscription.displayName)
                .font(.title3)
                .fontWeight(.bold)
              Spacer()
              Text(subscription.displayPrice)
            }
            Text(subscription.description)
              .font(.caption)
          }
        }
      }
    }
    .task {
      subscriptions = try? await Product.products(for: [
        "dev.xbow.CocoaStore.ticketsGold",
        "dev.xbow.CocoaStore.ticketsSilver",
        "dev.xbow.CocoaStore.ticketsBronze"
      ])
    }
  }
}

#Preview {
  MainView()
}
