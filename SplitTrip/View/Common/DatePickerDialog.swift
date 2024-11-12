//
//  DatePickerDialog.swift
//  SplitTrip
//
//  Created by AudyDev on 11/11/24.
//

import SwiftUI

struct DatePickerDialog: View {
    @Binding var selectedDate: Date
    let onDismiss: () -> Void
    
    var body: some View {
        Color.black.opacity(0.4)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture { onDismiss() }
        VStack {
            Text("Selecciona una fecha:")
                .font(.title2)
                .bold()
            DatePicker(
                "Fecha",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            
            Button("Aceptar") {
                onDismiss()
            }
        }
        .frame(width: 300, height: 450)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color(.secondarySystemBackground), radius: 6)
        .transition(.scale)
    }
    
    func formattedDate(date: Date) -> String {
       let formatter = DateFormatter()
       formatter.dateStyle = .long
       return formatter.string(from: date)
   }
}
