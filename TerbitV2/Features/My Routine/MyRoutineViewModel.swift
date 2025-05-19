//
//  MyRoutineViewModel.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 16/05/25.
//


import SwiftUI

class MyRoutineViewModel: ObservableObject {
    @Published var sheetHeight: CGFloat = 0
    @Published var showCollectiblesSheet: Bool = false
    @Published var showTodayRoutineSheet: Bool = true
    @Published var mentariOffset: CGSize = .zero
    @Published var mentariAnimation: Bool = false
    @Published var haveClearedRoutine: Bool = false
    @Published var limitRoutine = true
    @Published var message: String? = nil
    
    func completeRoutine() {
        haveClearedRoutine = true
    }
    
    func showMessage() {
        if haveClearedRoutine {
            withAnimation {
                message = "Mentari feels so\nenergetic right now!✨"
            }
        } else {
            withAnimation {
                message = "Too lazy to work...💤"
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation {
                self.message = nil
            }
        }
    }
}
