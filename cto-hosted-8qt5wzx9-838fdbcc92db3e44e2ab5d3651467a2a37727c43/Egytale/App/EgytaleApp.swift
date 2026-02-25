import SwiftUI

@main
struct EgytaleApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {
            RootView(hasCompletedOnboarding: $hasCompletedOnboarding)
                .preferredColorScheme(.light)
        }
    }
}

struct RootView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView(onComplete: {
                    withAnimation(AnimationConstants.screenTransition) {
                        showSplash = false
                    }
                })
                .transition(.opacity)
                .zIndex(1)
            } else if !hasCompletedOnboarding {
                OnboardingContainerView(onComplete: {
                    withAnimation(AnimationConstants.screenTransition) {
                        hasCompletedOnboarding = true
                    }
                })
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .move(edge: .trailing)),
                    removal: .opacity
                ))
            } else {
                MainPlaceholderView()
                    .transition(.opacity)
            }
        }
        .ignoresSafeArea()
    }
}

struct MainPlaceholderView: View {
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            VStack(spacing: EgytaleSpacing.lg) {
                PharaonicIcons.ankh
                    .font(.system(size: 64))
                    .foregroundStyle(Color.goldAccent)
                Text("EGYTALE")
                    .font(EgytaleFonts.displayTitle)
                    .foregroundStyle(Color.darkChocolate)
                Text("Your journey begins")
                    .font(EgytaleFonts.body)
                    .foregroundStyle(Color.cocoa)
            }
        }
    }
}
