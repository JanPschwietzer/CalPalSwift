//
//  BarChartView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 25.11.23.
//

import SwiftUI
import SwiftData
import Charts

struct BarChartView: View {
    
    @Query private var eatenItems: [EatenItem]
    @State private var chartData = [ChartData]()
    
    var body: some View {
        Chart(chartData) { item in
            BarMark(x: .value("number", item.number), y: .value("name", item.name))
                .foregroundStyle(by: .value("Type", item.name))
                .accessibilityHidden(true)
                .annotation(position: .trailing) {
                    Text("\(item.number.formatted())g")
                        .font(.footnote)
                        .foregroundStyle(Color.primary)
                }
        }
        .chartLegend(.hidden)
        .chartXAxis(.hidden)
        .frame(height: 300, alignment: .top)
        .onAppear {
            setChartData()
        }
        .onChange(of: eatenItems) {
            setChartData()
        }
    }
}

extension BarChartView {
    func setChartData() {
        
        let nutriments = NutrimentsDatabase(
        energyKcal: 0, carbohydrates: 0, fat: 0, proteins: 0, sugars: 0, fiber: 0, salt: 0, saturatedFat: 0
        )
        
        for item in eatenItems.filter({ item in
            Calendar.current.isDateInToday(item.date)
        }) {
            nutriments.carbohydrates += Double(item.amount * Int(item.product.nutriments.carbohydrates ) / 100)
            nutriments.sugars += Double(item.amount * Int(item.product.nutriments.sugars ) / 100)
            nutriments.fat += Double(item.amount * Int(item.product.nutriments.fat ) / 100)
            nutriments.saturatedFat += Double(item.amount * Int(item.product.nutriments.saturatedFat ) / 100)
            nutriments.fiber += Double(item.amount * Int(item.product.nutriments.fiber ) / 100)
            nutriments.proteins += Double(item.amount * Int(item.product.nutriments.proteins ) / 100)
            nutriments.salt += Double(item.amount * Int(item.product.nutriments.salt ) / 100)
        }
        
        chartData = [
            ChartData(name: "carbs", number: nutriments.carbohydrates ),
            ChartData(name: "sugar", number: nutriments.sugars ),
            ChartData(name: "protein", number: nutriments.proteins ),
            ChartData(name: "fiber", number: nutriments.fiber ),
            ChartData(name: "fat", number: nutriments.fat ),
            ChartData(name: "saturated fat", number: nutriments.saturatedFat ),
            ChartData(name: "salt", number: nutriments.salt)
        ]
    }
}

#Preview {
    BarChartView()
}
