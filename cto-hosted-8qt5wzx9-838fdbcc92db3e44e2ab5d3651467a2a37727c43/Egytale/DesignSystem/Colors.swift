import SwiftUI

extension Color {
    static let warmSand = Color(red: 0.902, green: 0.863, blue: 0.769)
    static let beige = Color(red: 0.961, green: 0.941, blue: 0.902)
    static let camel = Color(red: 0.788, green: 0.659, blue: 0.424)
    static let cocoa = Color(red: 0.420, green: 0.267, blue: 0.137)
    static let darkChocolate = Color(red: 0.239, green: 0.157, blue: 0.090)
    static let goldAccent = Color(red: 0.831, green: 0.686, blue: 0.216)
    static let goldLight = Color(red: 0.929, green: 0.831, blue: 0.545)
    static let sandDark = Color(red: 0.800, green: 0.753, blue: 0.659)

    static let primaryBackground = Color(red: 0.973, green: 0.957, blue: 0.925)
    static let surfaceGlass = Color.warmSand.opacity(0.35)
    static let glassStroke = Color.goldAccent.opacity(0.28)
    static let glassStrokeStrong = Color.goldAccent.opacity(0.48)
    static let textPrimary = Color.darkChocolate
    static let textSecondary = Color.cocoa.opacity(0.80)
    static let textTertiary = Color.cocoa.opacity(0.55)
    static let interactiveGold = Color.goldAccent
    static let interactiveCamel = Color.camel
}

extension ShapeStyle where Self == LinearGradient {
    static var pharaonicGold: LinearGradient {
        LinearGradient(
            colors: [Color.goldLight, Color.goldAccent, Color(red: 0.710, green: 0.557, blue: 0.122)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static var warmBackground: LinearGradient {
        LinearGradient(
            colors: [Color.primaryBackground, Color.warmSand.opacity(0.6), Color.beige],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    static var splashBackground: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.212, green: 0.137, blue: 0.078),
                Color(red: 0.267, green: 0.176, blue: 0.098),
                Color(red: 0.357, green: 0.235, blue: 0.133)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static var slideBackground: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.980, green: 0.965, blue: 0.937),
                Color(red: 0.953, green: 0.929, blue: 0.882),
                Color(red: 0.918, green: 0.886, blue: 0.820)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
