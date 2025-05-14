//
//  CollectiblesView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//


import SwiftUI

struct CollectiblesView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(CollectiblesViewModel.self) var collectiblesViewModel: CollectiblesViewModel
    
    var body: some View {
        @Bindable var collectiblesViewModel = collectiblesViewModel
        NavigationStack {
            ScrollView {
                VStack (spacing: 0) {
//                    Text("\(collectiblesViewModel.isLoading)")
//                    
//                    Button {
//                        collectiblesViewModel.isLoading.toggle()
//                    } label: {
//                        Text("Trigger Loading")
//                    }
//                    
                    CollectiblesBadge()
                        .padding(.bottom, 20)               
//                    ForEach(collectiblesViewModel.collectibles) { collectible in
//                        CollectiblesCard(collectible: collectible)
//                    }
                    ForEach(0..<collectiblesViewModel.collectiblesGroupedByRarity.count, id: \.self) { index in
                        CollectiblesSection(collectibles: collectiblesViewModel.collectiblesGroupedByRarity[index])
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
