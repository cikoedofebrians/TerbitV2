//
//  CollectibleDetailsView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//

import SwiftUI

struct CollectibleDetailsView: View {
    let collectible: Collectible
    @EnvironmentObject var collectiblesViewModel: CollectiblesViewModel
    
    var body: some View {
        ZStack {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
            ScrollView {
                VStack (spacing: 16){
                    if let imageName = collectible.image {
                        Image(imageName)
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(8)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                            }
                    }
                    CollectibleDetailsCard(collectible: collectible)
                        .padding(.bottom, collectible.skin != nil  ? 86 : 0)
                }
                .padding(.horizontal, 16)
            }
            .toolbar {
                
            }
            if collectible.skin != nil {
                VStack {
                    Spacer()
                    if collectiblesViewModel.currentSkin?.name != collectible.skin?.name {
                        TerbitButton(title: "Wear Collectible") {
                            withAnimation {
                                if collectiblesViewModel.currentSkin?.name != collectible.skin?.name {
                                    collectiblesViewModel.changeSkin(collectible: collectible)
                                }
                            }
                        }
                    } else {
                        TerbitButton(title: "Unequip Collectible", buttonStyle: .destructive) {
                            withAnimation {
                                collectiblesViewModel.changeSkin(collectible: nil)
                            }
                        }
                            
                    }
                    
                }
                .padding(.horizontal, 16)
            }
        }
       
    }
}
