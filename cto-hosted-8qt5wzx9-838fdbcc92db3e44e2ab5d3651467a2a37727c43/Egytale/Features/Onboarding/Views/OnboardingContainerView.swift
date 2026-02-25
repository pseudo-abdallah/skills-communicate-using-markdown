import SwiftUI

struct OnboardingContainerView: View {
    let onComplete: () -> Void

    @StateObject private var viewModel = OnboardingViewModel()
    @State private var showAuthEntry = false
    @State private var screenScale: CGFloat = 1.0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundLayer

            slideStack

            bottomOverlay

            if showAuthEntry {
                VStack(spacing: 0) {
                    Spacer()
                    AuthEntryView(
                        onSignUp: { onComplete() },
                        onSignIn: { onComplete() },
                        onGuest: { onComplete() }
                    )
                }
                .ignoresSafeArea(edges: .bottom)
                .transition(.asymmetric(
                    insertion: .move(edge: .bottom).combined(with: .opacity),
                    removal: .move(edge: .bottom).combined(with: .opacity)
                ))
                .zIndex(10)
            }
        }
        .ignoresSafeArea()
        .scaleEffect(screenScale)
        .gesture(swipeGesture)
    }

    private var backgroundLayer: some View {
        ZStack {
            ForEach(viewModel.slides) { slide in
                BackgroundGradientView(
                    slideIndex: slide.id,
                    totalSlides: viewModel.slides.count
                )
                .opacity(slide.id == viewModel.currentSlideIndex ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.55), value: viewModel.currentSlideIndex)
            }
        }
        .ignoresSafeArea()
    }

    private var slideStack: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                ForEach(viewModel.slides) { slide in
                    OnboardingSlideView(
                        slide: slide,
                        isActive: slide.id == viewModel.currentSlideIndex,
                        dragOffset: slide.id == viewModel.currentSlideIndex ? viewModel.dragOffset : 0
                    )
                    .frame(width: geo.size.width)
                    .scaleEffect(
                        slideScale(for: slide.id, in: geo.size.width),
                        anchor: .center
                    )
                    .opacity(slideOpacity(for: slide.id))
                }
            }
            .offset(x: slideOffset(screenWidth: geo.size.width))
            .animation(
                reduceMotion ? .easeInOut(duration: 0.25) : AnimationConstants.slideTransition,
                value: viewModel.currentSlideIndex
            )
        }
    }

    private func slideOffset(screenWidth: CGFloat) -> CGFloat {
        let baseOffset = -CGFloat(viewModel.currentSlideIndex) * screenWidth
        return baseOffset + viewModel.dragOffset
    }

    private func slideScale(for index: Int, in screenWidth: CGFloat) -> CGFloat {
        let distance = abs(CGFloat(index - viewModel.currentSlideIndex))
        let dragFraction = abs(viewModel.dragOffset) / screenWidth
        let effectiveDistance = distance - dragFraction
        return max(0.88, 1.0 - effectiveDistance * 0.06)
    }

    private func slideOpacity(for index: Int) -> Double {
        let distance = abs(index - viewModel.currentSlideIndex)
        return distance == 0 ? 1.0 : (distance == 1 ? 0.55 : 0.0)
    }

    private var bottomOverlay: some View {
        VStack(spacing: 0) {
            Spacer()

            if !showAuthEntry {
                VStack(spacing: EgytaleSpacing.xxl) {
                    PageIndicator(
                        totalPages: viewModel.slides.count,
                        currentPage: viewModel.currentSlideIndex,
                        onTap: { index in viewModel.goTo(index: index) }
                    )

                    ctaButton
                }
                .padding(.horizontal, EgytaleSpacing.lg)
                .padding(.bottom, bottomSafeArea + EgytaleSpacing.xl)
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .move(edge: .bottom)),
                    removal: .opacity.combined(with: .move(edge: .bottom))
                ))
            }
        }
    }

    private var bottomSafeArea: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.safeAreaInsets.bottom ?? 34
    }

    private var ctaButton: some View {
        Group {
            if viewModel.isLastSlide {
                lastSlideCTA
            } else {
                nextSlideButton
            }
        }
        .animation(AnimationConstants.slideTransition, value: viewModel.isLastSlide)
    }

    private var nextSlideButton: some View {
        Button {
            viewModel.advance()
        } label: {
            HStack(spacing: EgytaleSpacing.sm) {
                Text("Continue")
                    .font(EgytaleFonts.buttonPrimary)
                    .foregroundStyle(Color.darkChocolate)

                Image(systemName: "arrow.right")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.darkChocolate)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
        }
        .background(
            RoundedRectangle(cornerRadius: EgytaleRadius.full, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.goldLight, Color.goldAccent],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: EgytaleRadius.full, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.28), Color.clear],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: EgytaleRadius.full, style: .continuous)
                .strokeBorder(Color.goldAccent.opacity(0.30), lineWidth: 0.8)
        )
        .shadow(color: Color.goldAccent.opacity(0.35), radius: 16, x: 0, y: 6)
        .buttonStyle(ScaleButtonStyle())
    }

    private var lastSlideCTA: some View {
        Button {
            HapticManager.success()
            withAnimation(AnimationConstants.slideEntrance) {
                showAuthEntry = true
            }
        } label: {
            HStack(spacing: EgytaleSpacing.sm) {
                Image(systemName: "sparkles")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.darkChocolate)
                Text("Explore Egytale")
                    .font(EgytaleFonts.buttonPrimary)
                    .foregroundStyle(Color.darkChocolate)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
        }
        .background(
            RoundedRectangle(cornerRadius: EgytaleRadius.full, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.goldLight, Color.goldAccent, Color(red: 0.710, green: 0.557, blue: 0.122)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: EgytaleRadius.full, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.32), Color.clear],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: EgytaleRadius.full, style: .continuous)
                .strokeBorder(Color.goldAccent.opacity(0.35), lineWidth: 0.8)
        )
        .shadow(color: Color.goldAccent.opacity(0.50), radius: 22, x: 0, y: 8)
        .buttonStyle(ScaleButtonStyle())
    }

    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 12, coordinateSpace: .global)
            .onChanged { value in
                guard !showAuthEntry else { return }
                let horizontalDominance = abs(value.translation.width) > abs(value.translation.height)
                if horizontalDominance {
                    let resistance: CGFloat = 0.25
                    let atLeadingEdge = viewModel.currentSlideIndex == 0 && value.translation.width > 0
                    let atTrailingEdge = viewModel.isLastSlide && value.translation.width < 0
                    let dampening = (atLeadingEdge || atTrailingEdge) ? resistance : 1.0
                    withAnimation(.interactiveSpring(response: 0.25)) {
                        viewModel.dragOffset = value.translation.width * dampening
                    }
                }
            }
            .onEnded { value in
                guard !showAuthEntry else { return }
                let velocity = value.predictedEndTranslation.width - value.translation.width
                viewModel.handleDragEnd(
                    translation: value.translation.width,
                    velocity: velocity,
                    screenWidth: UIScreen.main.bounds.width
                )
            }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.965 : 1.0)
            .animation(AnimationConstants.buttonPress, value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, pressed in
                if pressed { HapticManager.light() }
            }
    }
}

#Preview {
    OnboardingContainerView(onComplete: {})
}
