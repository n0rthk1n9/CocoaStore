//
//  SubscriptionStatusTaskViewModifier.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 01.05.24.
//

import StoreKit
import SwiftUI

struct SubscriptionStatusTaskViewModifier: ViewModifier {
  @Environment(\.subscriptionIDs) private var subscriptionIDs

  @State private var state: EntitlementTaskState<SubscriptionStatus> = .loading

  private var isLoading: Bool {
    if case .loading = state { true } else { false }
  }

  func body(content: Content) -> some View {
    content
      .subscriptionStatusTask(for: subscriptionIDs.group) { state in
        self.state = state.map { @Sendable [subscriptionIDs] statuses in
          PurchaseManager.shared.status(
            for: statuses,
            ids: subscriptionIDs
          )
        }
      }
      .environment(\.subscriptionStatus, state.value ?? .notSubscribed)
      .environment(\.subscriptionStatusIsLoading, isLoading)
  }
}
