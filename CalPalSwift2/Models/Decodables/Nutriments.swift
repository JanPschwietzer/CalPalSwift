//
//  Nutriments.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

struct Nutriments: Codable {
    var energyKcal: Double = 0
    var carbohydrates: Double = 0
    var fat: Double = 0
    var proteins: Double = 0
    var sugars: Double = 0
    var fiber: Double = 0
    var salt: Double = 0
    var saturatedFat: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case energyKcal = "energy-kcal_100g"
        case carbohydrates = "carbohydrates_100g"
        case fat = "fat_100g"
        case proteins = "proteins_100g"
        case sugars = "sugars_100g"
        case fiber = "fiber_100g"
        case salt = "salt_100g"
        case saturatedFat = "saturated-fat_100g"
    }
    
    func toNutrimentsDatabase() -> NutrimentsDatabase {
        return NutrimentsDatabase(
            energyKcal: energyKcal,
            carbohydrates: carbohydrates,
            fat: fat,
            proteins: proteins,
            sugars: sugars,
            fiber: fiber,
            salt: salt,
            saturatedFat: saturatedFat
        )
    }
}
