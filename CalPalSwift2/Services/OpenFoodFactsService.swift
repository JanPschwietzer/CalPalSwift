//
//  OpenFoodFactsService.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

class OpenFoodFactsService {
    
    static func getFoodFactsData(barcode: String) async -> FoodFacts {
        let url = URL(string: "https://world.openfoodfacts.org/api/v0/product/\(barcode).json")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedData = try? JSONDecoder().decode(FoodFacts.self, from: data) {
                return decodedData
            }
        } catch {
            print("Invalid data")
        }
        return FoodFacts(product: Product(id: "", product_name: "", brands: "", nutriments: Nutriments()))
    }
}
