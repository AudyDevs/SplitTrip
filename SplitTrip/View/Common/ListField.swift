//
//  ListField.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct ListField: View {
    @Binding var participants: [Participant]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 3) {
                Text("Participantes")
                    .font(.system(size: 20))
                    .bold()
                    .padding(.horizontal, 12)
                List {
                    ForEach(participants) { participant in
                        HStack {
                            TextField("Nombre del participante", text: $participants[getIndex(of: participant)].name)
                                .autocorrectionDisabled()
                            Button(action: {
                                if participants.count > 1 {
                                    if let index = participants.firstIndex(where: { $0.id == participant.id }) {
                                        participants.remove(at: index)
                                    }
                                }
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 12)
                    }
                    Button(action: {
                        participants.append(Participant(name: ""))
                    }) {
                        Text("Añadir Participante")
                            .foregroundColor(.blue)
                    }
                }.listStyle(.plain)
            }
        }
    }
    
    private func getIndex(of participant: Participant) -> Int {
        return participants.firstIndex(where: { $0.id == participant.id }) ?? 0
    }
}

