//
//  View+Extension.swift
//  CocoaStore
//
//  Created by Jan Armbrust on 01.05.24.
//

import SwiftUI

extension View {
  func cocoaStore() -> some View {
    modifier(CocoaStoreViewModifier())
  }

  func subscriptionPassStatusTask() -> some View {
    modifier(SubscriptionStatusTaskViewModifier())
  }
}
