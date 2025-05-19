//
//  MyRoutineNavbar.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//


import SwiftUI

struct MyRoutineNavbar: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var levelViewModel: LevelsViewModel
    
    @Binding var showCollectiblesSheet: Bool
    var body: some View {
        HStack (spacing: 16){
            Image(systemName: "person.fill")
                .font(.system(size: 24))
                .foregroundStyle(.white)
                .padding()
                .frame(width: 48, height: 48)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 1))
                )
                .onTapGesture {
                    router.push(.profileView)
                }
            
            HStack {
                ZStack {
                    Image(.levelBackgroundSmall)
                    Text("\(levelViewModel.currentLevel?.number ?? 0)")
                        .font(.poppins(.bold, size: 20))
                        .foregroundStyle(.white)
                }
                .overlay {
                    if levelViewModel.checkIfCollectiblesUnopened() {
                        Image(systemName: "exclamationmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(8)
                            .background {
                                Circle()
                                    .fill(.red)
                            }
                            .offset(x: 16, y: -16)
                    }
                }
                
                VStack {
                    TerbitProgressBar(progress: Double(levelViewModel.currentLevel?.currentXP ?? 0) / Double(levelViewModel.currentLevel?.neededXP ?? 0), height: 5)
                    HStack {
                        Text("XP")
                        Spacer()
                        Text("\(levelViewModel.currentLevel?.currentXP ?? 0)/\(levelViewModel.currentLevel?.neededXP ?? 0)")
                            .fontWeight(.semibold)
                    }
                    .font(.poppins(.regular, size: 12))
                }
            }
            .padding(.vertical, 8)
            .padding(.leading, 12)
            .padding(.trailing, 16)
            .background(
                Capsule()
                    .fill(.white)
            )
            .onTapGesture {
                router.push(.levelView)
            }
            HStack(spacing: 10) {
                Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                Button {
                    showCollectiblesSheet.toggle()
                } label: {
                    Image(systemName: "star.square.fill")
                }   
            }
            .font(.system(size: 24))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 1))
            )
            
        }
        .padding(.vertical, 16)
    }
}
