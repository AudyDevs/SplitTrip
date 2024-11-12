//
//  Payment.swift
//  SplitTrip
//
//  Created by AudyDev on 7/11/24.
//

import Foundation

struct Payment: Identifiable, Equatable {
    var id = UUID().uuidString
    var title: String
    var icon: String
    var amount: String
    var payFor: String
    var date: Date
}
