import SwiftUI

struct WhiteBackgroundsDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Group {
                    backgroundCard(title: "Color.white", background: Color.white)
                    
                    backgroundCard(title: ".background(.white)", background: Color.white)
                    
                    backgroundCard(title: ".background(Material.regular)", background: {
                        Rectangle().fill(Material.regular)
                    })
                    
                    backgroundCard(title: ".background(Material.thin)", background: {
                        Rectangle().fill(Material.thin)
                    })
                    
                    backgroundCard(title: ".background(Material.ultraThin)", background: {
                        Rectangle().fill(Material.ultraThin)
                    })
                }
                
                Group {
                    backgroundCard(title: "Color(uiColor: .systemBackground)", 
                                  background: Color(uiColor: .systemBackground))
                    
                    backgroundCard(title: "Color(uiColor: .secondarySystemBackground)", 
                                  background: Color(uiColor: .secondarySystemBackground))
                    
                    backgroundCard(title: "Color(uiColor: .tertiarySystemBackground)", 
                                  background: Color(uiColor: .tertiarySystemBackground))
                    
                    backgroundCard(title: "Color(uiColor: .systemGroupedBackground)", 
                                  background: Color(uiColor: .systemGroupedBackground))
                    
                    backgroundCard(title: "Color(uiColor: .secondarySystemGroupedBackground)", 
                                  background: Color(uiColor: .secondarySystemGroupedBackground))
                }
                
                Group {
                    backgroundCard(title: ".background(.thinMaterial)", background: {
                        ZStack { // Showing material effect
                            Color.blue // Color underneath to show effect
                            Rectangle().fill(.thinMaterial)
                        }
                    })
                    
                    backgroundCard(title: ".background(.ultraThinMaterial)", background: {
                        ZStack {
                            Color.blue // Color underneath to show effect
                            Rectangle().fill(.ultraThinMaterial)
                        }
                    })
                    
                    backgroundCard(title: ".background(.regularMaterial)", background: {
                        ZStack {
                            Color.blue // Color underneath to show effect
                            Rectangle().fill(.regularMaterial)
                        }
                    })
                }
            }
            .padding()
        }
        .background(Color(uiColor: .systemGray6))
        .navigationTitle("White Backgrounds")
    }
    
    @ViewBuilder
    func backgroundCard<Background: View>(title: String, background: () -> Background) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            background()
                .frame(height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
                )
        }
    }
    
    func backgroundCard(title: String, background: Color) -> some View {
        backgroundCard(title: title) {
            background
        }
    }
}

#Preview {
    NavigationStack {
        WhiteBackgroundsDemo()
    }
} 