//
//  BalancesResume.swift
//  SplitTrip
//
//  Created by AudyDev on 11/11/24.
//

import SwiftUI

struct BalancesResume: View {
    let userTotal: String
    let totalBalance: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Mis Gastos").font(.caption2).foregroundColor(.gray).padding(.bottom, 1)
                Text("\(userTotal) €").font(.title3).bold()
            }
            Spacer()
            VStack {
                Text("Gastos Totales").font(.caption2).foregroundColor(.gray).padding(.bottom, 1)
                Text("\(totalBalance) €").font(.title3).bold()
            }
            Spacer()
        }
    }
}

#Preview {
    BalancesResume(userTotal: "15.00", totalBalance: "45.00")
}
