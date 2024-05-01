//
//  ConsumablesStoreView.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 27.04.24.
//

import StoreKit
import SwiftUI

struct ConsumablesStoreView: View {
  @State private var productIDs = [
    ProductID.profileHeartEmoji.rawValue,
    ProductID.profileSunEmoji.rawValue
  ]

  var body: some View {
    ScrollView {
      StoreView(ids: productIDs)
        .productViewStyle(.compact)
        .storeButton(.hidden, for: .cancellation)
    }
    .navigationTitle("Consumables")
  }
}

#Preview {
  ConsumablesStoreView()
}
