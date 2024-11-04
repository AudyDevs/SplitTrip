//
//  ContentView.swift
//  SplitTrip
//
//  Created by AudyDev on 2/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Label("Search", systemImage: "magnifyingglass")
                    Label("Search", systemImage: "magnifyingglass")
                    Label("Search", systemImage: "magnifyingglass")
                    Label("Search", systemImage: "magnifyingglass")
                }
            }.toolbar {
                ToolbarItemGroup (placement: .navigationBarTrailing) {
                    Button(action: {
                        print("otro")
                    }, label: {
                        Label("Search", systemImage: "magnifyingglass")
                    })
                    Menu {
                        Button(action: {
                            print("otro")
                        }, label: {
                            Label("Search", systemImage: "magnifyingglass")
                        })
                        Button("Opcion 2") {
                            print("Seleccionaste opcion 2")
                        }
                        Button("Opcion 3") {
                            print("Seleccionaste opcion 3")
                        }
                    } label: {
                        Label("Options", systemImage: "ellipsis.circle")
                    }
                }
            }.navigationBarTitle("Title", displayMode: .inline)
                .searchable(text: $searchText)
        }
    }
}

#Preview {
    ContentView()
}
