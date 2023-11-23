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
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    @State private var searchText = ""
    @State private var isKeyboardVisible = false
    @State private var keyboardHeight: CGFloat = 7
    @State private var isPresentingScanner = false
    @State private var isPresentingAddProductView = false

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        tabView
                        
                        Divider()
                        
                        EatenItemsListView(eatenItems: vm.sortedItems[MealTime.breakfast] ?? [], label: MealTime.breakfast.toString)
                            .environmentObject(vm)
                        EatenItemsListView(eatenItems: vm.sortedItems[MealTime.lunch] ?? [], label: MealTime.breakfast.toString)
                            .environmentObject(vm)
                        EatenItemsListView(eatenItems: vm.sortedItems[MealTime.dinner] ?? [], label: MealTime.breakfast.toString)
                            .environmentObject(vm)
                        EatenItemsListView(eatenItems: vm.sortedItems[MealTime.snack] ?? [], label: MealTime.breakfast.toString)
                            .environmentObject(vm)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
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
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { (notification) in
                guard let userInfo = notification.userInfo,
                      let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                else { return }
                withAnimation {
                    self.keyboardHeight = keyboardRect.height + 7 - geometry.safeAreaInsets.bottom
                    self.isKeyboardVisible = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                withAnimation {
                    self.keyboardHeight = 7
                    self.isKeyboardVisible = false
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
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
            TextField("Search", text: $searchText)
                .padding(9)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.numberPad)
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
                
            } label: {
                Image(systemName: "camera")
                    .foregroundColor(isKeyboardVisible ? Color.gray.opacity(0.5) : .accent
                    )
            }
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width, height: 60, alignment: .center)
        .background(.thinMaterial)
        .offset(y: -keyboardHeight)
    }
}

#Preview {
    RootView()
}
