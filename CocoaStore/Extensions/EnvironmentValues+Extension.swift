//
//  EnvironmentValues+Extension.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 01.05.24.
//

import SwiftUI

extension EnvironmentValues {
  private struct SubscriptionIDsKey: EnvironmentKey {
    static let defaultValue = SubscriptionIdentifiers(
      group: "EC985ED4",
      ticketsBronze: "dev.xbow.CocoaStore.ticketsBronze",
      ticketsSilver: "dev.xbow.CocoaStore.ticketsSilver",
      ticketsGold: "dev.xbow.CocoaStore.ticketsGold"
    )
  }

  var subscriptionIDs: SubscriptionIdentifiers {
    get { self[SubscriptionIDsKey.self] }
    set { self[SubscriptionIDsKey.self] = newValue }
  }

  enum SubscriptionStatusEnvironmentKey: EnvironmentKey {
    static var defaultValue: SubscriptionStatus = .notSubscribed
  }

  enum SubscriptionStatusLoadingEnvironmentKey: EnvironmentKey {
    static var defaultValue = true
  }

  var subscriptionStatus: SubscriptionStatus {
    get { self[SubscriptionStatusEnvironmentKey.self] }
    set { self[SubscriptionStatusEnvironmentKey.self] = newValue }
  }

  var subscriptionStatusIsLoading: Bool {
    get { self[SubscriptionStatusLoadingEnvironmentKey.self] }
    set { self[SubscriptionStatusLoadingEnvironmentKey.self] = newValue }
  }
}
