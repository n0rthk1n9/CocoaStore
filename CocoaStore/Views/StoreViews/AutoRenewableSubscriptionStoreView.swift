//
//  AutoRenewableSubscriptionStoreView.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 27.04.24.
//

import StoreKit
import SwiftUI

struct AutoRenewableSubscriptionStoreView: View {
  @Environment(\.subscriptionIDs.group) private var subscriptionGroupID

  var body: some View {
    ScrollView {
      SubscriptionStoreView(groupID: subscriptionGroupID)
        .storeButton(.hidden, for: .cancellation)
    }
  }
}

#Preview {
  AutoRenewableSubscriptionStoreView()
}
