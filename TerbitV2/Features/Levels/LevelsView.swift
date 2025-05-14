//
//  LevelsView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//

import SwiftUI

struct LevelsView: View {
    @Environment(Router.self) var router
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
                        ForEach(1..<6) { index in
                            VStack(spacing: 0) {
                                Text("Level")
                                    .font(.poppins(.semiBold, size: 24))
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 24)
                                Image(.levelBackgroundLarge)
                                    .overlay {
                                        Text("\(index)")
                                            .font(.poppins(.bold, size: 48))
                                            .foregroundStyle(.white)
                                    }
                                Text("Reward")
                                    .font(.poppins(.semiBold, size: 16))
                                    .foregroundStyle(.white)
                                    .padding(.top, 48)
                                Image(.pokerMentari)
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
                                
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.75)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.black.opacity(0.1))
                                    .strokeBorder(Color.white, lineWidth: 1)
                            }
                            .scrollTransition { content, phase in
                                content
                                    .scaleEffect(y: phase.isIdentity ? 1 : 0.9)
                                    .blur(radius: phase.isIdentity ? 0 : 1)
                            }
                            
                        }
                    }
                    .scrollTargetLayout()
                }
                VStack(spacing: 12) {
                    HStack {
                        Text("Progress")
                            .font(.poppins(.semiBold, size: 16))
                        Spacer()
                        Image(systemName: "medal.fill")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.yellow)
                    }
                    TerbitProgressBar(progress: 0.9, height: 6)
                    HStack {
                        Text("120")
                            .foregroundStyle(.darkSky) + Text(" / 150")
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                            .fontWeight(.medium)
                        Spacer()
                        Text("91%")
                            .foregroundStyle(.darkSky)
                        
                    }
                    .font(.poppins(.semiBold, size: 16))
                }
                .padding(16)
                .frame(width: UIScreen.main.bounds.width * 0.75)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                }
            }
            .padding(.top, 32)
            .contentMargins(.horizontal, UIScreen.main.bounds.width * 0.25 / 2, for: .scrollContent)
            .scrollTargetBehavior(.)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    LevelsView()
        .environment(Router())
}
