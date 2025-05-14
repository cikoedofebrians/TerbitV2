//
//  MyRoutineSheet.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 09/05/25.
//


import SwiftUI

struct MyRoutineSheet: View {
    @State var sheetSize: CGFloat = 0
    @State var currentDetent: PresentationDetent = .fraction(0.13)
    
    var body: some View {
        ScrollView ( showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {

                HStack {
                    VStack {
                        Text("Today Routine")
                            .font(.poppins(.semiBold, size: 24))
                        Text("07:30 | Every weekday")
                            .font(.poppins(.regular, size: 16))
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .font(.poppins(.regular, size: 48))
                        .foregroundStyle(.green)
                }
                .padding(.vertical, 36)
                HStack {
                    Text("Routine")
                        .font(.poppins(.semiBold, size: 20))
                    Spacer()
                    Button {
                 
                    } label: {
                        Text("Manage")
                            .font(.poppins(.semiBold, size: 16))
                    }

                }
                VStack (spacing: 12){
                    HStack {
                        Text("Total Duration")
                        Spacer()
                        Text("10 mins")
                            .fontWeight(.semibold)
                    }
                    .font(.poppins(.medium, size: 16))
                    Divider()
                    RoutineItem(systemName: "figure.walk", title: "Walking", duration: 2)
                    Divider()
                    RoutineItem(systemName: "figure.walk", title: "Walking", duration: 2)
                    Divider()
                    RoutineItem(systemName: "figure.walk", title: "Walking", duration: 2)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                )
            }
            .padding(.horizontal, 16)
            .background {
                GeometryReader { proxy in
                    Color.clear.task {
                            sheetSize = proxy.size.height
                    }
                }
            }
  
        }
        .presentationDetents([.height(sheetSize), .fraction(0.13)])
        
        .scrollDisabled(true)
        .presentationDragIndicator(.visible)
        .presentationBackground(Color(uiColor: .secondarySystemBackground))
        .presentationBackgroundInteraction(.enabled)
        .interactiveDismissDisabled()
    }
}
