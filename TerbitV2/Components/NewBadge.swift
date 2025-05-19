//
//  NewBadge.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 16/05/25.
//


import SwiftUI

struct NewBadge: View {
    var body: some View {
        Text("NEW!")
            .foregroundStyle(.white)
            .font(.poppins(.bold, size: 16))
            .padding(24)
            .background(Circle().fill(Color.red))
            .shadow(color: Color.red, radius: 4)
            .rotationEffect(.degrees(-30))
            .offset(x: -32, y: -32)
    }
}
