//
//  SwiftUIView.swift
//  SplitTrip
//
//  Created by AudyDev on 4/11/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            VStack {
                
                
                
                TextField("", text: $email,
                          prompt: Text("Escribe tu email").foregroundColor(.black.opacity(0.3)))
                    .keyboardType(.emailAddress)
                    .padding(16)
                    .background(.white.opacity(0.2))
                    .cornerRadius(16)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 6)
                SecureField("", text: $password,
                            prompt: Text("Escribe tu contrasena").foregroundColor(.black.opacity(0.3)))
                    .padding(16)
                    .background(.white.opacity(0.2))
                    .cornerRadius(16)
                    .padding(.horizontal, 32)
                    
                Button(action: {
                    // login
                }, label: {
                    Text("Log in")
                        .frame(maxWidth: .infinity, maxHeight: 36)
                        .bold()
                        .background(.blue.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                
                Button(action: {
                    // Signin
                }, label: {
                    Text("Crea una nueva cuenta")
                })
                .padding(.top, 12)
            }
        }
    }
}

#Preview {
    LoginView()
}
