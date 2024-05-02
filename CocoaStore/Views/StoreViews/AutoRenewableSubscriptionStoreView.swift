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
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    SubscriptionStoreView(groupID: subscriptionGroupID) {
      VStack {
        Image("cocoaheadsHamburgLogo")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .clipShape(RoundedRectangle(cornerRadius: 20))
          .frame(height: 150)
        VStack(spacing: 3) {
          Text("CocoaHeads Meetup Tickets")
            .fixedSize(horizontal: false, vertical: true)
            .font(.largeTitle.bold())
            .foregroundStyle(Color.black)
            .multilineTextAlignment(.center)
          Text("Subscription to get free access to various CocoaHeads Meetups")
            .fixedSize(horizontal: false, vertical: true)
            .font(.title3.weight(.medium))
            .padding([.bottom, .horizontal])
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
        }
      }
      .padding(.vertical)
      .padding(.top, 40)
      .containerBackground(Color.white, for: .subscriptionStoreHeader)
      .containerBackground(Color.red, for: .subscriptionStoreFullHeight)
    }
    .storeButton(.visible, for: .cancellation)
    .onInAppPurchaseCompletion { _, _ in
      dismiss()
    }
  }
}

#Preview {
  AutoRenewableSubscriptionStoreView()
}
