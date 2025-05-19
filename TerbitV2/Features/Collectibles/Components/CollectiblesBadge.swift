//
//  CollectibleBadge.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//

import SwiftUI

struct CollectiblesBadge: View {
    @EnvironmentObject var collectiblesViewModel: CollectiblesViewModel
    
    var percentage: Double{
        Double((collectiblesViewModel.collectibles.filter { $0.obtained }.count))/Double(collectiblesViewModel.collectibles.count)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(collectiblesViewModel.collectibles.filter { $0.obtained }.count)")
                    .font(.poppins(.semiBold, size: 48))
                    .foregroundStyle(.darkSky)
                +
                Text(" / \(collectiblesViewModel.collectibles.count)")
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
                .trim(from: 0, to: percentage)
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
                    Text(percentage.toPercentageString())
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
