//
//  ColectiblesCard.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 14/05/25.
//

import SwiftUI

struct CollectiblesCard: View {
//    @Environment(CollectiblesViewModel.self) var collectiblesViewModel
    @Environment(CollectiblesViewModel.self) var collectiblesViewModel: CollectiblesViewModel
    @Environment(Router.self) var router
    
    let collectible: Collectible
    var body: some View {
        NavigationLink {
            CollectibleDetailsView(collectible: collectible)
        } label: {
            Image(collectible.image ?? "")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                router.push(.collectibleDetails(collectible))
            }
            .padding(4)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
            )
            .overlay {
                if !collectible.obtained {
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
        .disabled(!collectible.obtained)
                .onTapGesture {
                        collectiblesViewModel.unlockCollectible(collectible)
                }
    }
}
