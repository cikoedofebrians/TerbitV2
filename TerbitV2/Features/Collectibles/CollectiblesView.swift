//
//  CollectiblesView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//


import SwiftUI

struct CollectiblesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var collectiblesViewModel: CollectiblesViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CollectiblesBadge()
                        .padding(.bottom, 20)
                    ForEach(collectiblesViewModel.collectiblesGroupedByRarity, id: \.self) { collectibles in
                        CollectiblesSection(collectibles: collectibles )
                            .padding(.bottom, 20)
                    }
                }
                .padding(16)
            }

            .navigationTitle("Collectibles")
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.hidden)
            .ignoresSafeArea(edges: .bottom)
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                DismissButton()
            }
        })
        .presentationBackground(Color(uiColor: .secondarySystemBackground))
    }
}
