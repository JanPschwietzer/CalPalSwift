//
//  ChartData.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import Foundation
import Charts
import SwiftUI

struct ChartData: Identifiable {
    var id = UUID()
    
    var name: String
    var number: Int
    var style: any ShapeStyle
}
