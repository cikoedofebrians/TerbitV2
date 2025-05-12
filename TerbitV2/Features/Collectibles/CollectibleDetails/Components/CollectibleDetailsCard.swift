//
//  Untitled.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//

import SwiftUI

struct CollectibleDetailsCard: View {
    let item: Collectible
    
    var body: some View {
        VStack {
            HStack {
                
                VStack (alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.poppins(.semiBold, size: 24))
                    Text("\"Dattebayo\"")
                        .font(.poppins(.regular, size: 16))
                }
                Spacer()
                Button {
                    print("something")
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
            Divider()
                .padding(.vertical, 16)
            HStack {
                Text("Obtained at")
                    .font(.poppins(.regular, size: 16))
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Text("\(item.obtainedAt.formatAsString())")
                    .font(.poppins(.semiBold, size: 16))
            }
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        )
    }
}


#Preview {
    CollectibleDetailsCard(item: CollectibleData.dummyCollectibles[0])
}
