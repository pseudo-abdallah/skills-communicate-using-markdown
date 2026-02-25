import SwiftUI

struct SplashScreenView: View {
    let onComplete: () -> Void

    @State private var logoScale: CGFloat = 0.35
    @State private var logoOpacity: Double = 0
    @State private var logoRotation: Double = -8
    @State private var glowOpacity: Double = 0
    @State private var wordmarkProgress: Int = 0
    @State private var taglineOpacity: Double = 0
    @State private var taglineOffset: CGFloat = 12
    @State private var dividerScale: CGFloat = 0
    @State private var backgroundRadialOpacity: Double = 0
    @State private var particlesVisible: Bool = false
    @State private var screenOpacity: Double = 1.0

    private let wordmark = Array("EGYTALE")

    var body: some View {
        ZStack {
            splashBackground

            if particlesVisible {
                SandParticleView()
                    .transition(.opacity)
            }

            radialGlowLayer

            VStack(spacing: 0) {
                Spacer()

                logoSection

                Spacer().frame(height: EgytaleSpacing.xl)

                dividerView

                Spacer().frame(height: EgytaleSpacing.lg)

                wordmarkSection

                Spacer().frame(height: EgytaleSpacing.md)

                taglineView

                Spacer()

                bottomBadge
            }
            .padding(.horizontal, EgytaleSpacing.xxl)
        }
        .opacity(screenOpacity)
        .ignoresSafeArea()
        .onAppear {
            startAnimationSequence()
        }
    }

    private var splashBackground: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.155, green: 0.098, blue: 0.055),
                    Color(red: 0.212, green: 0.137, blue: 0.078),
                    Color(red: 0.290, green: 0.188, blue: 0.106),
                    Color(red: 0.212, green: 0.137, blue: 0.078)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            PharaonicPatternView(style: .hieroglyphic)
                .opacity(0.06)
        }
        .ignoresSafeArea()
    }

    private var radialGlowLayer: some View {
        ZStack {
            RadialGradient(
                colors: [
                    Color.goldAccent.opacity(0.25 * backgroundRadialOpacity),
                    Color.clear
                ],
                center: .center,
                startRadius: 0,
                endRadius: 280
            )
            .blendMode(.screen)
            .ignoresSafeArea()

            RadialGradient(
                colors: [
                    Color(red: 0.831, green: 0.686, blue: 0.216).opacity(0.15 * backgroundRadialOpacity),
                    Color.clear
                ],
                center: UnitPoint(x: 0.5, y: 0.42),
                startRadius: 10,
                endRadius: 220
            )
            .ignoresSafeArea()
        }
        .opacity(backgroundRadialOpacity)
    }

    private var logoSection: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.goldAccent.opacity(0.35),
                            Color.goldAccent.opacity(0.08),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 90
                    )
                )
                .frame(width: 180, height: 180)
                .blur(radius: 28)
                .opacity(glowOpacity)
                .scaleEffect(logoScale * 1.1)

            ZStack {
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.goldAccent.opacity(0.55),
                                Color.goldLight.opacity(0.25),
                                Color.goldAccent.opacity(0.45)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
                    .frame(width: 130, height: 130)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .overlay(
                                Circle()
                                    .fill(Color.goldAccent.opacity(0.08))
                            )
                    )

                TriplePyramidView(size: 72, animated: true)
            }
            .scaleEffect(logoScale)
            .opacity(logoOpacity)
            .rotationEffect(.degrees(logoRotation))
            .shadow(color: Color.goldAccent.opacity(0.40), radius: 32, x: 0, y: 12)
        }
    }

    private var dividerView: some View {
        HStack(spacing: EgytaleSpacing.sm) {
            decorativeDiamondDivider()
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color.clear, Color.goldAccent.opacity(0.50), Color.clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 0.8)
                .scaleEffect(x: dividerScale, anchor: .center)
            decorativeDiamondDivider()
        }
        .frame(maxWidth: 220)
    }

    private func decorativeDiamondDivider() -> some View {
        Rectangle()
            .fill(Color.goldAccent.opacity(0.60))
            .frame(width: 5, height: 5)
            .rotationEffect(.degrees(45))
            .scaleEffect(dividerScale)
    }

    private var wordmarkSection: some View {
        HStack(spacing: 2.5) {
            ForEach(Array(wordmark.enumerated()), id: \.offset) { index, character in
                Text(String(character))
                    .font(EgytaleFonts.wordmarkLarge)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.goldLight, Color.goldAccent],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .opacity(index < wordmarkProgress ? 1.0 : 0.0)
                    .offset(y: index < wordmarkProgress ? 0 : 10)
                    .animation(
                        AnimationConstants.splashCharacterDelay(index: index),
                        value: wordmarkProgress
                    )
            }
        }
        .shadow(color: Color.goldAccent.opacity(0.30), radius: 12, x: 0, y: 4)
    }

    private var taglineView: some View {
        Text("Discover Authentic Pharaonic Heritage")
            .font(EgytaleFonts.tagline)
            .foregroundStyle(Color.warmSand.opacity(0.65))
            .tracking(2.0)
            .textCase(.uppercase)
            .opacity(taglineOpacity)
            .offset(y: taglineOffset)
    }

    private var bottomBadge: some View {
        VStack(spacing: EgytaleSpacing.xs) {
            HStack(spacing: EgytaleSpacing.xs) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.goldAccent.opacity(0.70))
                Text("Authenticity Certified")
                    .font(EgytaleFonts.captionMedium)
                    .foregroundStyle(Color.warmSand.opacity(0.50))
                    .tracking(1.2)
                    .textCase(.uppercase)
            }
        }
        .padding(.bottom, 48)
        .opacity(taglineOpacity)
    }

    private func startAnimationSequence() {
        withAnimation(AnimationConstants.splashReveal) {
            logoScale = 1.0
            logoOpacity = 1.0
            logoRotation = 0
            backgroundRadialOpacity = 1.0
        }

        withAnimation(.easeOut(duration: 1.0).delay(0.30)) {
            glowOpacity = 1.0
        }

        withAnimation(.easeOut(duration: 0.45).delay(0.55)) {
            dividerScale = 1.0
        }

        withAnimation(.none.delay(0.35)) {
            particlesVisible = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {
            withAnimation(.none) {
                wordmarkProgress = wordmark.count
            }
        }

        withAnimation(.easeOut(duration: 0.55).delay(1.55)) {
            taglineOpacity = 1.0
            taglineOffset = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.80) {
            withAnimation(.easeInOut(duration: 0.55)) {
                screenOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                onComplete()
            }
        }
    }
}

#Preview {
    SplashScreenView(onComplete: {})
}
