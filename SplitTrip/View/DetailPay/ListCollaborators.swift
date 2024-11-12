//
//  ListCollaborators.swift
//  SplitTrip
//
//  Created by AudyDev on 12/11/24.
//

import SwiftUI

struct ListCollaborators: View {
    @Binding var collaborators: [Collaborator]
    var onSelected: () -> Void
    
    var body: some View {
        List {
            ForEach($collaborators) { $collaborator in
                HStack {
                    Button(action: {
                        collaborator.active.toggle()
                        onSelected()
                    }, label: {
                        Image(systemName: collaborator.active ? "checkmark.square.fill" : "square")
                            .foregroundColor(collaborator.active ? .blue : .gray)
                            .font(.title)
                    })
                    Text(collaborator.name)
                        .padding(.leading, 8)
                    Spacer()
                    Text("\(collaborator.amount, specifier: "%.2f") €")
                }
                .padding(.vertical, 4)
            }
        }.listStyle(.plain)
        .padding(.vertical, 8)
    }
}
