//
//  CalculateCalories.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 27.11.23.
//

import Foundation

class CalculateCaloriesService {
    
    static func calculateCalories(product: Product, amount: Int) -> Int {
        return Int(Double(amount) * (product.nutriments.energyKcal ))
    }
}
