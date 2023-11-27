//
//  DashboardView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI
import Charts
import SwiftData

struct DashboardView: View {
    
    @Query private var eatenItems: [EatenItem]
    @Environment(\.modelContext) var modelContext
    
    @State private var isKeyboardVisible = false
    @State private var searchText = ""
    @State private var showAddProductView = false
    @State private var showScanner = false
    
    @State private var calories = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    TabView {
                        PieChartView(calories: calories)
                        BarChartView()
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height: 400)
                    
                    Divider()
                    
                    EatenItemsListView(type: MealTime.breakfast)
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
            .fullScreenCover(isPresented: $showAddProductView) {
                AddProductView(barcode: searchText)
                    .onDisappear {
                        searchText = ""
                        getCalories()
                    }
            }
            .fullScreenCover(isPresented: $showScanner) {
                CodeScannerSheetView(searchText: $searchText, showScanner: $showScanner, showAddProductView: $showAddProductView)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            getCalories()
        }
    }
}

extension DashboardView {
    var bottombar: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(9)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            Button {
                isKeyboardVisible ? hideKeyboard() : nil
                showAddProductView = true
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(
                        searchText.isEmpty ? Color.gray.opacity(0.5) : .accent
                    )
            }
            .disabled(searchText.isEmpty)
            Button {
                showScanner = true
            } label: {
                Image(systemName: "camera")
                    .foregroundColor(isKeyboardVisible ? Color.gray.opacity(0.5) : .accent
                    )
            }
            
        }
        .padding()
        .frame(width: abs(UIScreen.main.bounds.size.width), height: 60, alignment: .center)
        .background(.thinMaterial)
        .offset(y: -7)
    }
}

extension DashboardView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func getCalories() {
        calories =  UserDefaults.standard.integer(forKey: "calories") == 0 ? 2000 : UserDefaults.standard.integer(forKey: "calories")
    }
}

#Preview {
    RootView()
}
