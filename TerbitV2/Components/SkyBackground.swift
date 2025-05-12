import SwiftUI

struct SkyBackground: View {
    @State private var animate = false
    
    let cloudColors = [
        Color.white.opacity(0.6),
        Color.white.opacity(0.3),
        Color.clear
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.darkSky, .lightSky]),
                startPoint: .top,
                endPoint: .bottom
            )
            GeometryReader { geometry in
                let size = geometry.size
                
                RadialGradient(
                    gradient: Gradient(colors: cloudColors),
                    center: animate ? .topLeading : .bottomTrailing,
                    startRadius: size.width * 0.1,
                    endRadius: size.width * 0.8
                )
                .opacity(0.6)
                .animation(
                    .easeInOut(duration: 8.0)
                    .repeatForever(autoreverses: true),
                    value: animate
                )
                
                RadialGradient(
                    gradient: Gradient(colors: cloudColors),
                    center: animate ? .bottomTrailing : .topLeading,
                    startRadius: size.width * 0.2,
                    endRadius: size.width * 0.9
                )
                .opacity(0.4)
                .animation(
                    .easeInOut(duration: 10.0)
                    .repeatForever(autoreverses: true),
                    value: animate
                )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            animate = true
        }
    }
}
//
#Preview {
    SkyBackground()
}
