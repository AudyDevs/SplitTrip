//
//  PaymentItemList.swift
//  SplitTrip
//
//  Created by AudyDev on 6/11/24.
//

import SwiftUI

struct PaymentItemList: View {
    let icon: String
    let title: String
    let subtitle: String
    let amount: String
    
    var body: some View {
        let Icon = Icon.listIcons.first(where: { $0.iconName == icon }) ?? Icon.iconDefault
        HStack {
            Image(systemName: Icon.iconName)
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.vertical, 6)
                .padding(.trailing, 6)
                .foregroundColor(Icon.colorIcon)
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.subheadline)
                    .bold()
                if (!subtitle.isEmpty){
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            Text("\(amount) €")
                .font(.subheadline)
                .bold()
        }.padding(8)
        .padding(.horizontal, 8)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .frame(height: 40)
            
    }
}

#Preview {
    PaymentItemList(icon: "person", title: "title", subtitle: "subtitle", amount: "33,50")
}

