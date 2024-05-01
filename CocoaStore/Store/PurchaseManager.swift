//
//  PurchaseManager.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 01.05.24.
//

import StoreKit

class PurchaseManager: ObservableObject {
//  @Published var activeSubscription: SubscriptionID = .none

  private var updatesTask: Task<Void, Never>?

  static let shared = PurchaseManager()

  private init() {}

//  @MainActor
//  private func setActiveSubscription(subscription: SubscriptionID) {
//    activeSubscription = subscription
//  }

  func process(transaction verificationResult: VerificationResult<Transaction>) async {
    let transaction: Transaction

    switch verificationResult {
    case let .verified(trans):
      transaction = trans
    case .unverified:
      return
    }

    await transaction.finish()
  }

  func status(for statuses: [Product.SubscriptionInfo.Status],
              ids: SubscriptionIdentifiers) -> SubscriptionStatus
  {
    let effectiveStatus = statuses.max { lhs, rhs in
      let lhsStatus = SubscriptionStatus(
        productID: lhs.transaction.unsafePayloadValue.productID,
        ids: ids
      ) ?? .notSubscribed
      let rhsStatus = SubscriptionStatus(
        productID: rhs.transaction.unsafePayloadValue.productID,
        ids: ids
      ) ?? .notSubscribed
      return lhsStatus < rhsStatus
    }
    guard let effectiveStatus else {
      return .notSubscribed
    }

    let transaction: Transaction
    switch effectiveStatus.transaction {
    case let .verified(trans):
      transaction = trans
    case .unverified:
      return .notSubscribed
    }

    return SubscriptionStatus(productID: transaction.productID, ids: ids) ?? .notSubscribed
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
        print(payload)
      case .unverified:
        return
      }
    }
  }
}
