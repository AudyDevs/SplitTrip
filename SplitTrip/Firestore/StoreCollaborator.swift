//
//  StoreCollaborator.swift
//  SplitTrip
//
//  Created by AudyDev on 8/11/24.
//

import Foundation
import Firebase

struct StoreCollaborator {
    let db = Firestore.firestore()
    let idGroup: String
    let idPayment: String
    
    func getCollaborators(
        completion: @escaping ([Collaborator]) -> Void
    ) {
        let ref = db
            .collection("Group")
            .document(idGroup)
            .collection("Payment")
            .document(idPayment)
            .collection("Collaborator")

        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print("Error al obtener el colaborador: \(error!.localizedDescription)")
                completion([])
                return
            }
            
            var collaborators: [Collaborator] = []
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let amount = data["amount"] as? Double ?? 0
                    let active = data["active"] as? Bool ?? false
                    
                    let collaborator = Collaborator(
                        id: id,
                        name: name,
                        amount: amount,
                        active: active
                    )
                    collaborators.append(collaborator)
                }
            }
            completion(collaborators)
        }
    }

    func addPayment(collaborator: Collaborator) {
        let ref = db
            .collection("Group")
            .document(idGroup)
            .collection("Payment")
            .document(idPayment)
            .collection("Collaborator")
            .document(collaborator.id)
        
        ref.setData([
            "id": collaborator.id,
            "name": collaborator.name,
            "amount": collaborator.amount,
            "active": collaborator.active
        ]) { error in
            if let error = error {
                print("Error al crear el colaborador: \(error.localizedDescription)")
            }
        }
    }
    
    func updatePayment(collaborator: Collaborator) {
        let ref = db
            .collection("Group")
            .document(idGroup)
            .collection("Payment")
            .document(idPayment)
            .collection("Collaborator")
            .document(collaborator.id)
        
        ref.updateData([
            "name": collaborator.name,
            "amount": collaborator.amount,
            "active": collaborator.active
        ]) { error in
            if let error = error {
                print("Error al actualizar el colaborador: \(error.localizedDescription)")
            }
        }
    }
}
