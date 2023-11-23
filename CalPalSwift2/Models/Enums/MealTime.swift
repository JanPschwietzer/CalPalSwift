//
//  MealTime.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

enum MealTime {
    case breakfast
    case lunch
    case dinner
    case snack
    
    var toString : String {
      switch self {
      // Use Internationalization, as appropriate.
      case .breakfast: return "Breakfast"
      case .lunch: return "Lunch"
      case .dinner: return "Dinner"
      case .snack: return "Snack"
      }
    }
}
