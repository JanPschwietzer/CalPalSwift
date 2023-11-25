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
    @State private var isKeyboardVisible = false
    @State private var searchText = ""
    
    let calories =  UserDefaults.standard.integer(forKey: "calories") == 0 ? 2000 : UserDefaults.standard.integer(forKey: "calories")
    
    @Environment(\.modelContext) var modelContext

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    TabView {
                        PieChartView(calories: calories)
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
        }
        .onTapGesture {
            hideKeyboard()
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
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(
                        searchText.isEmpty ? Color.gray.opacity(0.5) : .accent
                    )
            }
            .disabled(searchText.isEmpty)
            
            Button {
                let item = OpenFoodFactsService().eatenProduct
                modelContext.insert(item)
                
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
