//
//  Root.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    DashboardView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Dashboard")
                        }
                    StatisticsView()
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Wochenbericht")
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
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        SettingsView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Image(systemName: "gear")
                            .foregroundStyle(.white)
                    }
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
