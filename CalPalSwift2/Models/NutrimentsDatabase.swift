//
//  NutrimentsDatabase.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 24.11.23.
//

import Foundation
import SwiftData

@Model
class NutrimentsDatabase {
    var energyKcal: Double
    var carbohydrates: Double
    var fat: Double
    var proteins: Double
    var sugars: Double
    var fiber: Double
    var salt: Double
    var saturatedFat: Double
    
    init(energyKcal: Double = 0, carbohydrates: Double = 0, fat: Double = 0, proteins: Double = 0, sugars: Double = 0, fiber: Double = 0, salt: Double = 0, saturatedFat: Double = 0) {
        self.energyKcal = energyKcal
        self.carbohydrates = carbohydrates
        self.fat = fat
        self.proteins = proteins
        self.sugars = sugars
        self.fiber = fiber
        self.salt = salt
        self.saturatedFat = saturatedFat
    }
}
