//
//  DashboardView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI
import Charts

struct DashboardView: View {
    
    @EnvironmentObject var vm: RootViewModel
    
    @State private var isKeyboardVisible = false

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    tabView
                    
                    Divider()
                    
                    EatenItemsListView(eatenItems: vm.sortedItems[MealTime.breakfast] ?? [])
                        .environmentObject(vm)
                    EatenItemsListView(eatenItems: vm.sortedItems[MealTime.lunch] ?? [])
                        .environmentObject(vm)
                    EatenItemsListView(eatenItems: vm.sortedItems[MealTime.dinner] ?? [])
                        .environmentObject(vm)
                    EatenItemsListView(eatenItems: vm.sortedItems[MealTime.snack] ?? [])
                        .environmentObject(vm)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    bottombar
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    bottombar
                }
            }
        }
        .onAppear {
            vm.setSortedItems()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

extension DashboardView {
    var tabView: some View {
        TabView {
            PieChartView()
                .environmentObject(vm)
            PieChartView()
                .environmentObject(vm)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: 400)
    }
    
    
    var bottombar: some View {
        HStack {
            TextField("Search", text: $vm.searchText)
                .padding(9)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            Button {
                isKeyboardVisible ? hideKeyboard() : nil
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(
                        vm.searchText.isEmpty ? Color.gray.opacity(0.5) : .accent
                    )
            }
            .disabled(vm.searchText.isEmpty)
            
            Button {
                
            } label: {
                Image(systemName: "camera")
                    .foregroundColor(isKeyboardVisible ? Color.gray.opacity(0.5) : .accent
                    )
            }
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width, height: 60, alignment: .center)
        .background(.thinMaterial)
        .offset(y: -7)
    }
}

#Preview {
    RootView()
}
