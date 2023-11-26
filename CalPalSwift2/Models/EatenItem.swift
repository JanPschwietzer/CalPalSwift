//
//  EatenItem.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation
import SwiftData

@Model
class EatenItem {
    var mealTime: MealTime
    var date: Date
    var amount: Int
    var calories: Int
    var product: ProductDatabase
    
    init(mealTime: MealTime, date: Date, amount: Int, calories: Int, product: ProductDatabase) {
        self.mealTime = mealTime
        self.date = date
        self.amount = amount
        self.calories = calories
        self.product = product
    }
}
