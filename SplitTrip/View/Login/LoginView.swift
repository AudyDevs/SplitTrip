//
//  SwiftUIView.swift
//  SplitTrip
//
//  Created by AudyDev on 4/11/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State var viewModel = LoginVM()
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn {
            HomeView()
        } else {
            content
        }
    }
    
    var content: some View {
        NavigationStack {
            var handle: AuthStateDidChangeListenerHandle?
            
            ZStack {
                BackgroundGradient()
                VStack {
                    Spacer()
                    TitleApp()
                    Spacer()
                    LoginTextField(text: $email, prompt: "Escribe tu email", keyboardType: .emailAddress)
                        .padding(.bottom, 6)
                    PasswordTextField(text: $password, prompt: "Escribe tu contraseña")
                    CustomButton(
                        text: "Log in",
                        disabled: email.isEmpty || password.isEmpty,
                        action: {
                            viewModel.LoginUser(email: email, password: password)
                    }).padding(.top, 24)
                    .padding(.horizontal, 32)
                    NavigationLink(destination: SigninView()) {
                        Text("Crea un nuevo usuario")
                    }.padding(.top, 12)
                    Spacer()
                }.onAppear {
                    handle = Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            userIsLoggedIn = true
                        } else {
                            userIsLoggedIn = false
                        }
                    }
                }
                .onDisappear {
                    if let handle = handle {
                        Auth.auth().removeStateDidChangeListener(handle)
                    }
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
}

#Preview {
    LoginView()
}
