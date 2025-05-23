//
//  GachaView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//


import SwiftUI

struct GachaView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var collectiblesViewModel: CollectiblesViewModel
    @StateObject var gachaViewModel: GachaViewModel
    @EnvironmentObject var levelViewModel: LevelsViewModel
    
    
    var body: some View {
        ZStack {
            SkyBackground()
            switch gachaViewModel.gachaState {
            case .chest(let onRolling):
                chestView(onRolling: onRolling)
            case .collectibleObtained(let collectible, let isDuplicate):
                collectibleView(collectible: collectible, isDuplicate: isDuplicate)
            }
        }
        .onTapGesture {
            if case .collectibleObtained(_, _) = gachaViewModel.gachaState {
                router.popAll()
            }
        }
        .navigationBarBackButtonHidden()
        .confetti(isPresented: gachaViewModel.showConfetti, duration: 2)
    }
}

extension GachaView {
    @ViewBuilder
    private func chestView(onRolling: Bool) -> some View {
        Image(onRolling ? .chestOpened : .chestClosed)
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width * 0.5)
            .scaleEffect(gachaViewModel.scaleAnimation ? 1.5 : 1.0)
            .rotationEffect(.degrees(gachaViewModel.rotationDegrees))
            .offset(x: gachaViewModel.wiggleAnimation ? -5 : 5, y: 0)
            .opacity(gachaViewModel.opacityAnimation)
            .onTapGesture {
                if !gachaViewModel.isAnimating {
                    gachaViewModel.playChestAnimationSequence()
                }
            }
        VStack {
            Spacer()
            Text("Tap Chest to Roll")
                .font(.poppins(.semiBold, size: 20))
                .foregroundStyle(.white)
                .opacity(gachaViewModel.isAnimating ? 0 : 1) // Hide text during animation
                .padding(.bottom, UIScreen.main.bounds.height * 0.1)
        }
    }
    
    @ViewBuilder
    private func collectibleView(collectible: Collectible, isDuplicate: Bool) -> some View {
        collectibleCard(collectible: collectible, isDuplicate: isDuplicate)
            .padding(.top, 40)
        
        VStack {
            Text("Congratulations")
                .font(.poppins(.bold, size: 28))
                .foregroundStyle(.white)
                .transition(.scale.combined(with: .opacity))
            Spacer()
            Text("Tap to Continue")
                .font(.poppins(.semiBold, size: 16))
                .foregroundStyle(.white)
                .transition(.opacity)
        }
        .padding(.vertical, UIScreen.main.bounds.height * 0.05)
        
    }
    
    private func collectibleCard(collectible: Collectible, isDuplicate: Bool) -> some View {
        VStack(spacing: 0) {
            Image(collectible.image ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.5)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(4)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                }
                .overlay(alignment: .topLeading) {
                    if !isDuplicate {
                        newBadge()
                    }
                }
                .transition(.scale.combined(with: .opacity))
            
            if gachaViewModel.showDuplicate {
                VStack {
                    Text("Converted into:")
                        .font(.poppins(.medium, size: 12))
                        
                    HStack {
                        Image(.xpToken)
                            .resizable()
                            .frame(width: 32, height: 32)
                            .scaledToFit()
                            .padding(.trailing, 4)
                        Text("+\(collectible.xpValue)")
                            .font(.poppins(.semiBold, size: 16))
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.5)
                .padding(.vertical, 12)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black.opacity(0.1))
                }
                .padding(.top, 16)
                .foregroundStyle(.white)
            }
            
            
            Text(collectible.name ?? "-")
                .font(.poppins(.semiBold, size: 20))
                .foregroundStyle(.white)
                .padding(.top, 24)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            
            Text("\"\(collectible.desc ?? "-")\"")
                .multilineTextAlignment(.center)
                .font(.poppins(.medium, size: 16))
                .foregroundStyle(.white)
                .padding(.top, 4)
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        .onAppear {
            if collectible.obtained {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        gachaViewModel.showDuplicate = true
                    }
                }
                levelViewModel.addXPToLevel(xp: collectible.xpValue)
            }else {
                collectiblesViewModel.unlockCollectible(collectible)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func newBadge() -> some View {
        Text("NEW!")
            .foregroundStyle(.white)
            .font(.poppins(.bold, size: 16))
            .padding(24)
            .background(Circle().fill(Color.red))
            .shadow(color: Color.red, radius: 4)
            .rotationEffect(.degrees(-30))
            .offset(x: -32, y: -32)
    }
}
