//
//  LevelsView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//

import SwiftUI

struct LevelsView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var levelViewModel: LevelsViewModel
    @State var scrollId: UUID? = nil
    @State var isViewShown: Bool = false
    @State var isOnScrolling: Bool = false
    
    var body: some View {
        ZStack {
            SkyBackground()
            VStack {
                HStack {
                    Button {
                        router.pop()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                            .foregroundStyle(.white)
                            .padding(16)
                            .background {
                                Circle()
                                    .fill(.black.opacity(0.1))
                            }
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(16)
            VStack (spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(levelViewModel.levels) { level in
                            LevelsCard(level: level, unlocked: levelViewModel.checkIfLevelUnlocked(id: level.id ?? UUID()), isViewShown: $isViewShown)
                                .id(level.id)
                        }
                    }
                    .scrollTargetLayout()
                }
                if let selectedLevel = levelViewModel.levels.first(where: { $0.id == scrollId }) {
//                    if  !isOnScrolling {
                    LevelsProgess(selectedLevel: selectedLevel)
                        .transition(.opacity)
//                    }

                }
            }
            .padding(.top, 32)
            .contentMargins(.horizontal, UIScreen.main.bounds.width * 0.25 / 2, for: .scrollContent)
            .scrollPosition(id: $scrollId)
            .scrollTargetBehavior(.viewAligned)
            .onAppear(perform: {
                if let currentLevel = levelViewModel.currentLevel  {
                    withAnimation(.bouncy(extraBounce: 0.1)) {
                        scrollId = currentLevel.id
                    }
                }
            })
            .navigationBarBackButtonHidden()
        }
        .overlay {
            if let collectible = levelViewModel.levels.first(where: { $0.id == scrollId })?.collectible {
                if isViewShown {
                    LevelsCollectibleUnlocked(isViewShown: $isViewShown, collectible: collectible)
                }
            }
        }
    }
}
