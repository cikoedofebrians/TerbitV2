//
//  GachaViewModel.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//

import Observation
import SwiftUI


enum GachaState {
    case chest(onRolling: Bool)
    case collectibleObtained(collectible: Collectible, isNew: Bool)
}

@Observable
class GachaViewModel {
    let collectiblesViewModel: CollectiblesViewModel
    
    init(collectiblesViewModel: CollectiblesViewModel) {
        self.collectiblesViewModel = collectiblesViewModel
    }
    
    var gachaState: GachaState = .chest(onRolling: false)
    var showConfetti: Bool = false
    
    var wiggleAnimation = false
    var scaleAnimation = false
    var rotationDegrees = 0.0
    var opacityAnimation = 1.0
    var isAnimating = false
    
    
    func playChestAnimationSequence() {
        isAnimating = true
        
        // Step 1: Start wiggling
        withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(15, autoreverses: true)) {
            wiggleAnimation.toggle()
        }
        
        // Step 2: After wiggling, show open chest and start scaling
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
                        self.gachaState = .collectibleObtained(collectible: self.collectiblesViewModel.collectibles.randomElement()!, isNew: true)
                        self.showConfetti = true
                    }
                }
            }
        }
    }
}
