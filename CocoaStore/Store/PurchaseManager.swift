//
//  PurchaseManager.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 01.05.24.
//

import StoreKit

class PurchaseManager: ObservableObject {
  @Published var profileHeartEmojiQuantity = 0
  @Published var profileSunEmojiQuantity = 0

  private var updatesTask: Task<Void, Never>?

  static let shared = PurchaseManager()

  private init() {}

  func process(transaction verificationResult: VerificationResult<Transaction>) async {
    let transaction: Transaction

    switch verificationResult {
    case let .verified(trans):
      transaction = trans
    case .unverified:
      return
    }

    if case .consumable = transaction.productType {
      if transaction.revocationDate == nil, transaction.revocationReason == nil {
        switch transaction.productID {
        case ProductID.profileHeartEmoji.rawValue:
          Task { @MainActor in
            profileHeartEmojiQuantity += transaction.purchasedQuantity
          }
        case ProductID.profileSunEmoji.rawValue:
          Task { @MainActor in
            profileSunEmojiQuantity += transaction.purchasedQuantity
          }
        default:
          return
        }
        await transaction.finish()
      } else {
        switch transaction.productID {
        case ProductID.profileHeartEmoji.rawValue:
          Task { @MainActor in
            profileHeartEmojiQuantity -= transaction.purchasedQuantity
          }
        case ProductID.profileSunEmoji.rawValue:
          Task { @MainActor in
            profileSunEmojiQuantity -= transaction.purchasedQuantity
          }
        default:
          return
        }
      }
    } else {
      await transaction.finish()
    }
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
}
