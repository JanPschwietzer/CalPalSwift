//
//  AddProductView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 26.11.23.
//

import SwiftUI
import SwiftData

struct AddProductView: View {
    
    let barcode: String
    
    @Query private var eatenItems: [EatenItem]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var date = Date()
    @State private var mealTime = MealTime.breakfast
    @State private var amount = 0
    @State private var openFoodFactsData = FoodFacts(product: Product(id: "", product_name: "", brands: "", nutriments: Nutriments()))
    @State private var showNutritionalValues = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("General Info") {
                    TextField("Brand", text: $openFoodFactsData.product.brands)
                    TextField("Product", text: $openFoodFactsData.product.product_name)
                    DatePicker("When did you eat this?", selection: $date, displayedComponents: .date)
                    Picker("Mealtime", selection: $mealTime) {
                        ForEach(MealTime.allCases, id: \.self) { value in
                            Text(value.rawValue)
                        }
                    }
                }
                Section("How much did you eat? (g)") {
                    TextField("in gramms", value: $amount, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        
                }
                Section {
                    if showNutritionalValues {
                        HStack {
                            Text("energy")
                                .frame(width: 100, alignment: .leading)
                            
                            Divider()
                            TextField("kcal", value: $openFoodFactsData.product.nutriments.energyKcal, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                        HStack {
                            Text("carbs")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", openFoodFactsData.product.nutriments.carbohydrates))g", value: $openFoodFactsData.product.nutriments.carbohydrates, in: 0...100, step: 0.1)
                        }
                        HStack {
                            Text("- sugar")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", openFoodFactsData.product.nutriments.sugars))g", value: $openFoodFactsData.product.nutriments.sugars, in: 0...openFoodFactsData.product.nutriments.carbohydrates, step: 0.1)
                        }
                        HStack {
                            Text("fat")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", openFoodFactsData.product.nutriments.fat))g", value: $openFoodFactsData.product.nutriments.fat, in: 0...100, step: 0.1)
                        }
                        HStack {
                            Text("- saturated")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", openFoodFactsData.product.nutriments.saturatedFat))g", value: $openFoodFactsData.product.nutriments.saturatedFat, in: 0...openFoodFactsData.product.nutriments.fat, step: 0.1)
                        }
                        HStack {
                            Text("protein")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", openFoodFactsData.product.nutriments.proteins))g", value: $openFoodFactsData.product.nutriments.proteins, in: 0...100, step: 0.1)
                        }
                        HStack {
                            Text("fiber")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", openFoodFactsData.product.nutriments.fiber))g", value: $openFoodFactsData.product.nutriments.fiber, in: 0...100, step: 0.1)
                        }
                        HStack {
                            Text("salt")
                                .frame(width: 100, alignment: .leading)
                            Divider()
                            Stepper("\(String(format: "%.1f", openFoodFactsData.product.nutriments.salt))g", value: $openFoodFactsData.product.nutriments.salt, in: 0...100, step: 0.1)
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
                        let item = openFoodFactsData.toEatenItem(mealTime: mealTime, date: date, amount: amount)
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
            .onTapGesture {
                hideKeyboard()
            }
            .task {
                openFoodFactsData = await OpenFoodFactsService.getFoodFactsData(barcode: barcode)
            }
        }
    }
}

extension AddProductView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    AddProductView(barcode: "")
}
