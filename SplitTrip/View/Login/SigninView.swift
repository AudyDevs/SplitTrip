//
//  SigninView.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct SigninView: View {
    
    @State var viewModel = LoginVM()
    
    @State var aliasName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack {
                Spacer()
                TitleApp()
                Spacer()
                LoginTextField(text: $aliasName, prompt: "Escribe tu nombre o apodo", keyboardType: .default)
                    .padding(.bottom, 6)
                LoginTextField(text: $email, prompt: "Escribe tu email", keyboardType: .emailAddress)
                    .padding(.bottom, 6)
                PasswordTextField(text: $password, prompt: "Escribe tu contrasena")
                CustomButton(
                    text: "Crear usuario",
                    disabled: aliasName.isEmpty || email.isEmpty || password.isEmpty,
                    action: {
                        viewModel.registerUser(aliasName: aliasName, email: email, password: password)
                }).padding(.top, 24)
                .padding(.horizontal, 32)
                Spacer()
            }
            .alert(isPresented: $viewModel.showError) {
                return Alert(
                    title: Text("Se ha producido un error"),
                    message: Text(viewModel.errorMessage)
                )
            }
        }
    }
}

#Preview {
    SigninView()
}
