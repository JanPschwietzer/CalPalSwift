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
    @Published var userSettings: UserSettings
    @Published var calorieEaten: [ChartData]
    @Published var nutritionsEaten: [ChartData]
    @Published var sortedItems: [MealTime: [EatenItem]]
    @Published var searchText: String = ""
    
    init() {
        self.eatenItems = OpenFoodFactsService.eatenProducts
        calorieEaten = []
        nutritionsEaten = []
        sortedItems = [:]
        
        userSettings = UserSettings(gender: Gender.Male, birthday: Date(), height: 160, weight: 70, activityLevel: ActivityLevel.ModeratelyActive, goal: Goal.Maintain, calories: 2000)
    }
}

/*
 
    DASHBOARD VIEW METHODS
 
 */
extension RootViewModel {
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
}

/*
 
    USERSETTINGS METHODS
 
 */
extension RootViewModel {
    
    func saveUserSettings() {
        UserDefaults.standard.set(true, forKey: "userSettingsSaved")
        UserDefaults.standard.set(userSettings.gender.rawValue, forKey: "gender")
        UserDefaults.standard.set(userSettings.birthday.ISO8601Format(), forKey: "birthday")
        UserDefaults.standard.set(userSettings.height, forKey: "height")
        UserDefaults.standard.set(userSettings.weight, forKey: "weight")
        UserDefaults.standard.set(userSettings.activityLevel.rawValue, forKey: "activityLevel")
        UserDefaults.standard.set(userSettings.goal.rawValue, forKey: "goal")
        UserDefaults.standard.set(userSettings.calories, forKey: "calories")
        
        debugPrint("UserSettings saved!")
    }
    func getUserSettings() {
        userSettings = UserSettings(
            gender: Gender(rawValue: UserDefaults.standard.string(forKey: "gender") ?? Gender.Male.rawValue) ?? Gender.Male,
            birthday: ISO8601DateFormatter().date(from: UserDefaults.standard.string(forKey: "birthday") ?? Date().ISO8601Format()) ?? Date(),
            height: UserDefaults.standard.integer(forKey: "height"),
            weight: UserDefaults.standard.integer(forKey: "weight"),
            activityLevel: ActivityLevel(rawValue: UserDefaults.standard.string(forKey: "activityLevel") ?? ActivityLevel.ModeratelyActive.rawValue) ?? ActivityLevel.ModeratelyActive,
            goal: Goal(rawValue: UserDefaults.standard.string(forKey: "goal") ?? Goal.Maintain.rawValue) ?? Goal.Maintain,
            calories: UserDefaults.standard.integer(forKey: "calories")
        )
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
}
