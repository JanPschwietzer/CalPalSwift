//
//  FoodFacts.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

struct FoodFacts: Codable {
    var product: Product
    
    enum CodingKeys: String, CodingKey {
        case product = "product"
    }
        
    func toEatenItem(mealTime: MealTime, date: Date, amount: Int) -> EatenItem {
        
        let calories = CalculateCaloriesService.calculateCalories(product: product, amount: amount)
        
        return EatenItem(mealTime: mealTime, date: date, amount: amount, calories: calories, product: product.toProductDatabase())
    }
}
