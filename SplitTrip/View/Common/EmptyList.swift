//
//  EmptyList.swift
//  SplitTrip
//
//  Created by AudyDev on 11/11/24.
//

import SwiftUI

struct EmptyList: View {
    let textBody: String
    
    var body: some View {
        VStack {
            Image(systemName: "creditcard")
                .resizable()
                .foregroundStyle(.gray)
                .frame(width: 80, height: 55)
                .padding(.bottom, 8)
            Text(textBody)
                .font(.system(size: 22))
                .foregroundColor(.gray)
                .bold()
                .multilineTextAlignment(.center)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(76)
        .padding(.bottom, 16)
    }
}

#Preview {
    EmptyList(textBody: "No tienes grupos asociados, empieza creandote un grupo nuevo")
}
