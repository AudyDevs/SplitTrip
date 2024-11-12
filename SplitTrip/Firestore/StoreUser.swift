//
//  StoreUser.swift
//  SplitTrip
//
//  Created by AudyDev on 6/11/24.
//

import Foundation
import Firebase

struct StoreUser {
    
    func getUser(email: String, completion: @escaping (User) -> Void) {
        let db = Firestore.firestore()
        let ref = db
            .collection("Users")
            .whereField("email", isEqualTo: email)
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print("Error al obtener el usuario: \(error!.localizedDescription)")
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let aliasName = data["aliasName"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    
                    let user = User(
                        id: id,
                        aliasName: aliasName, 
                        email: email
                    )
                    completion(user)
                    return
                }
            }
        }
    }
    
    func addUser(user: User) {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(user.id)
        ref.setData([
            "id": user.id,
            "aliasName": user.aliasName,
            "email": user.email
        ]) { error in
            if let error = error {
                print("Error al crear el usuario: \(error.localizedDescription)")
            }
        }
    }
}
