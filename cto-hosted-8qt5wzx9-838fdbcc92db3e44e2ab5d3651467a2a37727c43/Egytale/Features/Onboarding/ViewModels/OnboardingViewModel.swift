import SwiftUI
import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var currentSlideIndex: Int = 0
    @Published var dragOffset: CGFloat = 0
    @Published var isAnimating: Bool = false

    let slides = OnboardingSlide.slides

    var isLastSlide: Bool {
        currentSlideIndex == slides.count - 1
    }

    var progress: Double {
        Double(currentSlideIndex) / Double(slides.count - 1)
    }

    func advance() {
        guard !isLastSlide else { return }
        guard !isAnimating else { return }
        isAnimating = true
        HapticManager.selection()
        withAnimation(AnimationConstants.slideTransition) {
            currentSlideIndex += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isAnimating = false
        }
    }

    func goTo(index: Int) {
        guard index != currentSlideIndex,
              index >= 0, index < slides.count else { return }
        guard !isAnimating else { return }
        isAnimating = true
        HapticManager.light()
        withAnimation(AnimationConstants.slideTransition) {
            currentSlideIndex = index
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isAnimating = false
        }
    }

    func handleDragEnd(translation: CGFloat, velocity: CGFloat, screenWidth: CGFloat) {
        let threshold: CGFloat = screenWidth * 0.25
        let velocityThreshold: CGFloat = 600

        if translation < -threshold || velocity < -velocityThreshold {
            if !isLastSlide { advance() }
        } else if translation > threshold || velocity > velocityThreshold {
            if currentSlideIndex > 0 {
                goTo(index: currentSlideIndex - 1)
            }
        }
        withAnimation(AnimationConstants.buttonPress) {
            dragOffset = 0
        }
    }
}
