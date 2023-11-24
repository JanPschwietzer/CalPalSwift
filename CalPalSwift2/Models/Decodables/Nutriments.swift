//
//  Nutriments.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

struct Nutriments: Codable {
    var energyKcal: Double?
    var carbohydrates: Double?
    var fat: Double?
    var proteins: Double?
    var sugars: Double?
    var fiber: Double?
    var salt: Double?
    var saturatedFat: Double?
    
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
}
