//
//  HomeVM.swift
//  SplitTrip
//
//  Created by AudyDev on 6/11/24.
//

import Foundation

@Observable
final class HomeVM {
    var user: User?
    var isLoading: Bool = true
    var groups: [Group] = []
    let emailUserDefault: String = UserDefaults.standard.string(forKey: "emailUser") ?? "albert@gmail.com"
    
    init() {
        getUser()
    }
    
    func getUser() {
        StoreUser().getUser(email: emailUserDefault) { user in
            self.user = user
        }
    }
    
    func addGroup(group: Group) {
        StoreGroup().addGroup(group: group)
    }
    
    func getGroups(searchedGroup: String) {
        self.isLoading = true
        StoreGroup().getGroups(emailUser: emailUserDefault, searchedGroup: searchedGroup) { groups in
            self.groups = groups
        }
        self.isLoading = false
    }
    
    func getGroupById(idGroup: String) {
        self.isLoading = true
        StoreGroup().getGroupById(idGroup: idGroup) { group in
            self.groups.removeAll()
            self.groups.append(group)
        }
        self.isLoading = false
    }
    
    func updateGroup(group: Group) {
        StoreGroup().updateGroup(group: group)
    }
    
    func deleteGroup(idGroup: String) {
        StoreGroup().deleteGroup(idGroup: idGroup)
    }
}
