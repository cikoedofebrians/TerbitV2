//
//  CollectibleDetailsView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//

import SwiftUI

struct CollectibleDetailsView: View {
    let collectible: Collectible
    
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
                }
                .padding(.horizontal, 16)
            }
            .toolbar {
                
            }
            if collectible.rarity == .legendary {
                VStack {
                    Spacer()
                    TerbitButton(title: "Wear Collectible") {
                        
                    }
                }
                .padding(.horizontal, 16)
            }
        }
       
    }
}
