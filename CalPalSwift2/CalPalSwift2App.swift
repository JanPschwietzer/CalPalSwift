//
//  CalPalSwift2App.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI
import SwiftData

@main
struct CalPalSwift2App: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [EatenItem.self, ProductDatabase.self, NutrimentsDatabase.self])
    }
}
