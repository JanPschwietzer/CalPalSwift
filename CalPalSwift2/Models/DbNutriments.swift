//
//  DbNutriments.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 24.11.23.
//

import Foundation

struct DbNutriments: Identifiable {
    var id = UUID()
    var energyKcal: Double?
    var carbohydrates: Double?
    var fat: Double?
    var proteins: Double?
    var sugars: Double?
    var fiber: Double?
    var salt: Double?
    var saturatedFat: Double?
}
