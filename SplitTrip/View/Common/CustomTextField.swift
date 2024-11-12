//
//  CustomTextField.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    let text: Binding<String>
    let prompt: String
    let keyboardType: UIKeyboardType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20))
                .bold()
            TextField(prompt, text: text)
                .font(.system(size: 15))
                .keyboardType(keyboardType)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .padding(16)
                .background(.gray.opacity(0.2))
                .cornerRadius(16)
        }
    }
}
