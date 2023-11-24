//
//  OpenFoodFactsService.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

class OpenFoodFactsService {
    
    static func getOpenFoodFactsData(barcode: String) -> FoodFacts? {
        let url = URL(string: "https://world.openfoodfacts.org/api/v0/product/\(barcode).json")!
        var foodFactsData: FoodFacts?
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                foodFactsData = try JSONDecoder().decode(FoodFacts.self, from: data)
            } catch {
                debugPrint(error)
            }
        }
        task.resume()
        return foodFactsData
    }
    
    func saveProductDataInDb() {
        
    }
    
    
    
    static let foodFacts: [FoodFacts] = [
        FoodFacts(product:
                    Product(id: "3017620422003", product_name: "Nutella", brands: "Ferrero", serving: "15", nutriments:
                                    Nutriments(
                                    energyKcal: 539,
                                    carbohydrates: 57.5,
                                    fat: 30.9,
                                    proteins: 6.3,
                                    sugars: 56.3,
                                    fiber: 0,
                                    salt: 0.107,
                                    saturatedFat: 10.6
                                    ))),
    ]
    
    let eatenProduct =
        EatenItem(mealTime: MealTime.breakfast, date: Date(), amount: 100, calories: 539, product: ProductDatabase(id: "3017620422003", product_name: "Nutella", brands: "Ferrero", serving: "15", nutriments: NutrimentsDatabase(
            energyKcal: 539,
            carbohydrates: 57.5,
            fat: 30.9,
            proteins: 6.3,
            sugars: 56.3,
            fiber: 0,
            salt: 0.107,
            saturatedFat: 10.6
            )))
}
