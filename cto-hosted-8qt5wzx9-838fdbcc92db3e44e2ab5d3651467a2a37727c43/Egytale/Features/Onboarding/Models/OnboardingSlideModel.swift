import SwiftUI

struct OnboardingSlide: Identifiable, Equatable {
    let id: Int
    let iconType: SlideIconType
    let badge: String
    let title: String
    let subtitle: String
    let description: String
    let backgroundAccent: Color
    let gradientColors: [Color]

    enum SlideIconType: Equatable {
        case pyramid
        case scarab
        case ankh
        case lotus
        case eyeOfHorus
    }
}

extension OnboardingSlide {
    static let slides: [OnboardingSlide] = [
        OnboardingSlide(
            id: 0,
            iconType: .pyramid,
            badge: "AUTHENTIC TREASURES",
            title: "Where Heritage\nMeets Home",
            subtitle: "Certified Pharaonic Artistry",
            description: "Every piece in our curated collection carries a certificate of authenticity — sourced directly from master artisans preserving millennia of Egyptian craft.",
            backgroundAccent: Color.goldAccent.opacity(0.12),
            gradientColors: [
                Color(red: 0.831, green: 0.686, blue: 0.216).opacity(0.18),
                Color(red: 0.788, green: 0.659, blue: 0.424).opacity(0.08)
            ]
        ),
        OnboardingSlide(
            id: 1,
            iconType: .eyeOfHorus,
            badge: "TRUSTED EXPERTS",
            title: "Verified by\nArchaeologists",
            subtitle: "Scholar-Authenticated Origins",
            description: "Our expert panel of Egyptologists and cultural historians reviews each listing to ensure provenance, symbolism accuracy, and cultural integrity.",
            backgroundAccent: Color.camel.opacity(0.14),
            gradientColors: [
                Color(red: 0.420, green: 0.267, blue: 0.137).opacity(0.14),
                Color(red: 0.788, green: 0.659, blue: 0.424).opacity(0.07)
            ]
        ),
        OnboardingSlide(
            id: 2,
            iconType: .lotus,
            badge: "CURATED MARKETPLACE",
            title: "Handpicked for\nConnoisseurs",
            subtitle: "Premium Artisan Selection",
            description: "Browse exclusive pieces from over 200 skilled artisans across Egypt — from Luxor stone-carvers to Alexandria jewelers — all in one premium destination.",
            backgroundAccent: Color.warmSand.opacity(0.20),
            gradientColors: [
                Color(red: 0.902, green: 0.863, blue: 0.769).opacity(0.22),
                Color(red: 0.831, green: 0.686, blue: 0.216).opacity(0.10)
            ]
        )
    ]
}
