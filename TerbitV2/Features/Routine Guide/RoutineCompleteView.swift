//
//  RoutineCompleteView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//

import SwiftUI

struct RoutineCompleteView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var levelViewModel: LevelsViewModel
    @EnvironmentObject var myRoutineViewModel: MyRoutineViewModel
    @EnvironmentObject var collectiblesViewModel: CollectiblesViewModel
    @State var showMessage = false
    @State var showAlert = false
    
    var body: some View {
        ZStack {
            SkyBackground()
            VStack (spacing: 0){
                Text("Congratulations")
                    .font(.poppins(.bold, size: 24))
                    .foregroundStyle(.white)
                    .padding(.bottom, 42)
                if let skin = collectiblesViewModel.currentSkin {
                    Image(skin.congratulations ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .onTapGesture {
                            withAnimation {
                                showMessage.toggle()
                            }
                        }
                }
                
                HStack {
                    VStack {
                        Image(.xpToken)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .scaledToFit()
                        Text("+50")
                            .font(.poppins(.semiBold, size: 20))
                            .foregroundStyle(.white)
                            .padding(.top, 4)
                        Text("XP")
                            .font(.poppins(.regular, size: 14))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white.opacity(0.5))
                        .frame(width: 3, height: 120)
                    VStack {
                        Image(.gachaToken)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .scaledToFit()
                        Text("+1")
                            .font(.poppins(.semiBold, size: 20))
                            .foregroundStyle(.white)
                            .padding(.top, 4)
                        Text("Gacha Token")
                            .font(.poppins(.regular, size: 14))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(.top, 42)
                TerbitButton(title: "Roll Now") {
                    router.push(.gachaView)
                }
                .padding(.top, 42)
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Skip")
                        .foregroundStyle(.white)
                        .font(.poppins(.medium, size: 16))
                        .underline()
                    
                }
                .padding(.top, 32)
                
            }
            .padding(.horizontal, 16)
        }
        .onAppear(perform: {
            levelViewModel.addXPToLevel(xp: 80)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                myRoutineViewModel.completeRoutine()
            }
        })
        .alert("Don't Miss Your Roll!", isPresented: $showAlert, actions: {
            Button(role: .cancel) {
                
            } label: {
                Text("Back")
            }
            Button(role: .destructive) {
                router.popAll()
            } label: {
                Text("Skip")
            }
            
        }, message: {
            Text("Leaving now means giving up your Gacha Token. Are you sure?")
        })
        .navigationBarBackButtonHidden()
    }
}
