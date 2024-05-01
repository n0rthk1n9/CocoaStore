//
//  SubscriptionStatus.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 01.05.24.
//

import StoreKit

enum SubscriptionStatus: Comparable, Hashable {
  case notSubscribed
  case ticketsBronze
  case ticketsSilver
  case ticketsGold

  init?(productID: Product.ID, ids: SubscriptionIdentifiers) {
    switch productID {
    case ids.ticketsBronze: self = .ticketsBronze
    case ids.ticketsSilver: self = .ticketsSilver
    case ids.ticketsGold: self = .ticketsGold
    default: return nil
    }
  }
}
