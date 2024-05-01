//
//  PurchaseManager.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 01.05.24.
//

import StoreKit

class PurchaseManager: ObservableObject {
  @Published var activeSubscription: SubscriptionID = .none

  private var updatesTask: Task<Void, Never>?

  static let shared = PurchaseManager()

  private init() {}

  @MainActor
  private func setActiveSubscription(subscription: SubscriptionID) {
    activeSubscription = subscription
  }

  func process(transaction verificationResult: VerificationResult<Transaction>) async {
    let transaction: Transaction

    switch verificationResult {
    case let .verified(trans):
      transaction = trans
      if let subscriptionID = SubscriptionID.from(rawValue: trans.productID) {
        Task {
          await setActiveSubscription(subscription: subscriptionID)
        }
        print("\(activeSubscription.rawValue)")
      } else {
        print("Invalid product ID: \(trans.productID)")
      }
    case .unverified:
      return
    }

    await transaction.finish()
  }

  func checkForUnfinishedTransactions() async {
    for await transaction in Transaction.unfinished {
      Task.detached(priority: .background) {
        await self.process(transaction: transaction)
      }
    }
  }

  func observeTransactionUpdates() {
    updatesTask = Task { [weak self] in
      for await update in Transaction.updates {
        guard let self else { break }
        await self.process(transaction: update)
      }
    }
  }

  func refreshPurchasedProducts() async {
    for await verificationResult in Transaction.currentEntitlements {
      print("\(verificationResult.unsafePayloadValue.productID)")
      switch verificationResult {
      case let .verified(payload):
        if let subscriptionID = SubscriptionID.from(rawValue: payload.productID) {
          Task {
            await setActiveSubscription(subscription: subscriptionID)
          }
          print("\(activeSubscription.rawValue)")
        } else {
          print("Invalid product ID: \(payload.productID)")
        }
      case .unverified:
        return
      }
    }
  }
}
