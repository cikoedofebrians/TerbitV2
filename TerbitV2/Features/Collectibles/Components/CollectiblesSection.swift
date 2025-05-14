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
            if let firstCollectible = collectibles.first, let rarity = firstCollectible.rarityValue {
                HStack {
                    Text(rarity.capitalized)
                        .font(.poppins(.semiBold, size: 20))
                    Spacer()
                    Text("\(collectibles.filter { $0.obtained }.count)/\(collectibles.count)")
                        .font(.poppins(.semiBold, size: 20))
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                .padding(.horizontal, 4)
            }
            LazyVGrid(columns: columns) {
                ForEach(collectibles) { collectible in
                    CollectiblesCard(collectible: collectible)                }
            }
        }
    }
}

