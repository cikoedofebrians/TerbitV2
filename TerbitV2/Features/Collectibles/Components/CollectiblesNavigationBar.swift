//
//  CollectibleNavigationBar.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//


import SwiftUI

struct CollectiblesNavigationBar: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Text("Collectibles")
                .font(.poppins(.bold, size: 24))
            Spacer()
            DismissButton()
        }
        .padding(.bottom, 16)
    }
}
