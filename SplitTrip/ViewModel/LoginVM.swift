//
//  LoginVM.swift
//  SplitTrip
//
//  Created by AudyDev on 6/11/24.
//

import Foundation
import FirebaseAuth

@Observable
final class LoginVM {
    var showError: Bool = false
    var errorMessage: String = ""
    
    func registerUser(aliasName: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                self.showError = true
                self.errorMessage = error?.localizedDescription.description ?? ""
            } else {
                StoreUser().addUser(user: User(aliasName: aliasName, email: email))
                UserDefaults.standard.set(email, forKey: "emailUser")
            }
        }
    }
    
    func LoginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.showError = true
                self.errorMessage = error?.localizedDescription.description ?? ""
            } else {
                UserDefaults.standard.set(email, forKey: "emailUser")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            self.showError = true
            self.errorMessage = signOutError.localizedDescription.description
        }
    }
}
