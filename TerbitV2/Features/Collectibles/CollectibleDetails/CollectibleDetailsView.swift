//
//  CollectibleDetailsView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//

import SwiftUI

struct CollectibleDetailsView: View {
    let item: Collectible
    
    var body: some View {
        ZStack {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
            ScrollView {
                VStack (spacing: 16){
                    Image(item.image)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(8)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                        }
                 
                    CollectibleDetailsCard(item: item)
                }
                .padding(.horizontal, 16)
            }
            .toolbar {
                
            }
            if item.rarity == .legendary{
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


#Preview {
//    SkyBackground()
//        .sheet(isPresented: .constant(true)) {
            NavigationStack {
                CollectibleDetailsView(item: CollectibleData.dummyCollectibles[0])
                .presentationDragIndicator(.visible)
            }
            .presentationBackground(Color(uiColor: .secondarySystemBackground))
//        }
}
