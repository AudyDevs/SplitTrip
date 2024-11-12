//
//  CustomButton.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    let disabled: Bool
    let action: () -> Void
    
    var body: some View {
        
        let backgroundDisabled: Color = if (disabled) {
            Color.black.opacity(0.3)
        } else {
            Color.blue.opacity(0.6)
        }
        
        Button(action: action, label: {
            Text(text)
                .frame(maxWidth: .infinity, maxHeight: 36)
                .bold()
                .background(backgroundDisabled)
                .foregroundColor(.white)
                .cornerRadius(8)
        })
        .frame(maxWidth: .infinity)
        .disabled(disabled)
    }
}
