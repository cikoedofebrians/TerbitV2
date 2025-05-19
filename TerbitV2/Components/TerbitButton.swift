//
//  TerbitButton.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 09/05/25.
//


import SwiftUI

enum TerbitButtonStyle: Equatable {
    case normal
    case destructive
}

struct TerbitButton: View {

    let title: String
    var buttonStyle: TerbitButtonStyle = .normal
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
                        .fill(buttonStyle == .normal ? .amber : .destructiveRed)
                        .background(
                            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(bottomLeading: 8, bottomTrailing: 8))
                                .fill(buttonStyle == .normal ? .amberShadow : .destructiveRedShadow)
                                .offset(y: 5)
                        )
                )
        }
    }
}

#Preview {
    TerbitButton(title: "Cancel", buttonStyle: .destructive) {
        print("Button pressed")
    }
}
