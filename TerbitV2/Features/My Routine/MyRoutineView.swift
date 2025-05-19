//
//  MyRoutineView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 09/05/25.
//
import SwiftUI

struct MyRoutineView: View {
    // environment objects
    @StateObject var myRoutineViewModel: MyRoutineViewModel
    @StateObject var collectiblesViewModel: CollectiblesViewModel
    @StateObject var levelViewModel: LevelsViewModel
    @StateObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                SkyBackground()
                VStack(alignment: .center) {
                    MyRoutineNavbar(showCollectiblesSheet: $myRoutineViewModel.showCollectiblesSheet)
                    Spacer()
                    Mentari()
                    Spacer()
                    
                    if !myRoutineViewModel.limitRoutine || !myRoutineViewModel.haveClearedRoutine {
                        TerbitButton(title: "Begin Routine") {
                            router.push(.routineCompleteView)
                            
                        }
                        .padding(.vertical, 16)
                    }
                    Color.clear.frame(height: UIScreen.main.bounds.height * 0.13)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        myRoutineViewModel.mentariAnimation = true
                    }
                }
                .padding(.horizontal, 16)
            }

            .sheet(isPresented: $router.isOnRoot, content: {
                MyRoutineSheet()
                    .sheet(isPresented: $myRoutineViewModel.showCollectiblesSheet) {
                        CollectiblesView()
                            .environmentObject(collectiblesViewModel)
                            .presentationDragIndicator(.visible)
                            .presentationBackground(Color.black)
                    }
            })
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case .routineCompleteView:
                    RoutineCompleteView()
                case .gachaView:
                    GachaView(gachaViewModel: GachaViewModel(collectiblesViewModel: collectiblesViewModel))
                case .levelView:
                    LevelsView()
                case .collectibleDetails(let collectible):
                    CollectibleDetailsView(collectible: collectible)
                case .profileView:
                    ProfileView()
                }
                
            }
        }
        .environmentObject(myRoutineViewModel)
        .environmentObject(levelViewModel)
        .environmentObject(collectiblesViewModel)
        .environmentObject(router)
     
    }
}

