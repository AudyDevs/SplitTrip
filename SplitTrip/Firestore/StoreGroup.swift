//
//  StoreGroup.swift
//  SplitTrip
//
//  Created by AudyDev on 7/11/24.
//

import Foundation
import Firebase

struct StoreGroup {
    let db = Firestore.firestore()
    
    func getGroups(
        emailUser: String,
        searchedGroup: String,
        completion: @escaping ([Group]) -> Void
    ) {
        let ref = db
            .collection("Group")
            .whereField("emailUser", isEqualTo: emailUser)
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print("Error al obtener el grupo: \(error!.localizedDescription)")
                completion([])
                return
            }
            
            var groups: [Group] = []
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = data["id"] as? String ?? ""
                    let emailUser = data["emailUser"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let participants = data["participants"] as? [String] ?? []
                    
                    let group = Group(
                        id: id,
                        emailUser: emailUser,
                        title: title,
                        description: description,
                        participants: participants
                    )
                    groups.append(group)
                }
            }
            if searchedGroup.isEmpty {
                completion(groups)
            } else {
                let filteredGroups = groups.filter { group in
                    group.title.localizedCaseInsensitiveContains(searchedGroup)
                }
                completion(filteredGroups)
            }
        }
    }
    
    func getGroupById(
        idGroup: String,
        completion: @escaping (Group) -> Void
    ) {
        let ref = db
            .collection("Group")
            .whereField("id", isEqualTo: idGroup)
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print("Error al obtener el grupo: \(error!.localizedDescription)")
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let emailUser = data["emailUser"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let participants = data["participants"] as? [String] ?? []
                    
                    let group = Group(
                        id: id,
                        emailUser: emailUser,
                        title: title,
                        description: description,
                        participants: participants
                    )
                    completion(group)
                    return
                }
            }
        }
    }
    
    func addGroup(group: Group) {
        let ref = db
            .collection("Group")
            .document(group.id)
        
        ref.setData([
            "id": group.id,
            "emailUser": group.emailUser,
            "title": group.title,
            "description": group.description,
            "participants": group.participants
        ]) { error in
            if let error = error {
                print("Error al crear el grupo: \(error.localizedDescription)")
            }
        }
    }
    
    func updateGroup(group: Group) {
        let ref = db
            .collection("Group")
            .document(group.id)
        
        ref.updateData([
            "emailUser": group.emailUser,
            "title": group.title,
            "description": group.description,
            "participants": group.participants
        ]) { error in
            if let error = error {
                print("Error al actualizar el grupo: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteGroup(idGroup: String) {
        let ref = db
            .collection("Group")
            .document(idGroup)

        ref.delete() { error in
            if let error = error {
                print("Error al eliminar el grupo: \(error.localizedDescription)")
            }
        }
    }
}
