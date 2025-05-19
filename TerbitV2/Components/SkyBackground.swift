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
                
                RadialGradient(
                    gradient: Gradient(colors: cloudColors),
                    center: animate ? .bottomTrailing : .topLeading,
                    startRadius: size.width * 0.2,
                    endRadius: size.width * 0.9
                )
                .opacity(0.4)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true))  {
                animate = true
            }
        }
    }
}

#Preview {
    SkyBackground()
}
