//
//  TitleApp.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct TitleApp: View {
    var body: some View {
        Image("IconColor")
            .resizable()
            .frame(width: 150, height: 150)
        Text("Split Trip")
            .font(.custom("Pacifico-Regular", size: 52))
            .bold()
            .italic()
    }
}

#Preview {
    TitleApp()
}
