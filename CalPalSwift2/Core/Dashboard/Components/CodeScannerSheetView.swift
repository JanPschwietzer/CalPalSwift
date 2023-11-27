//
//  CodeScannerView.swift
//  CalPalSwift2
//
//  Created by Jan Schwietzer on 27.11.23.
//

import SwiftUI
import CodeScanner

struct CodeScannerSheetView: View {
    @Binding var searchText: String
    @Binding var showScanner: Bool
    @Binding var showAddProductView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                CodeScannerView(codeTypes: [.ean13], simulatedData: "3017620422003") { response in
                    if case let .success(result) = response {
                        searchText = result.string
                        showAddProductView = true
                        showScanner = false
                    }
                }
                VStack {
                    Rectangle()
                        .foregroundStyle(.background)
                    Spacer()
                        .frame(height: 200)
                    Rectangle()
                        .foregroundStyle(.background)
                }
            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        showScanner = false
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddProductView = true
                        showScanner = false
                    } label: {
                        HStack {
                            Text("Proceed")
                            Image(systemName: "chevron.forward")
                        }
                    }
                }
            }
        }
    }
}
