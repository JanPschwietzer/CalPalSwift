//
//  OpenFoodFactsService.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

class OpenFoodFactsService {
    static let foodFacts: [FoodFacts] = [
        FoodFacts(product:
                    Product(product_name: "Nutella", brands: "Ferrero", serving: "15", nutriments:
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
    
    static let eatenProducts: [EatenItem] = [
        EatenItem(mealTime: MealTime.breakfast, date: Date(), amount: 100, calories: 539, product: Product(product_name: "Nutella", brands: "Ferrero", image: "https://images.openfoodfacts.org/images/products/301/762/042/2003/front_de.439.400.jpg", serving: "15", nutriments:
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
        EatenItem(mealTime: MealTime.lunch, date: Date(), amount: 100, calories: 539, product: Product(product_name: "Nutella", brands: "Ferrero", image: "https://images.openfoodfacts.org/images/products/301/762/042/2003/front_de.439.400.jpg", serving: "15", nutriments:
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
        EatenItem(mealTime: MealTime.dinner, date: Date(), amount: 10, calories: 54, product: Product(product_name: "Nutella", brands: "Ferrero", image: "https://images.openfoodfacts.org/images/products/301/762/042/2003/front_de.439.400.jpg", serving: "15", nutriments:
                Nutriments(
                energyKcal: 539,
                carbohydrates: 57.5,
                fat: 30.9,
                proteins: 6.3,
                sugars: 56.3,
                fiber: 0,
                salt: 0.107,
                saturatedFat: 10.6
                )))
    ]
}
