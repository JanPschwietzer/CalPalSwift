//
//  PieChartView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI
import Charts

struct PieChartView: View {
    
    @EnvironmentObject var vm: RootViewModel
    
    var body: some View {
        Chart {
            ForEach(vm.calorieEaten) { item in
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
            vm.setChartData()
        }
    }
}

#Preview {
    PieChartView()
        .environmentObject(RootViewModel())
}
