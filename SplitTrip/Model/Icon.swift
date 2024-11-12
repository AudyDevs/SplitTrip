//
//  Icon.swift
//  SplitTrip
//
//  Created by AudyDev on 8/11/24.
//

import Foundation
import SwiftUI

struct Icon: Identifiable {
    var id = UUID()
    var name: String
    var iconName: String
    var colorIcon: Color
    
    static let listIcons: [Icon] = [
        Icon(name: "Compras", iconName: "cart", colorIcon: Color.purple.opacity(0.75)),
        Icon(name: "Restaurante", iconName: "fork.knife", colorIcon: Color.yellow.opacity(0.75)),
        Icon(name: "Ocio", iconName: "party.popper", colorIcon: Color.pink.opacity(0.75)),
        Icon(name: "Deportes", iconName: "tennis.racket", colorIcon: Color.green.opacity(0.75)),
        Icon(name: "Social", iconName: "figure.socialdance", colorIcon: Color.orange.opacity(0.75)),
        Icon(name: "Transporte", iconName: "car", colorIcon: Color.mint.opacity(0.75)),
        Icon(name: "Salud", iconName: "heart", colorIcon: Color.red.opacity(0.75)),
        Icon(name: "Ropa", iconName: "tshirt", colorIcon: Color.indigo.opacity(0.75)),
        Icon(name: "Viajes", iconName: "globe.europe.africa", colorIcon: Color.blue.opacity(0.75)),
        Icon(name: "Mascota", iconName: "pawprint", colorIcon: Color.brown.opacity(0.75)),
        Icon(name: "Reparación", iconName: "hammer", colorIcon: Color.gray.opacity(0.75)),
        Icon(name: "Hogar", iconName: "house", colorIcon: Color.cyan.opacity(0.75)),
    ]
    
    static let iconDefault: Icon = Icon(name: "Compras", iconName: "cart", colorIcon: Color.purple.opacity(0.75))
}
