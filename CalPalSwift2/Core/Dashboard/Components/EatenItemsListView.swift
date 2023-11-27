//
//  EatenItemsListView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI
import SwiftData

struct EatenItemsListView: View {
    
    let type: MealTime
    
    @Environment(\.modelContext) var modelContext
    
    @Query var eatenItems: [EatenItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(eatenItems.filter({ item in
                Calendar.current.isDateInToday(item.date)
            }).sorted(by: { lhs, rhs in
                lhs.date > rhs.date
            })) { item in
                HStack {
                    AsyncImage(url: URL(string: item.product.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                        
                    } placeholder: {
                        Image(systemName: "questionmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                    }
                    VStack(alignment: .leading) {
                        Text("\(item.product.product_name)")
                            .font(.headline)
                            .lineLimit(1)
                        Text("\(Int(Double(item.amount) * (item.product.nutriments.energyKcal ) / 100)) kcal")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .font(.title2)
                    .padding(.trailing)
                    .foregroundStyle(.primary)
                    Button {
                        modelContext.delete(item)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    .font(.title2)
                    .foregroundStyle(.primary)
                }
                .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    DashboardView()
}
