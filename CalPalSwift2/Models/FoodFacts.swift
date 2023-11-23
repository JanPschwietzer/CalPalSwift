//
//  FoodFacts.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

struct FoodFacts: Codable, Equatable {
    var product: Product
    
    enum CodingKeys: String, CodingKey {
        case product = "product"
    }
}
