//
//  DatabaseProduct.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 24.11.23.
//

import Foundation

struct DbProduct: Identifiable {
    var id: String
    var product_name: String
    var brands: String
    var image: String?
    var nutriscore: String?
    var serving: String?
    var nutriments: DbNutriments
}
