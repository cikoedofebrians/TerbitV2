//
//  TerbitButton.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 09/05/25.
//


import SwiftUI

struct TerbitButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .padding(.vertical, 16)
                .font(.poppins(.semiBold, size: 20))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.amber)
                        .background(
                            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(bottomLeading: 8, bottomTrailing: 8))
                                .fill(.amberShadow)
                                .offset(y: 5)
                        )
                )
        }
    }
}

#Preview {
    TerbitButton(title: "Begin Routine") {
        
    }
}
