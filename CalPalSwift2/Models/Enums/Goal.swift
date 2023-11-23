//
//  Goal.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation

enum Goal {
    case LoseFast
    case Lose
    case Maintain
    case Gain
    case GainFast
    
    var toString : String {
        switch self {
        case .LoseFast: return "-0.5 kg"
        case .Lose: return "-0.25 kg"
        case .Maintain: return "0.0 kg"
        case .Gain: return "+0.25 kg"
        case .GainFast: return "+0.5 kg"
        }
    }
}
