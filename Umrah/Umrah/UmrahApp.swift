//
//  UmrahApp.swift
//  Umrah
//
//  Created by Arman Sarvardin on 28.07.2024.
//

import SwiftUI

@main
struct UmrahApp: App {
    @AppStorage("app_locale") var locale: String = Locale.current.identifier
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .accentColor(Color(.greenAccent))
        }
        
    }
}
