//
//  DismissButton.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//


import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.gray)
                .padding(8)
                .background {
                    Circle()
                        .fill(Color(uiColor: .quaternaryLabel))
                }
        }

    }
}


#Preview {
    DismissButton()
}
