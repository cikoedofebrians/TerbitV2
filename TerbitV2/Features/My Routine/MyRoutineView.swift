//
//  MyRoutineView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 09/05/25.
//


import SwiftUI

struct MyRoutineView: View {
    // environment objects
    @State var collectiblesViewModel: CollectiblesViewModel
    @State var router: Router
    
    @State var sheetHeight: CGFloat = 0
    @State var showCollectiblesSheet: Bool = false
    @State var showTodayRoutineSheet: Bool = true
    @State var mentariOffset: CGSize = .zero
    @State var mentariAnimation: Bool = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                SkyBackground()
                VStack(alignment: .center) {
                    MyRoutineNavbar(showCollectiblesSheet: $showCollectiblesSheet)
                    Spacer()
//                    NavigationLink {
//                        CollectiblesView()
//                    } label: {
//                        Text("TEst")
//                    }
                    Image(mentariOffset == .zero ? .mentariAfterRoutine : .mentariDizzy)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                        .clipped()
                        .offset(mentariOffset)
                        .scaleEffect(mentariAnimation ? 1.1 : 1)
                        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: mentariAnimation)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    withAnimation(.easeInOut(duration: 0.1)) {
                                        mentariOffset = value.translation
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.easeInOut) {
                                        mentariOffset = .zero
                                    }
                                }
                        )
                    
                    Spacer()
                    TerbitButton(title: "Begin Routine") {
                        router.push(.routineCompleteView)
                    }
                    .padding(.vertical, 16)
                    .onAppear {
                        mentariAnimation = true
                    }
                    Color.clear.frame(height: UIScreen.main.bounds.height * 0.13)
                    
                }
                .padding(.horizontal, 16)
            }

            .sheet(isPresented: $router.isOnRoot, content: {
                MyRoutineSheet()
                    .sheet(isPresented: $showCollectiblesSheet) {
                        CollectiblesView()
                            .environment(collectiblesViewModel)
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
                }
                
            }
        }
        .environment(collectiblesViewModel)
        .environment(router)
     
    }
}
