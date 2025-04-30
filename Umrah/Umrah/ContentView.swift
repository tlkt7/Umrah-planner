//
//  ContentView.swift
//  Umrah
//
//  Created by Arman Sarvardin on 28.07.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigation: Navigation = .init()
    
    var body: some View {
        NavigationStack(path: $navigation.navigationPath) {
            NavigationView {
                Welcome()
            }
            
        }
        .environmentObject(navigation)
    }
}

#Preview {
    ContentView()
}
