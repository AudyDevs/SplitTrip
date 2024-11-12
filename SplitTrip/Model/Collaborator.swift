//
//  Collaborator.swift
//  SplitTrip
//
//  Created by AudyDev on 8/11/24.
//

import Foundation

struct Collaborator: Identifiable, Equatable {
    var id = UUID().uuidString
    var name: String
    var amount: Double
    var active: Bool
}
