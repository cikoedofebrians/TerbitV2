//
//  RoutineItem.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 09/05/25.
//


import SwiftUI

struct RoutineItem: View {
    let systemName: String
    let title: String
    let duration: Int
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .foregroundStyle(.yellow)
                .font(.system(size: 32))
                .frame(width: 54, height: 54)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.yellow.opacity(0.2))
                )
            Text(title)
                .font(.poppins(.medium, size: 16))
            Spacer()
            Text("\(duration) mins")
                .font(.poppins(.semiBold, size: 16))
        }
    }
}

