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
    ForEach(productIDs, id: \.self) { productID in
      ProductView(id: productID)
    }
  }
}

#Preview {
  ConsumablesStoreView()
}
