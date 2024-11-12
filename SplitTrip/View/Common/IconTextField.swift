//
//  IconTextField.swift
//  SplitTrip
//
//  Created by AudyDev on 8/11/24.
//

import SwiftUI

struct IconTextField: View {
    let icon: String
    let color: Color
    
    var body: some View {
        Image(systemName: icon)
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundStyle(color)
            .padding(14)
            .background(.gray.opacity(0.2))
            .cornerRadius(18)
    }
}
