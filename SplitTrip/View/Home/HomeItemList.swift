//
//  HomeItemList.swift
//  SplitTrip
//
//  Created by AudyDev on 5/11/24.
//

import SwiftUI

struct HomeItemList: View {
    let group: Group
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(group.title)
                .font(.headline)
                .bold()
            if (!group.description.isEmpty){
                Text(group.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(height: 45)
        .padding(6)
    }
}

#Preview {
    HomeItemList(group: Group(emailUser: "", title: "title", description: "description", participants: []))
}
