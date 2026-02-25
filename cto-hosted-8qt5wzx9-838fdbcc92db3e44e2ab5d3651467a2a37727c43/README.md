# Egytale — Pharaonic Marketplace iOS App

A premium SwiftUI iOS app for authentic Pharaonic / ancient Egyptian products, featuring an elegant onboarding flow designed for iPhone 15 Pro.

---

## Onboarding Flow

### 1. Splash Screen (`SplashScreenView`)
- **Duration:** ~3s animated reveal, then auto-transitions
- **Design:** Dark chocolate background (`#3D2317`) with subtle hieroglyphic pattern overlay
- **Logo:** Glass-bordered circle containing a triple-pyramid composition with gold shimmer
- **Wordmark:** "EGYTALE" — character-by-character reveal with staggered fade + rise
- **Divider:** Animated gold diamond dividers flanking a gradient horizontal rule
- **Tagline:** "Discover Authentic Pharaonic Heritage" with tracking spacing, fades in last
- **Particles:** Floating sand/gold particles in background for depth

### 2. Onboarding Slides (`OnboardingContainerView` + `OnboardingSlideView`)
Three horizontal swipeable slides with parallax effect, drag gesture with edge resistance, and full accessibility support.

| # | Badge | Title | Icon | Theme |
|---|-------|-------|------|-------|
| 1 | AUTHENTIC TREASURES | Where Heritage Meets Home | Triple Pyramid | Gold gradient |
| 2 | TRUSTED EXPERTS | Verified by Archaeologists | Eye of Horus | Cocoa accent |
| 3 | CURATED MARKETPLACE | Handpicked for Connoisseurs | Lotus | Warm sand |

**Each slide includes:**
- Circular glass frame containing the custom Pharaonic icon
- Glassmorphism card (`.ultraThinMaterial` + camel tint + gold stroke)
- Staggered entrance animations (icon → card → badge → title → description)
- Floating icon animation with gentle rotation
- Feature pills showing key value points
- Background radial gradient shifts per slide

### 3. Authentication Entry (`AuthEntryView`)
Slides up from the bottom on the last slide CTA. Features:
- **Primary CTA:** "Create Free Account" — solid gold gradient button
- **Social auth:** Apple + Google glass buttons
- **Secondary:** "Sign In to Your Account" ghost button
- **Tertiary:** "Continue as Guest" minimal text link

---

## Design System

### Color Palette
| Token | Hex | Usage |
|-------|-----|-------|
| `warmSand` | `#E6DCC4` | Cards, surfaces |
| `beige` | `#F5F0E6` | Background tints |
| `camel` | `#C9A86C` | Secondary accents |
| `cocoa` | `#6B4423` | Body text, secondary |
| `darkChocolate` | `#3D2817` | Primary text, splash BG |
| `goldAccent` | `#D4AF37` | CTAs, highlights |
| `goldLight` | `#EDD48B` | Gradient starts |
| `primaryBackground` | `#F8F4EC` | Screen background |

### Typography
| Style | Font | Size | Weight |
|-------|------|------|--------|
| `displayTitle` | New York (Serif) | 34pt | Bold |
| `slideTitle` | New York (Serif) | 28pt | Bold |
| `sectionTitle` | New York (Serif) | 22pt | Semibold |
| `wordmarkLarge` | Serif | 38pt | Bold |
| `body` | SF Pro | 17pt | Regular |
| `callout` | SF Pro | 15pt | Regular |
| `buttonPrimary` | SF Pro | 17pt | Semibold |

### Glassmorphism
Applied via `GlassmorphismModifier.swift`:
- `.glassCard(cornerRadius:strokeOpacity:tintOpacity:)` — for content cards
- `.glassButton(style:isPressed:)` — for `.primary`, `.secondary`, `.ghost` buttons
- Uses `.ultraThinMaterial` / `.thinMaterial` with camel/gold tint overlays
- Gold gradient stroke borders (`GlassButtonStyle.strokeGradient`)

---

## Architecture

```
Egytale/
├── App/
│   └── EgytaleApp.swift          # App entry, @AppStorage onboarding flag, RootView
├── DesignSystem/
│   ├── Colors.swift              # Color tokens + gradient ShapeStyles
│   ├── Fonts.swift               # EgytaleFonts, EgytaleSpacing, EgytaleRadius
│   ├── GlassmorphismModifier.swift  # GlassCard, GlassButton ViewModifiers
│   └── PharaonicIcons.swift      # Custom vector icons: Pyramid, Ankh, Lotus, Scarab, EyeOfHorus
├── Features/
│   └── Onboarding/
│       ├── Models/
│       │   └── OnboardingSlideModel.swift   # Slide data + static content
│       ├── ViewModels/
│       │   └── OnboardingViewModel.swift    # @MainActor ObservableObject, swipe logic
│       └── Views/
│           ├── SplashScreenView.swift       # Animated splash + particle BG
│           ├── OnboardingContainerView.swift  # Slide pager + bottom CTA
│           ├── OnboardingSlideView.swift    # Individual slide layout
│           ├── PageIndicator.swift          # Animated pill + dot indicators
│           ├── AuthEntryView.swift          # Bottom-sheet auth entry
│           ├── BackgroundGradientView.swift # Per-slide animated backgrounds
│           ├── ParticleEmitterView.swift    # Sand particle system
│           └── PharaonicPatternView.swift   # Hieroglyphic/geometric/lotus patterns
└── Utils/
    ├── AnimationConstants.swift   # All animation presets
    └── HapticManager.swift        # UIImpactFeedbackGenerator wrappers
```

### State Management
- `@AppStorage("hasCompletedOnboarding")` — persists onboarding completion across launches
- `OnboardingViewModel` — `@MainActor ObservableObject` for current slide, drag offset, animation lock
- Views use `@State` for local animation states (entrance/exit), `@Environment` for accessibility

---

## Requirements

- **iOS:** 17.0+
- **Xcode:** 15.0+
- **Swift:** 5.9+
- **Target Device:** iPhone 15 Pro (Dynamic Island, ProMotion 120Hz)
- No external dependencies

---

## Key Technical Details

### Dynamic Island Awareness
Content uses `UIWindowScene.safeAreaInsets.top` for dynamic top padding (59pt on iPhone 15 Pro).

### ProMotion Performance
- `.drawingGroup()` on complex glassmorphism cards for GPU rasterization
- Particle system capped at 22 particles for smooth 120fps
- `.interactiveSpring(response: 0.25)` for drag gesture responsiveness

### Accessibility
- `@Environment(\.accessibilityReduceMotion)` — replaces spring/parallax with simple ease
- All buttons have `.accessibilityLabel` strings
- Minimum touch target 44×44pt throughout
- Gold text on dark chocolate background meets WCAG AA (contrast ratio ~5.8:1)

### Localization
- All user-facing strings are in English; structure prepared for Arabic (RTL)
- `Text()` strings can be wrapped with `LocalizedStringKey` for i18n

### Haptics
| Interaction | Haptic Type |
|-------------|-------------|
| Slide page change | `.selection` |
| CTA button press | `.medium` |
| Navigation tap | `.light` |
| Auth sheet open | `.success` (rigid notification) |
| Guest browse | `.soft` |

---

## Getting Started

1. Open `Egytale.xcodeproj` in Xcode 15+
2. Select the **Egytale** scheme
3. Choose iPhone 15 Pro simulator
4. Build & Run (⌘R)

The app launches with the splash screen, auto-transitions to the 3-slide onboarding, then presents the authentication entry. On subsequent launches, `@AppStorage` skips the onboarding and shows `MainPlaceholderView`.
