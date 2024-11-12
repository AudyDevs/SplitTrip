//
//  FloatingButton.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct FloatingButton <Destination: View>: View {
    
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.system(size: 32, weight: .bold))
        }
        .padding()
        .background(Color.blue)
        .mask(Circle())
        .shadow(color: Color.blue, radius: 10)
        .zIndex(10)
        .padding(.horizontal, 24)
    }
}
