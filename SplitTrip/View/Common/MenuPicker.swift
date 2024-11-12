//
//  MenuPicker.swift
//  SplitTrip
//
//  Created by AudyDev on 10/11/24.
//

import SwiftUI

struct MenuPicker: View {
    let title: String
    @Binding var selectedOptions: String
    let options: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20))
                .bold()
            Picker("Pagado por", selection: $selectedOptions) {
                ForEach(options, id: \.self) { opcion in
                    Text(opcion)
                }
            }
            .font(.system(size: 15))
            .padding(8)
            .background(.gray.opacity(0.2))
            .cornerRadius(16)
            .pickerStyle(MenuPickerStyle())
            .clipped()
        }
    }
}
