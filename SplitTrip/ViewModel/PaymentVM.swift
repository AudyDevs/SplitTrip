//
//  PaymentVM.swift
//  SplitTrip
//
//  Created by AudyDev on 8/11/24.
//

import SwiftUI
import Foundation

@Observable
final class PaymentVM {
    var isLoading: Bool = true
    var payments: [Payment] = []
    var groupedPayments: [String: [Payment]] = [:]
    var collaborators: [Collaborator] = []
    var balances: [Balance] = []
    
    func addPayment(idGroup: String, payment: Payment, collaborators: [Collaborator]) {
        StorePayment(idGroup: idGroup).addPayment(payment: payment)
        for collaborator in collaborators {
            StoreCollaborator(idGroup: idGroup, idPayment: payment.id).addPayment(collaborator: collaborator)
        }
    }
    
    func getPayments(idGroup: String, searchedPayment: String) {
        self.isLoading = true
        self.collaborators.removeAll()
        self.balances.removeAll()
        StorePayment(idGroup: idGroup).getPayments(searchedPayments: searchedPayment) { payments in
            self.payments = payments
            self.groupPayments(payments: payments)
            
            for payment in payments {
                let totalAmount = Double(payment.amount) ?? 0
                StoreCollaborator(idGroup: idGroup, idPayment: payment.id).getCollaborators { collaborators in
                    for collaborator in collaborators {
                        let balance = if payment.payFor == collaborator.name {
                            collaborator.active ? totalAmount - collaborator.amount : totalAmount
                        } else {
                            collaborator.active ? -collaborator.amount : 0
                        }
                        if let index = self.balances.firstIndex(where: { $0.name == collaborator.name}) {
                            self.balances[index].amount += balance
                        } else {
                            self.balances.append(Balance(name: collaborator.name, amount: balance))
                        }
                    }
                }
            }
        }
        self.isLoading = false
    }
    
    private func groupPayments(payments: [Payment]) {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "d 'de' MMMM 'de' yyyy"
            formatter.locale = Locale(identifier: "es_ES")
            return formatter
        }()
        
        self.groupedPayments = Dictionary(grouping: payments) { payment in
            dateFormatter.string(from: payment.date)
        }
    }
    
    func getPaymentById(idGroup: String, idPayment: String) {
        self.isLoading = true
        StorePayment(idGroup: idGroup).getPaymentById(idPayment: idPayment) { payment in
            self.payments.removeAll()
            self.payments.append(payment)
        }
        StoreCollaborator(idGroup: idGroup, idPayment: idPayment).getCollaborators { collaborators in
            self.collaborators = collaborators
        }
        self.isLoading = false
    }
    
    func updatePayment(idGroup: String, payment: Payment, collaborators: [Collaborator]) {
        StorePayment(idGroup: idGroup).updatePayment(payment: payment)
        for collaborator in collaborators {
            StoreCollaborator(idGroup: idGroup, idPayment: payment.id).updatePayment(collaborator: collaborator)
        }
    }
    
    func deletePayment(idGroup: String, idPayment: String) {
        StorePayment(idGroup: idGroup).deletePayment(idPayment: idPayment)
    }
    
    func calculateBalance(userName: String) -> (userBalance: Double, totalBalance: Double) {
        var userBalance: Double = 0
        var totalBalance: Double = 0
        
        if !payments.isEmpty {
            for payment in payments {
                let amount = Double(payment.amount) ?? 0
                totalBalance += amount
                
                if userName == payment.payFor {
                    userBalance += amount
                }
            }
        }
        return (userBalance, totalBalance)
    }
}
