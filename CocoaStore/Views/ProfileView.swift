//
//  ProfileView.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 27.04.24.
//

import SwiftUI

struct ProfileView: View {
  @ObservedObject private var purchaseManager = PurchaseManager.shared

  var body: some View {
    switch purchaseManager.activeSubscription {
    case .ticketsBronze:
      Text("ticketsBronze")
    case .ticketsSilver:
      Text("ticketsSilver")
    case .ticketsGold:
      Text("ticketsGold")
    case .none:
      Text("No subscription")
    }
  }
}

#Preview {
  ProfileView()
}
