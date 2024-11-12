//
//  PaymentView.swift
//  SplitTrip
//
//  Created by AudyDev on 6/11/24.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let idGroup: String
    @State var searchText: String = ""
    @State private var showLogoutAlert = false
    @State private var showDeleteAlert = false
    @State private var userIsLoggedIn = true
    @State private var selectedView = "Gastos"
    @State private var listBalances: [Balance] = []
    
    @State private var userTotal = ""
    @State private var totalBalance = ""
    
    @State var loginViewModel = LoginVM()
    @State var homeViewModel = HomeVM()
    @State var paymentViewModel = PaymentVM()
    
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
                    Picker("Selecciona vista", selection: $selectedView) {
                        Text("Gastos").tag("Gastos")
                        Text("Saldos").tag("Saldos")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    if paymentViewModel.payments.isEmpty {
                        EmptyList(textBody: "Registra un gasto tocando el '+' para comenzar a dividir gastos")
                    } else {
                        if selectedView == "Gastos" {
                            if paymentViewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .scaleEffect(1.25)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                List {
                                    ForEach(paymentViewModel.groupedPayments.keys.sorted(), id: \.self) { date in
                                        Section(header: Text(date)) {
                                            ForEach(paymentViewModel.groupedPayments[date]!) { payment in
                                                ZStack {
                                                    PaymentItemList(
                                                        icon: payment.icon,
                                                        title: payment.title,
                                                        subtitle: "Pagado por \(payment.payFor)",
                                                        amount: payment.amount
                                                    )
                                                    NavigationLink(destination: DetailPayView(idGroup: idGroup, idPayment: payment.id)) { EmptyView() }.opacity(0)
                                                }.listRowSeparator(.hidden)
                                            }
                                        }
                                    }
                                }.listStyle(.plain)
                                    .listRowSpacing(6)
                                    .padding(.top, -25)
                            }
                        } else {
                            VStack {
                                BalancesResume(userTotal: userTotal, totalBalance: totalBalance)
                                ListBalance(balances: listBalances.sorted { $0.amount > $1.amount })
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onAppear {
                                let (userCalculate, totalCalculate) = paymentViewModel.calculateBalance(userName: homeViewModel.user?.aliasName ?? "")
                                userTotal = String(userCalculate)
                                totalBalance = String(totalCalculate)
                            }
                        }
                    }
                }.toolbar {
                    ToolbarItemGroup (placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: {
                                showLogoutAlert.toggle()
                            }, label: {
                                Label("Desconectar", systemImage: "rectangle.portrait.and.arrow.right")
                            })
                            NavigationLink(destination: GroupView(idGroup: idGroup)){
                                Label("Editar grupo", systemImage: "pencil")
                            }
                            Button(action: {
                                showDeleteAlert.toggle()
                            }, label: {
                                Label("Eliminar grupo", systemImage: "trash")
                            })
                        } label: {
                            Label("Options", systemImage: "ellipsis.circle")
                        }
                    }
                }.alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text("¿Seguro que quieres cerrar sesión?"),
                        message: Text("Se cerrará tu sesión y necesitarás volver a iniciar sesión."),
                        primaryButton: .destructive(Text("Cerrar sesión")) {
                            loginViewModel.signOut()
                            userIsLoggedIn = false
                        },
                        secondaryButton: .cancel()
                    )
                }.onAppear {
                    homeViewModel.getGroupById(idGroup: idGroup)
                    paymentViewModel.getPayments(idGroup: idGroup, searchedPayment: searchText)
                }
                .onChange(of: searchText) {
                    paymentViewModel.getPayments(idGroup: idGroup, searchedPayment: searchText)
                }
                .onChange(of: paymentViewModel.balances) {
                    listBalances = paymentViewModel.balances
                }
                FloatingButton(destination: DetailPayView(idGroup: idGroup, idPayment: ""))
            }.navigationBarTitle(homeViewModel.groups.first?.title ?? "", displayMode: .inline)
                .searchable(text: $searchText)
        }.alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("¿Seguro que quieres eliminar el grupo?"),
                message: Text("Se eliminará el grupo permanentemente para todos los usuarios."),
                primaryButton: .destructive(Text("Eliminar grupo")) {
                    homeViewModel.deleteGroup(idGroup: idGroup)
                    presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    PaymentView(idGroup: "8215D7D5-5BB9-4E56-9F5F-779D362285F3")
}
