//
//  ChartData.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation
import Charts
import SwiftUI

struct ChartData: Identifiable, Equatable {
    static func == (lhs: ChartData, rhs: ChartData) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    
    var name: String
    var number: Double
}
