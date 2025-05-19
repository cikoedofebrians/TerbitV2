//
//  ColectiblesCard.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 14/05/25.
//

import SwiftUI

struct CollectiblesCard: View {
    @EnvironmentObject var collectiblesViewModel: CollectiblesViewModel
    @EnvironmentObject var router: Router
    
    @Binding var collectible: Collectible
    
    var body: some View {
        NavigationLink {
            CollectibleDetailsView(collectible: collectible)
        } label: {
            Image(collectible.image ?? "")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                )
                .overlay(alignment: .topTrailing) {
        
                    if collectible.obtained && collectible.skin != nil {
                        Image(systemName: "hanger")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(8)
                            .background {
                                Circle()
                                    .fill(collectiblesViewModel.currentSkin?.id == collectible.skin?.id ? Color.yellow.opacity(0.3)  : Color.black.opacity(0.2))
                            }
                            .padding(8)
                        
                    }
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
    }
}
