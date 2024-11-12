//
//  DetailPayView.swift
//  SplitTrip
//
//  Created by AudyDev on 7/11/24.
//

import SwiftUI

struct DetailPayView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let idGroup: String
    let idPayment: String
    @State var paymentViewModel = PaymentVM()
    @State var homeViewModel = HomeVM()
    
    @State var title: String = ""
    @State var amount: String = ""
    @State var selectedPay: String = ""
    @State var selectedDate: Date = Date()
    @State var participants: [String] = []
    @State var collaborators: [Collaborator] = []
    @State var showMenuIcon: Bool = false
    @State var showDatePicker: Bool = false
    @State var showDeleteAlert: Bool = false
    @State var selectedIcon: Icon = Icon.iconDefault
    
    var body: some View {
        ZStack {
            if idPayment.isEmpty {
                VStack {
                    CustomTextField(title: "Título", text: $title, prompt: "Escribe el gasto", keyboardType: .default)
                        .padding(.horizontal, 12)
                    HStack {
                        CustomTextField(title: "Importe", text: $amount, prompt: "0.00", keyboardType: .numberPad)
                            .layoutPriority(0)
                        MenuPicker(title: "Pagado por", selectedOptions: $selectedPay, options: participants)
                            .layoutPriority(1)
                    }.padding(.top, 18)
                    .padding(.horizontal, 12)
                    HStack {
                        CustomTextField(title: "Fecha", text: $selectedDate.formattedDate(), prompt: "", keyboardType: .default)
                            .disabled(true)
                            .onTapGesture {
                                withAnimation {
                                    showDatePicker.toggle()
                                }
                            }
                        IconTextField(icon: selectedIcon.iconName, color: selectedIcon.colorIcon)
                            .padding(.top, 33)
                            .onTapGesture {
                                withAnimation {
                                    showMenuIcon.toggle()
                                }
                            }
                    }.padding(.top, 18)
                    .padding(.horizontal, 12)
                    ListCollaborators(collaborators: $collaborators) {
                        calculateAmountCollaborators()
                    }
                    CustomButton(
                        text: "Crea nuevo gasto",
                        disabled: title.isEmpty || amount.isEmpty,
                        action: {
                            let payment = Payment(
                                title: title,
                                icon: selectedIcon.iconName,
                                amount: amount,
                                payFor: selectedPay,
                                date: selectedDate
                            )
                            paymentViewModel.addPayment(idGroup: idGroup, payment: payment, collaborators: collaborators)
                            presentationMode.wrappedValue.dismiss()
                        }
                    ).padding(.top, 18)
                    .padding(.horizontal, 12)
                    Spacer()
                }.padding(.horizontal, 12)
                .navigationTitle("Añadir gasto")
                .navigationBarTitleDisplayMode(.inline)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear{
                        selectedPay = homeViewModel.user?.aliasName ?? ""
                        homeViewModel.getGroupById(idGroup: idGroup)
                }
                .onChange(of: homeViewModel.groups) {
                    if let group = homeViewModel.groups.first {
                        self.participants = group.participants
                        for participant in group.participants {
                            let collaborator = Collaborator(
                                name: participant,
                                amount: 0,
                                active: true
                            )
                            self.collaborators.append(collaborator)
                        }
                    }
                }
                .onChange(of: amount) {
                    calculateAmountCollaborators()
                }
            } else {
                VStack {
                    CustomTextField(title: "Título", text: $title, prompt: "Escribe el gasto", keyboardType: .default)
                        .padding(.horizontal, 12)
                    HStack {
                        CustomTextField(title: "Importe", text: $amount, prompt: "0.00", keyboardType: .numberPad)
                            .layoutPriority(0)
                        MenuPicker(title: "Pagado por", selectedOptions: $selectedPay, options: participants)
                            .layoutPriority(1)
                    }.padding(.top, 18)
                    .padding(.horizontal, 12)
                    HStack {
                        CustomTextField(title: "Fecha", text: $selectedDate.formattedDate(), prompt: "", keyboardType: .default)
                            .disabled(true)
                            .onTapGesture {
                                withAnimation {
                                    showDatePicker.toggle()
                                }
                            }
                        IconTextField(icon: selectedIcon.iconName, color: selectedIcon.colorIcon)
                            .padding(.top, 33)
                            .onTapGesture {
                                withAnimation {
                                    showMenuIcon.toggle()
                                }
                            }
                    }.padding(.top, 18)
                    .padding(.horizontal, 12)
                    ListCollaborators(collaborators: $collaborators) {
                        calculateAmountCollaborators()
                    }
                    CustomButton(
                        text: "Modificar gasto",
                        disabled: title.isEmpty || amount.isEmpty,
                        action: {
                            let payment = Payment(
                                id: idPayment,
                                title: title,
                                icon: selectedIcon.iconName,
                                amount: amount,
                                payFor: selectedPay,
                                date: selectedDate
                            )
                            paymentViewModel.updatePayment(idGroup: idGroup, payment: payment, collaborators: collaborators)
                            presentationMode.wrappedValue.dismiss()
                        }
                    ).padding(.top, 18)
                    .padding(.horizontal, 12)
                    Spacer()
                }.padding(.horizontal, 12)
                .navigationTitle("Editar gasto")
                .navigationBarTitleDisplayMode(.inline)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    homeViewModel.getGroupById(idGroup: idGroup)
                    paymentViewModel.getPaymentById(idGroup: idGroup, idPayment: idPayment)
                }
                .onChange(of: homeViewModel.groups) {
                    if let group = homeViewModel.groups.first {
                        self.participants = group.participants
                    }
                }
                .onChange(of: paymentViewModel.payments) {
                    if let payment = paymentViewModel.payments.first {
                        self.title = payment.title
                        self.amount = payment.amount
                        self.selectedPay = payment.payFor
                        self.selectedIcon = Icon.listIcons.first(where: { $0.iconName == payment.icon }) ?? Icon.iconDefault
                        self.selectedDate = payment.date
                    }
                }
                .onChange(of: paymentViewModel.collaborators) {
                    self.collaborators = paymentViewModel.collaborators
                }
                .onChange(of: amount) {
                    calculateAmountCollaborators()
                }
                .toolbar {
                    ToolbarItem (placement: .navigationBarTrailing) {
                        Button(action: {
                            showDeleteAlert.toggle()
                        }, label: {
                            Label("Eliminar pago", systemImage: "trash")
                        })
                    }
                }
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("¿Seguro que quieres eliminar el pago?"),
                        message: Text("Se eliminará el pago permanentemente para todos los usuarios."),
                        primaryButton: .destructive(Text("Eliminar pago")) {
                            paymentViewModel.deletePayment(idGroup: idGroup, idPayment: idPayment)
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            if showMenuIcon {
                IconDialog(onDismiss: {
                    withAnimation {
                        showMenuIcon = false
                    }
                }, onTap: { icon in
                    selectedIcon = icon
                    withAnimation {
                        showMenuIcon = false
                    }
                })
            }
            if showDatePicker {
                DatePickerDialog(
                    selectedDate: $selectedDate,
                    onDismiss: {
                        withAnimation {
                            showDatePicker = false
                        }
                    }
                )
            }
        }
    }
    
    private func calculateAmountCollaborators() {
        let actives = collaborators.filter { $0.active }
        let amountByCollaborator = actives.isEmpty ? 0 : ((Double(amount) ?? 0) / Double(actives.count))
        
        for i in 0..<collaborators.count {
            if collaborators[i].active {
                collaborators[i].amount = amountByCollaborator
            } else {
                collaborators[i].amount = 0
            }
        }
    }
}

#Preview {
    DetailPayView(idGroup: "8724664D-E2D3-4C23-BED2-E22ADC8B8263", idPayment: "A5AE3746-7685-4991-8715-760CB43E7E4C")
}
