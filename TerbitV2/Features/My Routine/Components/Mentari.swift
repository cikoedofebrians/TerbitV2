//
//  Mentari.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 16/05/25.
//

import SwiftUI

struct Mentari: View {
    @EnvironmentObject var myRoutineViewModel: MyRoutineViewModel
    @EnvironmentObject var collectiblesViewModel: CollectiblesViewModel
    
    var body: some View {
        
        if let skin = collectiblesViewModel.currentSkin {
            Image(myRoutineViewModel.mentariOffset != .zero ? skin.dizzy ?? "" : myRoutineViewModel.haveClearedRoutine ?  skin.afterRoutine ?? "" : skin.beforeRoutine ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                .clipped()
                .offset(myRoutineViewModel.mentariOffset)
                .overlay {
                    if  myRoutineViewModel.message != nil {
                        Text(myRoutineViewModel.message ?? "")
                            .font(.poppins(.medium, size: 16))
                            .padding(16)
                            .background {
                                UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 16, bottomLeading: 16, bottomTrailing: 16))
                                    .fill(.white)
                            }
                            .offset(x: UIScreen.main.bounds.width * -0.2, y: UIScreen.main.bounds.width * 0.26)
                            .transition(.blurReplace())
                    }
                }
                .scaleEffect(myRoutineViewModel.mentariAnimation ? 1.1 : 1)
                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: myRoutineViewModel.mentariAnimation)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.easeInOut(duration: 0.1)) {
                                myRoutineViewModel.mentariOffset = value.translation
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.easeInOut) {
                                myRoutineViewModel.mentariOffset = .zero
                            }
                        }
                )
                .onTapGesture {
                    myRoutineViewModel.showMessage()
                }
               
        }
    }
}
