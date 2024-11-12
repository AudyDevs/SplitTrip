//
//  PasswordTextField.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct PasswordTextField: View {
    let text: Binding<String>
    let prompt: String
    
    var body: some View {
        SecureField("", text: text,
                    prompt: Text(prompt).foregroundColor(.black.opacity(0.3)))
            .autocorrectionDisabled()
            .padding(16)
            .background(.white.opacity(0.2))
            .cornerRadius(16)
            .padding(.horizontal, 32)
    }
}
