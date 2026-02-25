import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var opacity: Double
    var speed: CGFloat
    var drift: CGFloat
    var rotationSpeed: Double
    var rotation: Double = 0
    var color: Color
}

struct SandParticleView: View {
    @State private var particles: [Particle] = []
    @State private var animationPhase: Bool = false

    private let particleCount = 22

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { particle in
                    SandParticleShape()
                        .fill(particle.color)
                        .frame(width: particle.size, height: particle.size * 0.55)
                        .rotationEffect(.degrees(particle.rotation))
                        .position(
                            x: particle.x + (animationPhase ? particle.drift * 38 : 0),
                            y: particle.y + (animationPhase ? particle.speed * 55 : 0)
                        )
                        .opacity(animationPhase ? particle.opacity * 0.45 : 0)
                        .blur(radius: particle.size > 4 ? 0.5 : 0)
                        .animation(
                            .easeInOut(duration: Double.random(in: 4.5...8.0))
                            .repeatForever(autoreverses: true)
                            .delay(Double.random(in: 0...3.5)),
                            value: animationPhase
                        )
                }
            }
            .onAppear {
                particles = makeParticles(in: geo.size)
                withAnimation(.none.delay(0.05)) {
                    animationPhase = true
                }
            }
        }
        .allowsHitTesting(false)
    }

    private func makeParticles(in size: CGSize) -> [Particle] {
        let colors: [Color] = [
            Color.goldLight.opacity(0.75),
            Color.goldAccent.opacity(0.60),
            Color.warmSand.opacity(0.55),
            Color.camel.opacity(0.50)
        ]
        return (0..<particleCount).map { _ in
            Particle(
                x: CGFloat.random(in: 0...size.width),
                y: CGFloat.random(in: 0...size.height),
                size: CGFloat.random(in: 2...7),
                opacity: Double.random(in: 0.35...0.85),
                speed: CGFloat.random(in: -1...1),
                drift: CGFloat.random(in: -1...1),
                rotationSpeed: Double.random(in: -45...45),
                rotation: Double.random(in: 0...360),
                color: colors.randomElement()!
            )
        }
    }
}

struct SandParticleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct FloatingGlyphView: View {
    let glyph: String
    let size: CGFloat
    let color: Color

    @State private var floatOffset: CGFloat = 0
    @State private var opacity: Double = 0
    @State private var rotationAngle: Double = 0

    var body: some View {
        Text(glyph)
            .font(.system(size: size))
            .foregroundStyle(color)
            .opacity(opacity)
            .offset(y: floatOffset)
            .rotationEffect(.degrees(rotationAngle))
            .onAppear {
                let delay = Double.random(in: 0...2.5)
                withAnimation(.easeIn(duration: 0.80).delay(delay)) {
                    opacity = Double.random(in: 0.15...0.35)
                }
                withAnimation(
                    .easeInOut(duration: Double.random(in: 3.5...6.0))
                    .repeatForever(autoreverses: true)
                    .delay(delay)
                ) {
                    floatOffset = CGFloat.random(in: -12...12)
                    rotationAngle = Double.random(in: -8...8)
                }
            }
    }
}
