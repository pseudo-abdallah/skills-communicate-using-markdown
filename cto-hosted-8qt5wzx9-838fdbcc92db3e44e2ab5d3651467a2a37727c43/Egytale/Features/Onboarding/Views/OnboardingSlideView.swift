import SwiftUI

struct OnboardingSlideView: View {
    let slide: OnboardingSlide
    let isActive: Bool
    let dragOffset: CGFloat

    @State private var iconAppeared = false
    @State private var badgeAppeared = false
    @State private var titleAppeared = false
    @State private var descriptionAppeared = false
    @State private var cardAppeared = false
    @State private var iconFloat: CGFloat = 0
    @State private var iconRotation: Double = 0
    @State private var shimmerPhase: CGFloat = -1.2

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: dynamicTopPadding)

            iconSection

            Spacer().frame(height: EgytaleSpacing.xl)

            contentCard

            Spacer()
        }
        .onChange(of: isActive) { _, newValue in
            if newValue {
                triggerEntranceAnimations()
            } else {
                resetAnimationState()
            }
        }
        .onAppear {
            if isActive {
                triggerEntranceAnimations()
            }
        }
    }

    private var dynamicTopPadding: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.safeAreaInsets.top ?? 59
    }

    private var iconSection: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            slide.backgroundAccent.opacity(1.8),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: 130
                    )
                )
                .frame(width: 260, height: 260)
                .blur(radius: 40)
                .opacity(iconAppeared ? 1.0 : 0)

            ZStack {
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.goldAccent.opacity(0.45),
                                Color.goldAccent.opacity(0.12),
                                Color.goldAccent.opacity(0.38)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.2
                    )
                    .frame(width: 148, height: 148)

                Circle()
                    .strokeBorder(
                        Color.goldAccent.opacity(0.12),
                        lineWidth: 0.8
                    )
                    .frame(width: 170, height: 170)

                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .overlay(
                            Circle()
                                .fill(Color.camel.opacity(0.10))
                        )
                        .frame(width: 130, height: 130)
                        .overlay(
                            Circle()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(0.38),
                                            Color.white.opacity(0.08)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.0
                                )
                        )

                    slideIconView
                        .offset(y: iconFloat)
                        .rotationEffect(.degrees(iconRotation))
                }
                .shadow(color: Color.goldAccent.opacity(0.20), radius: 28, x: 0, y: 12)
                .shadow(color: Color.darkChocolate.opacity(0.10), radius: 10, x: 0, y: 4)
            }
            .scaleEffect(iconAppeared ? 1.0 : 0.5)
            .opacity(iconAppeared ? 1.0 : 0)
            .animation(AnimationConstants.slideEntrance.delay(0.05), value: iconAppeared)
        }
        .frame(height: 220)
    }

    @ViewBuilder
    private var slideIconView: some View {
        switch slide.iconType {
        case .pyramid:
            TriplePyramidView(size: 72, animated: isActive)
        case .eyeOfHorus:
            EyeOfHorusView(size: 62, color: .goldAccent)
        case .lotus:
            LotusView(size: 62, color: .goldAccent)
        case .scarab:
            ScarabView(size: 62, color: .goldAccent)
        case .ankh:
            AnkhView(size: 58, color: .goldAccent)
        }
    }

    private var contentCard: some View {
        VStack(alignment: .leading, spacing: EgytaleSpacing.lg) {
            badgeView
                .opacity(badgeAppeared ? 1.0 : 0)
                .offset(y: badgeAppeared ? 0 : 14)
                .animation(AnimationConstants.staggered(index: 0), value: badgeAppeared)

            titleView
                .opacity(titleAppeared ? 1.0 : 0)
                .offset(y: titleAppeared ? 0 : 18)
                .animation(AnimationConstants.staggered(index: 1), value: titleAppeared)

            dividerLine

            descriptionView
                .opacity(descriptionAppeared ? 1.0 : 0)
                .offset(y: descriptionAppeared ? 0 : 14)
                .animation(AnimationConstants.staggered(index: 2), value: descriptionAppeared)

            featurePills
                .opacity(descriptionAppeared ? 1.0 : 0)
                .offset(y: descriptionAppeared ? 0 : 10)
                .animation(AnimationConstants.staggered(index: 3), value: descriptionAppeared)
        }
        .padding(EgytaleSpacing.xl)
        .glassCard(cornerRadius: EgytaleRadius.xl, tintOpacity: 0.10, shadowRadius: 30)
        .padding(.horizontal, EgytaleSpacing.lg)
        .scaleEffect(cardAppeared ? 1.0 : 0.94)
        .opacity(cardAppeared ? 1.0 : 0)
        .animation(AnimationConstants.slideEntrance.delay(0.12), value: cardAppeared)
        .drawingGroup()
    }

    private var badgeView: some View {
        HStack(spacing: EgytaleSpacing.xs) {
            Image(systemName: "sparkles")
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(Color.goldAccent)
            Text(slide.badge)
                .font(EgytaleFonts.captionMedium)
                .foregroundStyle(Color.goldAccent)
                .tracking(1.8)
        }
        .padding(.horizontal, EgytaleSpacing.md)
        .padding(.vertical, EgytaleSpacing.xs + 2)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
                .overlay(Capsule().fill(Color.goldAccent.opacity(0.08)))
                .overlay(
                    Capsule()
                        .strokeBorder(Color.goldAccent.opacity(0.35), lineWidth: 0.8)
                )
        )
    }

    private var titleView: some View {
        Text(slide.title)
            .font(EgytaleFonts.slideTitle)
            .foregroundStyle(Color.darkChocolate)
            .lineSpacing(4)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var dividerLine: some View {
        HStack(spacing: EgytaleSpacing.sm) {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color.goldAccent.opacity(0.65), Color.goldAccent.opacity(0.15)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 36, height: 1.5)
                .cornerRadius(1)

            Text(slide.subtitle)
                .font(EgytaleFonts.callout)
                .foregroundStyle(Color.cocoa.opacity(0.70))
        }
    }

    private var descriptionView: some View {
        Text(slide.description)
            .font(EgytaleFonts.callout)
            .foregroundStyle(Color.cocoa.opacity(0.78))
            .lineSpacing(5)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var featurePills: some View {
        HStack(spacing: EgytaleSpacing.sm) {
            ForEach(featureItems, id: \.0) { icon, label in
                HStack(spacing: 5) {
                    Image(systemName: icon)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.camel)
                    Text(label)
                        .font(EgytaleFonts.caption)
                        .foregroundStyle(Color.cocoa.opacity(0.72))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(Color.camel.opacity(0.10))
                        .overlay(Capsule().strokeBorder(Color.camel.opacity(0.22), lineWidth: 0.6))
                )
            }
        }
    }

    private var featureItems: [(String, String)] {
        switch slide.id {
        case 0: return [("checkmark.seal", "Certified"), ("arrow.up.right", "Premium")]
        case 1: return [("person.badge.shield.checkmark", "Verified"), ("book.closed", "Scholarly")]
        case 2: return [("storefront", "200+ Artisans"), ("star", "Handpicked")]
        default: return []
        }
    }

    private func triggerEntranceAnimations() {
        let delays: [Double] = [0.08, 0.14, 0.22, 0.30, 0.38]
        DispatchQueue.main.asyncAfter(deadline: .now() + delays[0]) { iconAppeared = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + delays[1]) { cardAppeared = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + delays[2]) { badgeAppeared = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + delays[3]) { titleAppeared = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + delays[4]) { descriptionAppeared = true }

        withAnimation(AnimationConstants.float.delay(0.50)) {
            iconFloat = -8
        }

        withAnimation(
            .easeInOut(duration: 5.5)
            .repeatForever(autoreverses: true)
            .delay(0.80)
        ) {
            iconRotation = 3
        }
    }

    private func resetAnimationState() {
        iconAppeared = false
        badgeAppeared = false
        titleAppeared = false
        descriptionAppeared = false
        cardAppeared = false
        iconFloat = 0
        iconRotation = 0
    }
}
