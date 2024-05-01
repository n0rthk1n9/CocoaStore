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
      NavigationStack {
        VStack(alignment: .leading, spacing: 20) {
          switch subscriptionStatus {
          case .notSubscribed: Text("Not Subscribed")
          case .ticketsBronze:
            ProfileSubscriptionBadgeView(
              title: "Meetup Tickets Bronze",
              color: Color.brown
            )
          case .ticketsSilver:
            ProfileSubscriptionBadgeView(
              title: "Meetup Tickets Silver",
              color: Color.gray
            )
          case .ticketsGold:
            ProfileSubscriptionBadgeView(
              title: "Meetup Tickets Gold",
              color: Color.yellow
            )
          }
          VStack {
            Text("❤️ x\(purchaseManager.profileHeartEmojiQuantity)")
            Text("☀️ x\(purchaseManager.profileSunEmojiQuantity)")
          }
          Spacer()
        }
        .navigationTitle("Profile")
      }
    }
  }
}

struct ProfileSubscriptionBadgeView: View {
  let title: String
  let color: Color

  var body: some View {
    HStack {
      Image(systemName: "ticket")
        .foregroundStyle(color)
        .font(.system(size: 60))
        .bold()
      Text(title)
        .foregroundStyle(color)
        .font(.title)
        .bold()
    }
    .padding()
    .background(Color.gray.opacity(0.4))
    .cornerRadius(20)
    .shadow(color: Color.white.opacity(0.2), radius: 4)
  }
}

#Preview {
  ProfileView()
}
