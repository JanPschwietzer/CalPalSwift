//
//  EatenItem.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

struct EatenItem: Equatable, Identifiable {
    var id = UUID()
    
    let mealTime: MealTime
    let date: Date
    let amount: Int
    let calories: Int
    let product: Product
}
