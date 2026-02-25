import SwiftUI

enum AnimationConstants {
    static let splashReveal = Animation.spring(response: 1.0, dampingFraction: 0.72, blendDuration: 0)
    static let splashCharacter = Animation.easeOut(duration: 0.55)
    static let slideEntrance = Animation.spring(response: 0.65, dampingFraction: 0.80, blendDuration: 0)
    static let slideTransition = Animation.interpolatingSpring(stiffness: 260, damping: 30)
    static let elementStagger = Animation.easeOut(duration: 0.50)
    static let buttonPress = Animation.spring(response: 0.30, dampingFraction: 0.65, blendDuration: 0)
    static let shimmer = Animation.easeInOut(duration: 2.2).repeatForever(autoreverses: true)
    static let float = Animation.easeInOut(duration: 3.5).repeatForever(autoreverses: true)
    static let screenTransition = Animation.easeInOut(duration: 0.45)
    static let pageIndicator = Animation.spring(response: 0.40, dampingFraction: 0.75, blendDuration: 0)

    static func staggered(index: Int, base: Double = 0.08) -> Animation {
        .easeOut(duration: 0.50).delay(Double(index) * base)
    }

    static func splashCharacterDelay(index: Int) -> Animation {
        .easeOut(duration: 0.45).delay(0.90 + Double(index) * 0.065)
    }
}
