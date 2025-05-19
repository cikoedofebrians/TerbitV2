//
//  LevelsProgess.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 15/05/25.
//


import SwiftUI

struct LevelsProgess: View {
    let selectedLevel: Level
    
    var percentage: Double {
        Double(selectedLevel.currentXP) / Double(selectedLevel.neededXP)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Progress")
                    .font(.poppins(.semiBold, size: 16))
                    .animation(.easeInOut(duration: 0.5), value: selectedLevel.currentXP)

                Spacer()
                Image(systemName: "medal.fill")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(selectedLevel.currentXP >= selectedLevel.neededXP ?  .yellow : Color(uiColor: .tertiaryLabel))
                    .animation(.easeInOut, value: selectedLevel)
            }
            TerbitProgressBar(progress: percentage, height: 6)
                .animation(.easeInOut, value: selectedLevel)
            HStack {
                Group {
                    Text("\(selectedLevel.currentXP)")
                        .foregroundStyle(.darkSky) + Text(" / \(selectedLevel.neededXP)")
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                        .fontWeight(.medium)
                    
                    
                }
                .contentTransition(.numericText())
                .animation(.easeInOut, value: selectedLevel)
                    
                Spacer()
                Text("\(percentage.toPercentageString())")
                    .foregroundStyle(.darkSky)
                    .contentTransition(.numericText())
                    .animation(.easeInOut, value: selectedLevel)
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
}
