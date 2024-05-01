//
//  SubscriptionID.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 01.05.24.
//

enum SubscriptionID: String {
  case ticketsBronze = "dev.xbow.CocoaStore.ticketsBronze"
  case ticketsSilver = "dev.xbow.CocoaStore.ticketsSilver"
  case ticketsGold = "dev.xbow.CocoaStore.ticketsGold"
  case none = ""

  static func from(rawValue: String) -> SubscriptionID? {
    return self.init(rawValue: rawValue)
  }
}
