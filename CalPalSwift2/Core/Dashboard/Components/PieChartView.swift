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
    @State private var calorieEaten = [ChartData]()
    
    var body: some View {
        Chart {
            ForEach(calorieEaten) { item in
                SectorMark(
                    angle: .value(item.name, item.number),
                    innerRadius: .ratio(0.65),
                    angularInset: 2
                )
                .cornerRadius(15)
                .foregroundStyle(by: .value("Type", item.name))
                .annotation(position: .overlay) {
                    Text("\(item.number) kcal")
                        .font(.headline)
                        .padding(4)
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
        }
        .chartForegroundStyleScale([
            "eaten" : Color(.accent),
            "left": Color(.gray)])
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
        for item in eatenItems {
            eaten += Int(item.amount * Int(item.product.nutriments.energyKcal ?? 0) / 100)
        }
        
        calorieEaten = [
            ChartData(name: "eaten", number: eaten, style: Color.accentColor),
            ChartData(name: "left", number: 2000 - eaten, style: Color.blue)
        ]
    }
}

#Preview {
    PieChartView()
}
