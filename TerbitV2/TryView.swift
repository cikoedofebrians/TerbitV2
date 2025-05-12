//
//  TryView.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 10/05/25.
//


import SwiftUI

struct FixedSizeExampleView: View {
    var body: some View {
        VStack(spacing: 40) {
            Button {
                
            } label: {
                Text("Button 1")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            Button {
                
            } label: {
                Text("Button Medium Panjang")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            Button {
                
            } label: {
                Text("Button Sangat Panjang 3 Panjang Panjang Panjang Panjang")
                    .fixedSize(
                        horizontal: false, vertical: false
                    )
            }
            .buttonStyle(.borderedProminent)

        }
//        .fixedSize(
//            horizontal: false, vertical: false
//        )
    }
}

import SwiftUI

struct MultilineFixedSizeExampleView: View {
    var body: some View {
        VStack(spacing: 40) {
            
            // Without .fixedSize()
            Text("This is a long text that should wrap to multiple lines but might get truncated if constrained.")
                .lineLimit(1)
                .frame(width: 200)
                .background(Color.yellow)
                .border(Color.red)
            
            // With .fixedSize()
            Text("This is a long text that should wrap to multiple lines but might get truncated if constrained.")
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 200)
                .background(Color.green)
                .border(Color.red)
        }
        .padding()
    }
}



#Preview {
    FixedSizeExampleView()
    MultilineFixedSizeExampleView()
}
