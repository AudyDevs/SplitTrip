//
//  BackgroundGradient.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.gray]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BackgroundGradient()
}
