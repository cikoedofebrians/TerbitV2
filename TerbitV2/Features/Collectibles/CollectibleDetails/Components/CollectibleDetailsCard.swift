//
//  Untitled.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//

import SwiftUI

struct CollectibleDetailsCard: View {
    let collectible: Collectible
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                VStack (alignment: .leading, spacing: 4) {
                    Text(collectible.name ?? "")
                        .font(.poppins(.semiBold, size: 24))
                    Text("\(collectible.desc ?? "")")
                        .font(.poppins(.regular, size: 16))
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 20, weight: .semibold))
                        .offset(y: -2)
                        .foregroundStyle(.blue)
                        .padding()
                        .background {
                            Circle()
                                .fill(Color.blue.opacity(0.2))
                        }
                }
                
            }
            .padding(.bottom, 8)
            Divider()
                .padding(.vertical, 16)
            HStack {
                Text("Obtained at")
                    .font(.poppins(.regular, size: 16))
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Text("\(collectible.obtainedAt?.formatAsString() ?? "-")")
                    .font(.poppins(.semiBold, size: 16))
            }
            HStack {
                Text("Unlocked through")
                    .font(.poppins(.regular, size: 16))
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Text(collectible.level == nil ? "Gacha" : "Level Reward")
                    .font(.poppins(.semiBold, size: 16))
            }
            .padding(.top, 4)
    
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        )
    }
}
