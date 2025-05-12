//
//  CollectiblesView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//


import SwiftUI

struct CollectiblesView: View {
    @Environment(\.dismiss) var dismiss
    
    
    @State var collectiblesGroupedByRarity: [[Collectible]] = CollectibleData.getAllCollectiblesSortedByRarity()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 0) {
                    CollectiblesBadge()
                        .padding(.bottom, 20)
                    ForEach(0..<collectiblesGroupedByRarity.count, id: \.self) { index in
                        CollectiblesSection(collectibles: collectiblesGroupedByRarity[index])
                            .padding(.bottom, 20)
                    }
                    
                }
                .padding(16)

            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    DismissButton()
                }
            })
            .navigationTitle("Collectibles")
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.hidden)
        }
        .presentationBackground(Color(uiColor: .secondarySystemBackground))
    }
}

#Preview {
    SkyBackground()
        .sheet(isPresented: .constant(true)) {
            CollectiblesView()
        }
}
