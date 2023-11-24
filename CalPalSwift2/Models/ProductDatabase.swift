//
//  ProductDatabase.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 24.11.23.
//

import Foundation
import SwiftData

@Model
class ProductDatabase {
    var id: String
    var product_name: String
    var brands: String
    var image: String?
    var nutriscore: String?
    var serving: String?
    var nutriments: NutrimentsDatabase
    
    init(id: String, product_name: String, brands: String, image: String? = nil, nutriscore: String? = nil, serving: String? = nil, nutriments: NutrimentsDatabase) {
        self.id = id
        self.product_name = product_name
        self.brands = brands
        self.image = image
        self.nutriscore = nutriscore
        self.serving = serving
        self.nutriments = nutriments
    }
}
