//
//  IconDialog.swift
//  SplitTrip
//
//  Created by AudyDev on 10/11/24.
//

import SwiftUI

struct IconDialog: View {
    let onDismiss: () -> Void
    let onTap: (Icon) -> Void
    
    var body: some View {
        Color.black.opacity(0.4)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture { onDismiss() }
        VStack {
            Text("Tipo gasto")
                .font(.title2)
                .bold()
                .padding(.top, 16)
            List(Icon.listIcons) { icon in
                HStack {
                    Image(systemName: icon.iconName)
                        .foregroundColor(icon.colorIcon)
                    Spacer()
                    Text(icon.name)
                    Spacer()
                }
                .padding(.horizontal)
                .frame(width: 220, height: 40)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .onTapGesture { onTap(icon) }
                .listRowInsets(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                .listRowSeparator(.hidden)
            }.listStyle(.plain)
        }
        .frame(width: 250, height: 500)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color(.secondarySystemBackground), radius: 6)
        .transition(.scale)
    }
}
