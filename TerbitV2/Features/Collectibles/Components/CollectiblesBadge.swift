//
//  CollectibleBadge.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//

import SwiftUI

struct CollectiblesBadge: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 0) {
                Text("8")
                    .font(.poppins(.semiBold, size: 48))
                    .foregroundStyle(.darkSky)
                +
                Text(" / 25")
                    .font(.poppins(.semiBold, size: 20))
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Text("Collectibles discovered")
                    .font(.poppins(.medium, size: 16))
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            Spacer()
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundStyle(.darkSky)
                .rotationEffect(.degrees(-90))
                .frame(width: 70, height: 70)
          
                .background {
                    Circle()
                        .stroke(lineWidth: 10)
                        .foregroundStyle(Color(uiColor: .quaternaryLabel))
                }
                .overlay {
                    Text("75%")
                        .font(.poppins(.semiBold, size: 20))
                        .foregroundStyle(.darkSky)
                }
                .padding(.trailing, 16)
                
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
        )
    }
}
