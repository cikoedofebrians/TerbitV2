//
//  LevelsCollectibleUnlocked.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 15/05/25.
//

import SwiftUI

struct LevelsCollectibleUnlocked: View {
    @Binding var isViewShown: Bool
    let collectible: Collectible
    @EnvironmentObject var collectiblesViewModel: CollectiblesViewModel
    @EnvironmentObject var levelsViewModel: LevelsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("Congratulations")
                .font(.poppins(.bold, size: 28))
                .foregroundStyle(.white)
                .transition(.scale.combined(with: .opacity))
            Spacer()
            Image(collectible.image ?? "")
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.width * 0.5)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(4)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                }
                .overlay(alignment: .topLeading) {
                    NewBadge()
                }
            Text(collectible.name ?? "-")
                .font(.poppins(.semiBold, size: 20))
                .foregroundStyle(.white)
                .padding(.top, 24)
            
            Text("\"\(collectible.desc ?? "-")\"")
                .multilineTextAlignment(.center)
                .font(.poppins(.medium, size: 16))
                .foregroundStyle(.white)
                .padding(.top, 4)
            
            Spacer()
            Text("Tap to Continue")
                .font(.poppins(.semiBold, size: 16))
                .foregroundStyle(.white)
                .transition(.opacity)
            Spacer()
            
        }
        .padding(.horizontal, 16)
        .ignoresSafeArea()
        .frame(maxWidth: .infinity)
        .background(
            .ultraThinMaterial
        )
        .onTapGesture {
            withAnimation {
                isViewShown = false
            }
        }
        .preferredColorScheme(.dark)
        .onAppear(perform: {
            collectiblesViewModel.unlockCollectible(collectible)
        })
        .confetti(isPresented: true, duration: 2)
    }
}
