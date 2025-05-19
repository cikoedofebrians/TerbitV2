//
//  GachaViewModel.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//

import SwiftUI

enum GachaState {
    case chest(onRolling: Bool)
    case collectibleObtained(collectible: Collectible, isDuplicate: Bool)
}


class GachaViewModel: ObservableObject {
    let collectiblesViewModel: CollectiblesViewModel
    
    init(collectiblesViewModel: CollectiblesViewModel) {
        self.collectiblesViewModel = collectiblesViewModel
    }
    
    @Published var gachaState: GachaState = .chest(onRolling: false)
    @Published var showConfetti: Bool = false
    
    @Published var wiggleAnimation = false
    @Published var scaleAnimation = false
    @Published var rotationDegrees = 0.0
    @Published var opacityAnimation = 1.0
    @Published var isAnimating = false
    @Published var showDuplicate: Bool = false
    
    func rollCollectible() -> Collectible {
        let rarityWeights: [CollectibleRarity: Int] = [
            .common: 60,
            .rare: 25,
            .epic: 10,
            .legendary: 5
        ]
        
        let totalWeight = rarityWeights.values.reduce(0, +)
        let randomValue = Int.random(in: 0...totalWeight)
        
        var cumulativeWeight = 0
        var selectedRarity: CollectibleRarity = .common
        
        for (rarity, weight) in rarityWeights {
            cumulativeWeight += weight
            if randomValue <= cumulativeWeight {
                selectedRarity = rarity
                break
            }
        }
        
        let availableCollectibles = collectiblesViewModel.getCollectibleByRarity(selectedRarity)
        let randomIndex = Int.random(in: 0..<availableCollectibles.count)
        let selectedCollectible = availableCollectibles[randomIndex]
        
        return selectedCollectible
    }
    
    
    func playChestAnimationSequence() {
        isAnimating = true
        
        // Step 1: Start wiggling
        withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(15, autoreverses: true)) {
            wiggleAnimation.toggle()
        }
        
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // Set to open chest
            withAnimation(.easeIn(duration: 0.2)) {
                self.gachaState = .chest(onRolling: true)
            }
            
            // Start scaling and rotating animation
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.5)) {
                self.scaleAnimation = true
                self.rotationDegrees = 10
            }
            
            // Step 3: Begin fade out animation for the chest
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 0.3)) {
                    self.opacityAnimation = 0
                }
                
                // Step 4: Show the result with confetti
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                        let selectedCollectible = self.rollCollectible()
                        self.gachaState = .collectibleObtained(collectible: selectedCollectible, isDuplicate: selectedCollectible.obtained)
                        self.showConfetti = true
                    }
                }
            }
        }
    }
}
