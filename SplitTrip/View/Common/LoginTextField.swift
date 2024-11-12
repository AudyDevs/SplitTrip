//
//  CustomTextField.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct LoginTextField: View {
    let text: Binding<String>
    let prompt: String
    let keyboardType: UIKeyboardType
    
    var body: some View {
        TextField("", text: text,
                  prompt: Text(prompt).foregroundColor(.black.opacity(0.3)))
            .keyboardType(keyboardType)
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .padding(16)
            .background(.white.opacity(0.2))
            .cornerRadius(16)
            .padding(.horizontal, 32)
    }
}
