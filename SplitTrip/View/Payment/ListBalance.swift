//
//  ListBalance.swift
//  SplitTrip
//
//  Created by AudyDev on 12/11/24.
//

import SwiftUI

struct ListBalance: View {
    var balances: [Balance]
    
    var body: some View {
        
        List {
            ForEach(balances) { balance in
                let color = if balance.amount > 0 {
                    Color.green
                } else if balance.amount < 0 {
                    Color.red
                } else {
                    Color.black
                }
                HStack {
                    Text(balance.name)
                        .padding(.leading, 8)
                        .bold()
                    Spacer()
                    Text("\(balance.amount, specifier: "%.2f") €")
                        .foregroundColor(color)
                }
                .padding(.vertical, 4)
            }
        }.listStyle(.plain)
        .padding(.vertical, 8)
    }
}
