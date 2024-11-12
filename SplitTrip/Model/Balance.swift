//
//  Balance.swift
//  SplitTrip
//
//  Created by AudyDev on 12/11/24.
//

import Foundation

struct Balance: Identifiable, Equatable {
    var id = UUID().uuidString
    var name: String
    var amount: Double
}
