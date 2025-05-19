//
//  ProfileView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 16/05/25.
//


import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var myRoutineViewModel: MyRoutineViewModel
    @EnvironmentObject var collectiblesViewModel: CollectiblesViewModel
    @EnvironmentObject var levelsViewModel: LevelsViewModel
    
    var body: some View {
        Form {
            Toggle(isOn: $myRoutineViewModel.limitRoutine) {
                Text("Limit Routine")
            }
  
            Section("Collectibles") {
                Button {
                    collectiblesViewModel.unlockAllCollectibles()
                } label: {
                    Text("Unlock All Collectibles")
                }

                Button(role: .destructive) {
                    collectiblesViewModel.lockAllCollectibles()
                } label: {
                    Text("Lock All Collectibles")
                }
            }
            
            Section("Levels") {
                Button {
                    levelsViewModel.unlockAllLevels()
                } label: {
                    Text("Unlock All Levels")
                }

                Button(role: .destructive) {
                    levelsViewModel.lockAllLevels()
                } label: {
                    Text("Lock All Levels")
                }
            }
        
            
        }
        .navigationTitle("Settings")
    }
}


#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(MyRoutineViewModel())
    }
}
