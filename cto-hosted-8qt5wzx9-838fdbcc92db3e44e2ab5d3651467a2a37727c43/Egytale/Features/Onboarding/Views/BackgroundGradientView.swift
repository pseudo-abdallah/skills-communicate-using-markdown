import SwiftUI

struct BackgroundGradientView: View {
    let slideIndex: Int
    let totalSlides: Int

    @State private var animateGradient: Bool = false

    private var primaryColor: Color {
        switch slideIndex {
        case 0: return Color.goldAccent.opacity(0.18)
        case 1: return Color.camel.opacity(0.16)
        case 2: return Color.warmSand.opacity(0.22)
        default: return Color.goldAccent.opacity(0.18)
        }
    }

    private var secondaryColor: Color {
        switch slideIndex {
        case 0: return Color(red: 0.980, green: 0.965, blue: 0.935)
        case 1: return Color(red: 0.972, green: 0.955, blue: 0.918)
        case 2: return Color(red: 0.988, green: 0.976, blue: 0.951)
        default: return Color.beige
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.980, green: 0.965, blue: 0.935),
                    secondaryColor,
                    Color(red: 0.918, green: 0.886, blue: 0.820)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            RadialGradient(
                colors: [
                    primaryColor,
                    Color.clear
                ],
                center: UnitPoint(x: animateGradient ? 0.72 : 0.28, y: 0.35),
                startRadius: 0,
                endRadius: 320
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: animateGradient)

            PharaonicPatternView(style: .geometric)
                .opacity(0.04)
                .ignoresSafeArea()
        }
        .onAppear {
            animateGradient = true
        }
    }
}
