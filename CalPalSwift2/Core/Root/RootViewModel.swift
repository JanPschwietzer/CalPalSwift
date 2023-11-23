//
//  RootViewModel.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation
import SwiftUI

class RootViewModel: ObservableObject {
    
    @Published var eatenItems: [EatenItem] {
        didSet {
            setChartData()
            setSortedItems()
        }
    }
    @Published var calorieEaten: [ChartData]
    @Published var nutritionsEaten: [ChartData]
    
    @Published var sortedItems: [MealTime: [EatenItem]]
    
    
    func setChartData() {
        
        var eaten = 0
        for item in eatenItems {
            eaten += Int(item.amount * Int(item.product.nutriments.energyKcal ?? 0) / 100)
        }
        
        calorieEaten = [
            ChartData(name: "eaten", number: eaten, style: Color.accentColor),
            ChartData(name: "left", number: 2000 - eaten, style: Color.blue)
        ]
    }
    
    func setSortedItems() {
        for item in eatenItems {
            sortedItems[item.mealTime]?.append(item)
        }
    }
    
    init() {
        self.eatenItems = OpenFoodFactsService.eatenProducts
        
        calorieEaten = []
        nutritionsEaten = []
        
        sortedItems = [
            MealTime.breakfast : [],
            MealTime.lunch : [],
            MealTime.dinner : [],
            MealTime.snack : []
        ]
    }
}
