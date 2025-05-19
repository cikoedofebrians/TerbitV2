//
//  LevelsCard.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 15/05/25.
//

import SwiftUI

struct LevelsCard: View {
    let level: Level
    let unlocked: Bool
    
    @Binding var isViewShown: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Level")
                .font(.poppins(.semiBold, size: 24))
                .foregroundStyle(.white)
                .padding(.vertical, 24)
            Image(.levelBackgroundLarge)
                .overlay {
                    Text("\(level.number)")
                        .font(.poppins(.bold, size: 48))
                        .foregroundStyle(.white)
                }
            Text("Reward")
                .font(.poppins(.semiBold, size: 16))
                .foregroundStyle(.white)
                .padding(.top, 48)
            if let collectible = level.collectible {
                Image(collectible.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding(2)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.white)
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 32)
                    .overlay(alignment: .topTrailing) {
                        if !collectible.obtained && unlocked {
                            Image(systemName: "exclamationmark")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(10)
                                .background {
                                    Circle()
                                        .fill(.red)
                                }
                                .offset(x: 10, y: -6)
                        }
                    }
                    .onTapGesture {
                        if !collectible.obtained {
                            withAnimation {
                                isViewShown  = true
                            }
                        }
                    }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.75)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.1))
                .strokeBorder(Color.white, lineWidth: 1)
        }
        .overlay(content: {
            if !unlocked {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.black.opacity(0.4))
                    Image(systemName: "lock.fill")
                        .font(.system(size: 48, weight: .medium))
                        .foregroundStyle(.white)
                }
            }
        })
        .scrollTransition { content, phase in
            content
                .scaleEffect(y: phase.isIdentity ? 1 : 0.9)
                .blur(radius: phase.isIdentity ? 0 : 1)
        }
        
    }
    
}

