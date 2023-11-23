//
//  Root.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var vm = RootViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    DashboardView()
                        .environmentObject(vm)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Dashboard")
                        }
                    StatisticsView()
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Wochenbericht")
                        }
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("CalPal")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(20)
                    }
                    .padding(.all, 20)
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.accentColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .systemBackground
        }
    }
}

#Preview {
    RootView()
}
