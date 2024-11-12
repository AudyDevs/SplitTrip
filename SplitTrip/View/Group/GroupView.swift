//
//  NewGroupView.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct GroupView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let idGroup: String
    @State var homeViewModel = HomeVM()
    
    @State var title: String = ""
    @State var description: String = ""
    @State var participants: [Participant] = []
    
    var body: some View {
        if idGroup.isEmpty {
            VStack {
                CustomTextField(title: "Título", text: $title, prompt: "Escribe el título", keyboardType: .default)
                    .padding(.horizontal, 12)
                CustomTextField(title: "Descripción", text: $description, prompt: "Escribe una descripción (opcional)", keyboardType: .default)
                    .padding(.top, 18)
                    .padding(.horizontal, 12)
                ListField(participants: $participants)
                    .padding(.top, 18)
                CustomButton(
                    text: "Crea grupo de split trip",
                    disabled: title.isEmpty || participants[0].name.isEmpty,
                    action: {
                        let group = Group(
                            emailUser: homeViewModel.emailUserDefault,
                            title: title,
                            description: description,
                            participants: participants.map { $0.name }
                        )
                        homeViewModel.addGroup(group: group)
                        presentationMode.wrappedValue.dismiss()
                    }
                ).padding(.top, 18)
                .padding(.horizontal, 12)
                Spacer()
            }.padding(.horizontal, 12)
            .navigationTitle("Nuevo grupo")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear{
                participants = [Participant(name: homeViewModel.user?.aliasName ?? "")]
            }
        } else {
            VStack {
                CustomTextField(title: "Título", text: $title, prompt: "Escribe el título", keyboardType: .default)
                    .padding(.horizontal, 12)
                CustomTextField(title: "Descripción", text: $description, prompt: "Escribe una descripción (opcional)", keyboardType: .default)
                    .padding(.top, 18)
                    .padding(.horizontal, 12)
                ListField(participants: $participants)
                    .padding(.top, 18)
                CustomButton(
                    text: "Modificar grupo",
                    disabled: title.isEmpty || participants.isEmpty || participants[0].name.isEmpty,
                    action: {
                        let group = Group(
                            id: idGroup,
                            emailUser: homeViewModel.emailUserDefault,
                            title: title,
                            description: description,
                            participants: participants.map { $0.name }
                        )
                        homeViewModel.updateGroup(group: group)
                        presentationMode.wrappedValue.dismiss()
                    }
                ).padding(.top, 18)
                .padding(.horizontal, 12)
                Spacer()
            }.padding(.horizontal, 12)
            .navigationTitle("Editar grupo")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                homeViewModel.getGroupById(idGroup: idGroup)
            }
            .onChange(of: homeViewModel.groups) {
                if let group = homeViewModel.groups.first {
                    self.title = group.title
                    self.description = group.description
                    self.participants = group.participants.map { Participant(name: $0) }
                }
            }
        }
    }
}

#Preview {
    GroupView(idGroup: "7C84E794-F3D5-4A97-9F5C-4EF5B3CB2396")
}
