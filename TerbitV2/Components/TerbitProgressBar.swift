//
//  TerbitProgressBar.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//

import SwiftUI

struct TerbitProgressBar: View {
    let progress: Double
    let height: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Capsule()
                    .fill(Color(UIColor.secondarySystemBackground))
                    .frame(width: geometry.size.width)
                Capsule()
                    .fill(.darkSky)
                    .frame(width: geometry.size.width * progress)
            }
        }
        .frame(height: height)
    }
}
