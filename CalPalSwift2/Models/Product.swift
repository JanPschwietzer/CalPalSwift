//
//  Product.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

struct Product: Codable, Equatable, Identifiable {
    
    var product_name: String
    var brands: String
    var image: String?
    var nutriscore: String?
    var serving: String?
    var nutriments: Nutriments
    
    var id: String {
        product_name + brands
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case product_name = "product_name"
        case brands = "brands"
        case image = "image_front_url"
        case nutriscore = "nutriscore_grade"
        case serving = "serving_quantity"
        case nutriments = "nutriments"
    }
}
