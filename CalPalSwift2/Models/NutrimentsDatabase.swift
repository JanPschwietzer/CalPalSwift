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
    var energyKcal: Double?
    var carbohydrates: Double?
    var fat: Double?
    var proteins: Double?
    var sugars: Double?
    var fiber: Double?
    var salt: Double?
    var saturatedFat: Double?
    
    init(energyKcal: Double? = nil, carbohydrates: Double? = nil, fat: Double? = nil, proteins: Double? = nil, sugars: Double? = nil, fiber: Double? = nil, salt: Double? = nil, saturatedFat: Double? = nil) {
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
