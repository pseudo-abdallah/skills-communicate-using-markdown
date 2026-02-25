import SwiftUI

struct GlassCard: ViewModifier {
    var cornerRadius: CGFloat = EgytaleRadius.lg
    var strokeOpacity: Double = 1.0
    var tintOpacity: Double = 0.12
    var shadowRadius: CGFloat = 24

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(Color.camel.opacity(tintOpacity))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.goldAccent.opacity(0.55 * strokeOpacity),
                                Color.goldAccent.opacity(0.15 * strokeOpacity),
                                Color.goldAccent.opacity(0.40 * strokeOpacity)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.0
                    )
            )
            .shadow(color: Color.darkChocolate.opacity(0.10), radius: shadowRadius, x: 0, y: 8)
            .shadow(color: Color.goldAccent.opacity(0.06), radius: 4, x: 0, y: 2)
    }
}

struct GlassButton: ViewModifier {
    var style: GlassButtonStyle = .primary
    var isPressed: Bool = false

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: EgytaleRadius.full, style: .continuous)
                    .fill(style.backgroundFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: EgytaleRadius.full, style: .continuous)
                            .fill(style.tintFill)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: EgytaleRadius.full, style: .continuous)
                    .strokeBorder(style.strokeGradient, lineWidth: 1.2)
            )
            .shadow(color: style.shadowColor, radius: isPressed ? 4 : 16, x: 0, y: isPressed ? 2 : 6)
            .scaleEffect(isPressed ? 0.97 : 1.0)
    }
}

enum GlassButtonStyle {
    case primary
    case secondary
    case ghost

    var backgroundFill: AnyShapeStyle {
        switch self {
        case .primary:
            return AnyShapeStyle(.ultraThinMaterial)
        case .secondary:
            return AnyShapeStyle(.thinMaterial)
        case .ghost:
            return AnyShapeStyle(Color.clear)
        }
    }

    var tintFill: AnyShapeStyle {
        switch self {
        case .primary:
            return AnyShapeStyle(Color.goldAccent.opacity(0.22))
        case .secondary:
            return AnyShapeStyle(Color.camel.opacity(0.12))
        case .ghost:
            return AnyShapeStyle(Color.clear)
        }
    }

    var strokeGradient: LinearGradient {
        switch self {
        case .primary:
            return LinearGradient(
                colors: [Color.goldAccent.opacity(0.70), Color.goldAccent.opacity(0.25)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .secondary:
            return LinearGradient(
                colors: [Color.camel.opacity(0.50), Color.camel.opacity(0.20)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .ghost:
            return LinearGradient(
                colors: [Color.cocoa.opacity(0.30), Color.cocoa.opacity(0.15)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var shadowColor: Color {
        switch self {
        case .primary: return Color.goldAccent.opacity(0.25)
        case .secondary: return Color.darkChocolate.opacity(0.12)
        case .ghost: return Color.clear
        }
    }
}

extension View {
    func glassCard(
        cornerRadius: CGFloat = EgytaleRadius.lg,
        strokeOpacity: Double = 1.0,
        tintOpacity: Double = 0.12,
        shadowRadius: CGFloat = 24
    ) -> some View {
        modifier(GlassCard(
            cornerRadius: cornerRadius,
            strokeOpacity: strokeOpacity,
            tintOpacity: tintOpacity,
            shadowRadius: shadowRadius
        ))
    }

    func glassButton(style: GlassButtonStyle = .primary, isPressed: Bool = false) -> some View {
        modifier(GlassButton(style: style, isPressed: isPressed))
    }
}
