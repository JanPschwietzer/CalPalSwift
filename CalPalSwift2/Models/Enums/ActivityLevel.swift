//
//  ActivityLevel.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

enum ActivityLevel {
    case LightlyActive
    case ModeratelyActive
    case VeryActive
    case ExtremelyActive
    
    
    var toString : String {
      switch self {
      // Use Internationalization, as appropriate.
      case .LightlyActive: return "Lightly Active"
      case .ModeratelyActive: return "Moderately Active"
      case .VeryActive: return "Very Active"
      case .ExtremelyActive: return "Extremly Active"
      }
    }
}
