//
//  StorePayment.swift
//  SplitTrip
//
//  Created by AudyDev on 8/11/24.
//

import Foundation
import Firebase

struct StorePayment {
    let idGroup: String
    let db = Firestore.firestore()

    func getPayments(
        searchedPayments: String,
        completion: @escaping ([Payment]) -> Void
    ) {
        let ref = db
            .collection("Group")
            .document(idGroup)
            .collection("Payment")
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print("Error al obtener el pago: \(error!.localizedDescription)")
                completion([])
                return
            }
            
            var payments: [Payment] = []
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = data["id"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let icon = data["icon"] as? String ?? ""
                    let amount = data["amount"] as? String ?? ""
                    let payFor = data["payFor"] as? String ?? ""
                    let timestamp = data["date"] as? Timestamp
                    let date = timestamp?.dateValue() ?? Date()
                    
                    let payment = Payment(
                        id: id,
                        title: title,
                        icon: icon,
                        amount: amount,
                        payFor: payFor,
                        date: date
                    )
                    payments.append(payment)
                }
            }
            if searchedPayments.isEmpty {
                completion(payments)
            } else {
                let filteredPayments = payments.filter { payment in
                    payment.title.localizedCaseInsensitiveContains(searchedPayments)
                }
                completion(filteredPayments)
            }
        }
    }
    
    func getPaymentById(
        idPayment: String,
        completion: @escaping (Payment) -> Void
    ) {
        let ref = db
            .collection("Group")
            .document(idGroup)
            .collection("Payment")
            .whereField("id", isEqualTo: idPayment)
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print("Error al obtener el pago: \(error!.localizedDescription)")
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let icon = data["icon"] as? String ?? ""
                    let amount = data["amount"] as? String ?? ""
                    let payFor = data["payFor"] as? String ?? ""
                    let timestamp = data["date"] as? Timestamp
                    let date = timestamp?.dateValue() ?? Date()
                    
                    let payment = Payment(
                        id: id,
                        title: title,
                        icon: icon,
                        amount: amount,
                        payFor: payFor,
                        date: date
                    )
                    completion(payment)
                    return
                }
            }
        }
    }
    
    func addPayment(
        payment: Payment
    ) {
        let ref = db
            .collection("Group")
            .document(idGroup)
            .collection("Payment")
            .document(payment.id)
        
        ref.setData([
            "id": payment.id,
            "title": payment.title,
            "icon": payment.icon,
            "amount": payment.amount,
            "payFor": payment.payFor,
            "date": payment.date,
        ]) { error in
            if let error = error {
                print("Error al crear el pago: \(error.localizedDescription)")
            }
        }
    }
    
    func updatePayment(
        payment: Payment
    ) {
        let ref = db
            .collection("Group")
            .document(idGroup)
            .collection("Payment")
            .document(payment.id)
        
        ref.updateData([
            "title": payment.title,
            "icon": payment.icon,
            "amount": payment.amount,
            "payFor": payment.payFor,
            "date": payment.date
        ]) { error in
            if let error = error {
                print("Error al actualizar el pago: \(error.localizedDescription)")
            }
        }
    }
    
    func deletePayment(
        idPayment: String
    ) {
        let ref = db
            .collection("Group")
            .document(idGroup)
            .collection("Payment")
            .document(idPayment)

        ref.delete() { error in
            if let error = error {
                print("Error al eliminar el pago: \(error.localizedDescription)")
            }
        }
    }
}
