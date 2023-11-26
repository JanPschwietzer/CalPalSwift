//
//  AddProductView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 26.11.23.
//

import SwiftUI
import SwiftData

struct AddProductView: View {
    
    @Query private var eatenItems: [EatenItem]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var date = Date()
    @State private var mealTime = MealTime.breakfast
    
    @State private var product = Product(id: "", product_name: "", brands: "", nutriments: Nutriments())
    
    var body: some View {
        NavigationView {
            Form {
                Section("General Info") {
                    TextField("Brand", text: $product.brands)
                    TextField("Product", text: $product.product_name)
                    DatePicker("When did you eat this?", selection: $date, displayedComponents: .date)
                    Picker("Mealtime", selection: $mealTime) {
                        ForEach(MealTime.allCases, id: \.self) { value in
                            Text(value.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("Add Product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        let item = OpenFoodFactsService().eatenProduct
                        modelContext.insert(item)
                        dismiss()
                    } label: {
                        HStack {
                            Text("Save")
                            Image(systemName: "chevron.forward")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddProductView()
}
