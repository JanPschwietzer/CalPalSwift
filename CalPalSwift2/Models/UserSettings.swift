//
//  UserSettings.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

struct UserSettings {
    var gender: Gender
    var birthday: Date
    var height: Int
    var weight: Int
    var activityLevel: ActivityLevel
    var goal: Goal
    var calories: Int
    
    init(gender: Gender, birthday: Date, height: Int, weight: Int, activityLevel: ActivityLevel, goal: Goal, calories: Int) {
        self.gender = gender
        self.birthday = birthday
        self.height = height
        self.weight = weight
        self.activityLevel = activityLevel
        self.goal = goal
        self.calories = calories
    }
}
