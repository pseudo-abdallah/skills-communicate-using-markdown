import SwiftUI

struct AuthEntryView: View {
    let onSignUp: () -> Void
    let onSignIn: () -> Void
    let onGuest: () -> Void

    @State private var signUpPressed = false
    @State private var signInPressed = false
    @State private var socialPressed: String? = nil
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: EgytaleSpacing.md) {
                headerSection

                Spacer().frame(height: EgytaleSpacing.sm)

                signUpButton

                Spacer().frame(height: EgytaleSpacing.xs)

                socialSection

                Spacer().frame(height: EgytaleSpacing.sm)

                dividerWithText

                Spacer().frame(height: EgytaleSpacing.sm)

                signInButton

                guestButton
            }
            .padding(.horizontal, EgytaleSpacing.lg)
            .padding(.top, EgytaleSpacing.xxl)
            .padding(.bottom, bottomPadding)
        }
        .background(authBackground)
        .opacity(appeared ? 1.0 : 0)
        .offset(y: appeared ? 0 : 30)
        .onAppear {
            withAnimation(AnimationConstants.slideEntrance.delay(0.10)) {
                appeared = true
            }
        }
    }

    private var bottomPadding: CGFloat {
        let insets = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.safeAreaInsets.bottom ?? 34
        return insets + EgytaleSpacing.xl
    }

    private var authBackground: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay(
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.beige.opacity(0.82),
                                    Color.warmSand.opacity(0.65)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )

            VStack(spacing: 0) {
                Capsule()
                    .fill(Color.camel.opacity(0.35))
                    .frame(width: 38, height: 4)
                    .padding(.top, EgytaleSpacing.md)
                Spacer()
            }
        }
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: EgytaleRadius.xl,
                topTrailingRadius: EgytaleRadius.xl
            )
        )
        .overlay(
            UnevenRoundedRectangle(
                topLeadingRadius: EgytaleRadius.xl,
                topTrailingRadius: EgytaleRadius.xl
            )
            .strokeBorder(
                LinearGradient(
                    colors: [Color.goldAccent.opacity(0.40), Color.goldAccent.opacity(0.10)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1.0
            )
        )
        .shadow(color: Color.darkChocolate.opacity(0.14), radius: 30, x: 0, y: -8)
    }

    private var headerSection: some View {
        VStack(spacing: EgytaleSpacing.xs) {
            Text("Begin Your Journey")
                .font(EgytaleFonts.sectionTitle)
                .foregroundStyle(Color.darkChocolate)
                .multilineTextAlignment(.center)

            Text("Join 50,000+ collectors and culture enthusiasts")
                .font(EgytaleFonts.callout)
                .foregroundStyle(Color.cocoa.opacity(0.72))
                .multilineTextAlignment(.center)
        }
        .padding(.top, EgytaleSpacing.sm)
    }

    private var signUpButton: some View {
        PressableButton(isPressed: $signUpPressed) {
            HStack(spacing: EgytaleSpacing.sm) {
                Image(systemName: "sparkles")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.darkChocolate)
                Text("Create Free Account")
                    .font(EgytaleFonts.buttonPrimary)
                    .foregroundStyle(Color.darkChocolate)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
        } action: {
            HapticManager.medium()
            onSignUp()
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
        .shadow(color: Color.goldAccent.opacity(0.40), radius: signUpPressed ? 6 : 18, x: 0, y: signUpPressed ? 2 : 8)
        .scaleEffect(signUpPressed ? 0.972 : 1.0)
        .animation(AnimationConstants.buttonPress, value: signUpPressed)
    }

    private var socialSection: some View {
        HStack(spacing: EgytaleSpacing.sm) {
            socialButton(icon: "apple.logo", label: "Apple", id: "apple")
            socialButton(icon: "g.circle.fill", label: "Google", id: "google")
        }
    }

    private func socialButton(icon: String, label: String, id: String) -> some View {
        PressableButton(isPressed: .constant(socialPressed == id)) {
            HStack(spacing: EgytaleSpacing.xs + 2) {
                Image(systemName: icon)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.darkChocolate)
                Text("Continue with \(label)")
                    .font(EgytaleFonts.buttonSecondary)
                    .foregroundStyle(Color.darkChocolate)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 13)
        } action: {
            HapticManager.light()
            onSignUp()
        }
        .glassButton(style: .secondary, isPressed: socialPressed == id)
    }

    private var dividerWithText: some View {
        HStack(spacing: EgytaleSpacing.md) {
            Rectangle()
                .fill(Color.camel.opacity(0.25))
                .frame(height: 0.8)

            Text("or")
                .font(EgytaleFonts.caption)
                .foregroundStyle(Color.cocoa.opacity(0.55))

            Rectangle()
                .fill(Color.camel.opacity(0.25))
                .frame(height: 0.8)
        }
    }

    private var signInButton: some View {
        PressableButton(isPressed: $signInPressed) {
            Text("Sign In to Your Account")
                .font(EgytaleFonts.buttonSecondary)
                .foregroundStyle(Color.cocoa)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 13)
        } action: {
            HapticManager.light()
            onSignIn()
        }
        .glassButton(style: .ghost, isPressed: signInPressed)
    }

    private var guestButton: some View {
        Button {
            HapticManager.soft()
            onGuest()
        } label: {
            HStack(spacing: EgytaleSpacing.xs) {
                Text("Continue as Guest")
                    .font(EgytaleFonts.caption)
                    .foregroundStyle(Color.cocoa.opacity(0.55))

                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color.camel.opacity(0.55))
            }
        }
        .padding(.top, EgytaleSpacing.xs)
    }
}

struct PressableButton<Label: View>: View {
    @Binding var isPressed: Bool
    @ViewBuilder let label: () -> Label
    let action: () -> Void

    var body: some View {
        label()
            .contentShape(RoundedRectangle(cornerRadius: EgytaleRadius.full))
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            withAnimation(AnimationConstants.buttonPress) {
                                isPressed = true
                            }
                        }
                    }
                    .onEnded { _ in
                        withAnimation(AnimationConstants.buttonPress) {
                            isPressed = false
                        }
                        action()
                    }
            )
    }
}

#Preview {
    ZStack {
        Color.warmSand.ignoresSafeArea()
        VStack {
            Spacer()
            AuthEntryView(
                onSignUp: {},
                onSignIn: {},
                onGuest: {}
            )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
