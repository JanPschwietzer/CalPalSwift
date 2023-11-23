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
    @Published var userSettings: UserSettings
    
    
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
        sortedItems = [
            MealTime.breakfast : [],
            MealTime.lunch : [],
            MealTime.dinner : [],
            MealTime.snack : []
        ]
        for item in eatenItems {
            sortedItems[item.mealTime]?.append(item)
        }
    }
    
    func incActivityLevel() {
        switch userSettings.activityLevel {
        case .LightlyActive:
            userSettings.activityLevel = .ModeratelyActive
            break
        case .ModeratelyActive:
            userSettings.activityLevel = .VeryActive
            break
        case .VeryActive:
            userSettings.activityLevel = .ExtremelyActive
            break
        case .ExtremelyActive:
            break
        }
    }
    func decActivityLevel() {
        switch userSettings.activityLevel {
        case .LightlyActive:
            break
        case .ModeratelyActive:
            userSettings.activityLevel = .LightlyActive
            break
        case .VeryActive:
            userSettings.activityLevel = .ModeratelyActive
            break
        case .ExtremelyActive:
            userSettings.activityLevel = .VeryActive
        }
    }
    func incGoal() {
        switch userSettings.goal {
        case .LoseFast:
            userSettings.goal = .Lose
            break
        case .Lose:
            userSettings.goal = .Maintain
            break
        case .Maintain:
            userSettings.goal = .Gain
            break
        case .Gain:
            userSettings.goal = .GainFast
            break
        case .GainFast:
            break
        }
    }
    
    func decGoal() {
        switch userSettings.goal {
        case .LoseFast:
            break
        case .Lose:
            userSettings.goal = .LoseFast
            break
        case .Maintain:
            userSettings.goal = .Lose
            break
        case .Gain:
            userSettings.goal = .Maintain
            break
        case .GainFast:
            userSettings.goal = .Gain
            break
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
        userSettings = UserSettings(
            gender: Gender.Male,
            birthday: Date(),
            height: 183,
            weight: 85,
            activityLevel: ActivityLevel.LightlyActive,
            goal: Goal.Maintain,
            calories: 2300
        )
    }
}
