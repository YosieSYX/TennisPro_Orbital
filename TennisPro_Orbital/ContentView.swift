//
//  ContentView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 24/5/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var email:String=""
    @State private var password:String=""
    var body: some View {
       AuthView()
    }
}
 
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
