//
//  CollectiblesSection.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//

import SwiftUI

struct CollectiblesSection: View {
    let collectibles: [Collectible]
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let firstCollectible = collectibles.first {
                HStack {
                    Text(firstCollectible.rarity.displayName)
                        .font(.poppins(.semiBold, size: 20))
                    Spacer()
                    Text("2/5")
                        .font(.poppins(.semiBold, size: 20))
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                .padding(.horizontal, 4)
            }
            LazyVGrid(columns: columns) {
                ForEach(collectibles) { collectible in
                    VStack(spacing: 6) {
                        NavigationLink {
                            CollectibleDetailsView(
                                item: collectible
                            )
                        } label: {
                            Image(collectible.image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                        }
                        .disabled(collectible.locked)
                    }
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
                    .overlay {
                        if collectible.locked {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.black.opacity(0.6))
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 24))
                                    .foregroundStyle(.white)
                            }
                     
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SkyBackground().sheet(isPresented: .constant(true)) {
            ScrollView {
                CollectiblesSection(
                    collectibles: CollectibleData.getCollectibles(byRarity: .legendary)
                )
                .padding(.horizontal, 16)
                
                CollectiblesSection(
                    collectibles: CollectibleData.getCollectibles(byRarity: .epic)
                )
                .padding(.horizontal, 16)
            }
            .background(Color(uiColor: .secondarySystemBackground))
        }
       
    }
}
