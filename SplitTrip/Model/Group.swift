//
//  Group.swift
//  SplitTrip
//
//  Created by AudyDev on 6/11/24.
//

import Foundation

struct Group: Identifiable, Equatable {
    var id = UUID().uuidString
    var emailUser: String
    var title: String
    var description: String
    var participants: [String]
}
