//
//  ProfileView.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 27.04.24.
//

import SwiftUI

struct ProfileView: View {
  @ObservedObject private var purchaseManager = PurchaseManager.shared
  @Environment(\.subscriptionStatus) private var subscriptionStatus
  @Environment(\.subscriptionStatusIsLoading) private var subscriptionStatusIsLoading

  var body: some View {
    if subscriptionStatusIsLoading {
      ProgressView()
    } else {
      switch subscriptionStatus {
      case .notSubscribed: Text("Not Subscribed")
      case .ticketsBronze: Text("ticketsBronze")
      case .ticketsSilver: Text("ticketsSilver")
      case .ticketsGold: Text("ticketsGold")
      }
    }
  }
}

#Preview {
  ProfileView()
}
