//
//  DateExtension.swift
//  SplitTrip
//
//  Created by AudyDev on 11/11/24.
//

import SwiftUI

extension Binding where Value == Date {
    func formattedDate() -> Binding<String> {
        Binding<String>(
            get: {
                let formatter = DateFormatter()
                formatter.dateFormat = "d 'de' MMMM 'de' yyyy"
                formatter.locale = Locale(identifier: "es_ES")
                return formatter.string(from: self.wrappedValue)
            },
            set: { newValue in
                let formatter = DateFormatter()
                formatter.dateFormat = "d 'de' MMMM 'de' yyyy"
                formatter.locale = Locale(identifier: "es_ES")
                if let newDate = formatter.date(from: newValue) {
                    self.wrappedValue = newDate
                }
            }
        )
    }
}
