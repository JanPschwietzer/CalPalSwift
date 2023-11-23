//
//  EatenItemsListView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 23.11.23.
//

import SwiftUI

struct EatenItemsListView: View {
    
    @EnvironmentObject var vm: RootViewModel
    let eatenItems: [EatenItem]
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if eatenItems.count > 0 {
                Text(eatenItems.first!.mealTime.toString)
                    .padding(.top)
                    .foregroundStyle(Color(.systemGray))
            }
            ForEach(eatenItems) { item in
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
                        Text("\(item.product.brands) \(item.product.product_name)")
                            .font(.headline)
                            .lineLimit(1)
                        Text("\(item.calories) kcal")
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
        .environmentObject(RootViewModel())
}
