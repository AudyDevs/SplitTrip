//
//  HomeView.swift
//  SplitTrip
//
//  Created by AudyDev on 2/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var loginViewModel = LoginVM()
    @State var homeViewModel = HomeVM()
    
    @State var searchText: String = ""
    @State private var showingLogoutAlert = false
    @State private var userIsLoggedIn = true
    
    var body: some View {
        if userIsLoggedIn {
            content
        } else {
            LoginView()
        }
    }
    
    var content: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    if homeViewModel.groups.isEmpty {
                        EmptyList(textBody: "No tienes grupos asociados, empieza creandote un grupo nuevo")
                    } else {
                        if homeViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.25)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            List(homeViewModel.groups) { group in
                                NavigationLink(destination: PaymentView(idGroup: group.id)) {
                                    HomeItemList(group: group)
                                }
                            }
                        }
                    }
                }.toolbar {
                    ToolbarItem (placement: .navigationBarTrailing) {
                        Label("LogOut", systemImage: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                showingLogoutAlert.toggle()
                        }
                    }
                }.alert(isPresented: $showingLogoutAlert) {
                    Alert(
                        title: Text("¿Seguro que quieres cerrar sesión?"),
                        message: Text("Se cerrará tu sesión y necesitarás volver a iniciar sesión."),
                        primaryButton: .destructive(Text("Cerrar sesión")) {
                            loginViewModel.signOut()
                            userIsLoggedIn = false
                        },
                        secondaryButton: .cancel()
                    )
                }
                FloatingButton(destination: GroupView(idGroup: ""))
            }.navigationBarTitle("Split Trip")
                .searchable(text: $searchText)
                .onAppear {
                    homeViewModel.getGroups(searchedGroup: "")
                }
                .onChange(of: searchText) { 
                    homeViewModel.getGroups(searchedGroup: searchText)
                }
        }.alert(isPresented: $loginViewModel.showError) {
            return Alert(
                title: Text("Se ha producido un error"),
                message: Text(loginViewModel.errorMessage)
            )
        }
    }
}

#Preview {
    HomeView()
}
