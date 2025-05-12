//
//  MyRoutineView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 09/05/25.
//


import SwiftUI

struct MyRoutineView: View {
    @State var sheetHeight: CGFloat = 0
    @State var showCollectiblesSheet: Bool = false
    
    var body: some View {
        ZStack {
            SkyBackground()
            
            VStack(alignment: .center) {
                MyRoutineNavbar(showCollectiblesSheet: $showCollectiblesSheet)
                Spacer()
                Image(.mentariAfterRoutine)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                    .clipped()
                Spacer()
                TerbitButton(title: "Begin Routine") {
                    showCollectiblesSheet.toggle()
                }
                .padding(.vertical, 16)
                Color.clear.frame(height: UIScreen.main.bounds.height * 0.13)
            }
            .padding(.horizontal, 16)
        }
        .sheet(isPresented: .constant(true), content: {
            MyRoutineSheet()
                .sheet(isPresented: $showCollectiblesSheet) {
                    CollectiblesView()
                        .presentationDragIndicator(.visible)
                        .presentationBackground(Color.black)
                }
        })
    }
}

#Preview {
    NavigationStack {
        MyRoutineView()
    }
}
