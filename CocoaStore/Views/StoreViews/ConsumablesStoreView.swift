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
    "dev.xbow.CocoaStore.profileSunEmoji",
    "dev.xbow.CocoaStore.profileHeartEmoji"
  ]

  var body: some View {
    ForEach(productIDs, id: \.self) { productID in
      ProductView(id: productID)
    }
  }
}

#Preview {
  ConsumablesStoreView()
}
