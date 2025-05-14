import SwiftUI
import SpriteKit

// Custom SpriteKit scene for confetti animation
class ConfettiScene: SKScene {
    
    // Confetti colors
    private let colors: [UIColor] = [
        .systemRed, .systemBlue, .systemGreen, .systemYellow,
        .systemPurple, .systemOrange, .systemPink, .systemTeal
    ]
    
    // Confetti shapes
    private enum ConfettiShape {
        case circle
        case triangle
        case square
        case rectangle
    }
    
    // Configuration properties
    var intensity: Double = 0.5 // Controls amount of confetti (0.0 - 1.0)
    var lifetime: TimeInterval = 6.0 // How long confetti stays on screen
    var isEmitting = true // Whether to emit confetti
    var burstDuration: TimeInterval = 0 // Duration to emit confetti (0 means indefinitely)
    
    override func didMove(to view: SKView) {
        // Configure physics
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        backgroundColor = .clear
        
        // Start emitting particles if enabled
        if isEmitting {
            startEmitting()
        }
    }
    
    func startEmitting() {
        let emitAction = SKAction.run { [weak self] in
            self?.emitConfetti()
        }
        
        // Create sequence that emits confetti at intervals
        let waitAction = SKAction.wait(forDuration: 0.05)
        let emitSequence = SKAction.sequence([emitAction, waitAction])
        
        // If burstDuration is specified, emit for that duration then stop
        if burstDuration > 0 {
            let repeatAction = SKAction.repeat(emitSequence, count: Int(burstDuration / 0.05))
            run(repeatAction, withKey: "emitConfetti")
            
            // Schedule to stop after duration
            run(SKAction.wait(forDuration: burstDuration)) { [weak self] in
                self?.isEmitting = false
            }
        } else {
            // Run indefinitely
            run(SKAction.repeatForever(emitSequence), withKey: "emitConfetti")
        }
    }
    
    func stopEmitting() {
        removeAction(forKey: "emitConfetti")
    }
    
    private func emitConfetti() {
        // Calculate number of pieces to emit based on intensity
        let piecesToEmit = Int(10 * intensity)

        for _ in 0..<piecesToEmit {
            // Randomly select confetti properties
            let shape = randomShape()
            let color = colors.randomElement() ?? .systemRed
            let randomSize = CGFloat.random(in: 5...15)
            
            // Create confetti piece
            let confetti = createConfettiPiece(shape: shape, color: color, size: randomSize)
            
            // Position at random x position at top of scene
            let xPosition = CGFloat.random(in: 0...size.width)
            confetti.position = CGPoint(x: xPosition, y: size.height + 10)
            
            // Add physics for realistic falling
            let body = SKPhysicsBody(rectangleOf: confetti.frame.size)
            body.linearDamping = CGFloat.random(in: 0.2...0.5)
            body.angularDamping = CGFloat.random(in: 0.2...0.5)
            body.density = CGFloat.random(in: 0.5...1.0)
            
            // Add random rotation
            body.angularVelocity = CGFloat.random(in: -5...5)
            
            // Add random horizontal velocity
            body.velocity = CGVector(
                dx: CGFloat.random(in: -100...100),
                dy: CGFloat.random(in: -20...20)
            )
            
            // Add slight horizontal drift for realistic motion
            body.fieldBitMask = 0
            confetti.physicsBody = body
            
            // Add to scene
            addChild(confetti)
            
            // Remove after lifetime
            let waitAction = SKAction.wait(forDuration: lifetime)
            let removeAction = SKAction.removeFromParent()
            confetti.run(SKAction.sequence([waitAction, removeAction]))
        }
    }
    
    private func randomShape() -> ConfettiShape {
        let shapes: [ConfettiShape] = [.circle, .triangle, .square, .rectangle]
        return shapes.randomElement() ?? .square
    }
    
    private func createConfettiPiece(shape: ConfettiShape, color: UIColor, size: CGFloat) -> SKNode {
        switch shape {
        case .circle:
            let circle = SKShapeNode(circleOfRadius: size / 2)
            circle.fillColor = color
            circle.strokeColor = color
            return circle
            
        case .square:
            let square = SKSpriteNode(color: color, size: CGSize(width: size, height: size))
            return square
            
        case .rectangle:
            let width = size
            let height = size * CGFloat.random(in: 1.5...3.0)
            let rectangle = SKSpriteNode(color: color, size: CGSize(width: width, height: height))
            return rectangle
            
        case .triangle:
            let triangle = SKShapeNode()
            let path = UIBezierPath()
            let height = size * 1.5
            
            path.move(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: size, y: 0))
            path.addLine(to: CGPoint(x: size * 2, y: height))
            path.close()
            
            triangle.path = path.cgPath
            triangle.fillColor = color
            triangle.strokeColor = color
            return triangle
        }
    }
}

// SwiftUI wrapper for the SpriteKit confetti scene using SpriteView
struct ConfettiView: View {
    var intensity: Double
    var isEmitting: Bool
    var duration: TimeInterval
    
    var body: some View {
        SpriteView(scene: makeConfettiScene(), options: [.allowsTransparency])
            .allowsHitTesting(false)
            .ignoresSafeArea()
    }
    
    private func makeConfettiScene() -> SKScene {
        let scene = ConfettiScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        scene.intensity = intensity
        scene.isEmitting = isEmitting
        scene.burstDuration = duration
        scene.backgroundColor = .clear
        
        return scene
    }
}

// Convenience modifier to add timed confetti to any view
extension View {
    func confetti(isPresented: Bool, intensity: Double = 0.5, duration: TimeInterval = 3.0) -> some View {
        ZStack {
            self
            if isPresented {
                ConfettiView(intensity: intensity, isEmitting: true, duration: duration)
            }
        }
    }
}

// Preview
struct ConfettiView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var showConfetti = false
        
        var body: some View {
            ZStack {
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                
                VStack {
                    if showConfetti {
                        Text("🎉 Congratulations! 🎉")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .padding()
                    }
                    
                    Button("Trigger 2-Second Confetti") {
                        showConfetti = true
                        
                        // Automatically hide after duration + falling time
                        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                            showConfetti = false
                        }
                    }
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .confetti(isPresented: showConfetti, intensity: 0.7, duration: 2.0)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
} 
