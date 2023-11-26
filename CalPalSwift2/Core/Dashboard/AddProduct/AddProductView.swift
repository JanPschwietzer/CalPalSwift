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
    
    @State private var showNutritionalValues = false
    
    @State private var energyKcal = ""
    @State private var carbohydrates = 0.0
    @State private var fat = 0.0
    @State private var proteins = 0.0
    @State private var sugars = 0.0
    @State private var fiber = 0.0
    @State private var salt = 0.0
    @State private var saturatedFat = 0.0
    @State private var gramsEaten = ""
    
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
                Section("How much did you eat? (g)") {
                    TextField("in gramms", value: $gramsEaten, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        
                }
                Section {
                    if showNutritionalValues {
                        HStack {
                            Text("energy")
                                .frame(width: 100, alignment: .leading)
                            
                            Divider()
                            TextField("kcal", text: $energyKcal)
                                .keyboardType(.numberPad)
                        }
                        HStack {
                            Text("carbs")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", carbohydrates))g", value: $carbohydrates, in: 0...100, step: 0.1)
                        }
                        HStack {
                            Text("- sugar")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", sugars))g", value: $sugars, in: 0...carbohydrates, step: 0.1)
                        }
                        HStack {
                            Text("fat")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", fat))g", value: $fat, in: 0...100, step: 0.1)
                        }
                        HStack {
                            Text("- saturated")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", saturatedFat))g", value: $saturatedFat, in: 0...fat, step: 0.1)
                        }
                        HStack {
                            Text("protein")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", proteins))g", value: $proteins, in: 0...100, step: 0.1)
                        }
                        HStack {
                            Text("fiber")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", fiber))g", value: $fiber, in: 0...100, step: 0.1)
                        }
                        HStack {
                            Text("salt")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", salt))g", value: $salt, in: 0...100, step: 0.1)
                        }
                    }
                } header: {
                    Button {
                        showNutritionalValues.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.down")
                                .rotationEffect(Angle(degrees: showNutritionalValues ? 180: 0))
                            Text("Edit Nutritional values")
                        }
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundStyle(.gray)
                        .animation(.easeInOut, value: showNutritionalValues)
                    }
                }
            }
            .formStyle(.grouped)
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
