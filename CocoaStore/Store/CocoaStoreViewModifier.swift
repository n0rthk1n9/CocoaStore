//
//  CocoaStoreViewModifier.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 01.05.24.
//

import SwiftUI

struct CocoaStoreViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    ZStack {
      content
    }
    .subscriptionPassStatusTask()
    .task {
      PurchaseManager.shared.observeTransactionUpdates()
      await PurchaseManager.shared.checkForUnfinishedTransactions()
      await PurchaseManager.shared.refreshPurchasedProducts()
    }
  }
}
