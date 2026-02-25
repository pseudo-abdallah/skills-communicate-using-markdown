import SwiftUI

enum EgytaleFonts {
    static let splashTitle = Font.system(.largeTitle, design: .serif, weight: .bold)
    static let displayTitle = Font.system(size: 34, weight: .bold, design: .serif)
    static let slideTitle = Font.system(size: 28, weight: .bold, design: .serif)
    static let sectionTitle = Font.system(size: 22, weight: .semibold, design: .serif)
    static let cardTitle = Font.system(size: 18, weight: .semibold, design: .serif)
    static let body = Font.system(size: 17, weight: .regular, design: .default)
    static let bodyMedium = Font.system(size: 17, weight: .medium, design: .default)
    static let callout = Font.system(size: 15, weight: .regular, design: .default)
    static let caption = Font.system(size: 13, weight: .regular, design: .default)
    static let captionMedium = Font.system(size: 13, weight: .medium, design: .default)
    static let buttonPrimary = Font.system(size: 17, weight: .semibold, design: .default)
    static let buttonSecondary = Font.system(size: 15, weight: .medium, design: .default)
    static let wordmark = Font.system(size: 26, weight: .bold, design: .serif)
    static let wordmarkLarge = Font.system(size: 38, weight: .bold, design: .serif)
    static let tagline = Font.system(size: 14, weight: .medium, design: .default)
}

enum EgytaleSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 20
    static let xl: CGFloat = 28
    static let xxl: CGFloat = 40
    static let xxxl: CGFloat = 56
}

enum EgytaleRadius {
    static let sm: CGFloat = 10
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let full: CGFloat = 100
}
