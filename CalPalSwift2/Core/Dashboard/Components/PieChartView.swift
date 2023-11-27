//
//  PieChartView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI
import Charts
import SwiftData

struct PieChartView: View {
    
    @Query private var eatenItems: [EatenItem]
    @State private var chartData = [ChartData]()
    
    let calories: Int
    @State private var colors: KeyValuePairs<String, Color> = ["eaten" : Color(.accent),"left": Color(.gray)]
    @State private var hasChanged = 1000
    
    var body: some View {
        Chart(chartData) { item in
            SectorMark(
                angle: .value(item.name, item.number),
                innerRadius: .ratio(0.65),
                angularInset: 2
            )
            .cornerRadius(15)
            .foregroundStyle(by: .value("Type", item.name))
            .annotation(position: .overlay) {
                Text("\(item.number.formatted()) kcal")
                    .font(.headline)
                    .padding(4)
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
        .chartForegroundStyleScale(colors)
        .frame(height: 300, alignment: .top)
        .onAppear {
            setChartData()
            
        }
        .onChange(of: eatenItems) {
            setChartData()
        }
    
    }
}

extension PieChartView {
    func setChartData() {
        
        var eaten = 0
        for item in eatenItems.filter({ item in
            Calendar.current.isDateInToday(item.date)
        }) {
            eaten += Int(Double(item.amount) * (item.product.nutriments.energyKcal ) / 100)
        }
        
        if calories < eaten {
            chartData = [
                ChartData(name: "left", number: Double(abs(calories - eaten))),
                ChartData(name: "eaten", number: Double(calories))
            ]
            colors = ["eaten" : Color(.gray),"left": Color(.red)]
        } else {
            chartData = [
                ChartData(name: "eaten", number: Double(eaten)),
                ChartData(name: "left", number: Double(calories - eaten))
            ]
            colors = ["eaten" : Color(.accent),"left": Color(.gray)]
        }
        hasChanged = Int.random(in: 1...1000)
    }
}

#Preview {
    PieChartView(calories: 2000)
}
