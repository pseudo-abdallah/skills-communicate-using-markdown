import SwiftUI

struct PageIndicator: View {
    let totalPages: Int
    let currentPage: Int
    let onTap: (Int) -> Void

    var body: some View {
        HStack(spacing: EgytaleSpacing.sm) {
            ForEach(0..<totalPages, id: \.self) { index in
                Button {
                    onTap(index)
                } label: {
                    indicatorDot(for: index)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Go to slide \(index + 1)")
            }
        }
        .padding(.horizontal, EgytaleSpacing.md)
        .padding(.vertical, 10)
        .background(
            Capsule()
                .fill(.ultraThinMaterial)
                .overlay(Capsule().fill(Color.camel.opacity(0.08)))
                .overlay(
                    Capsule()
                        .strokeBorder(Color.goldAccent.opacity(0.22), lineWidth: 0.7)
                )
        )
        .shadow(color: Color.darkChocolate.opacity(0.07), radius: 10, x: 0, y: 4)
        .animation(AnimationConstants.pageIndicator, value: currentPage)
    }

    @ViewBuilder
    private func indicatorDot(for index: Int) -> some View {
        let isActive = index == currentPage
        let isPast = index < currentPage

        ZStack {
            if isActive {
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.goldLight, Color.goldAccent],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 28, height: 7)
                    .shadow(color: Color.goldAccent.opacity(0.45), radius: 6, x: 0, y: 2)
            } else {
                Circle()
                    .fill(isPast ? Color.camel.opacity(0.55) : Color.camel.opacity(0.22))
                    .frame(width: 7, height: 7)
                    .overlay(
                        Circle()
                            .strokeBorder(
                                isPast ? Color.goldAccent.opacity(0.40) : Color.clear,
                                lineWidth: 0.8
                            )
                    )
            }
        }
        .animation(AnimationConstants.pageIndicator, value: isActive)
    }
}

struct ProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(Color.camel.opacity(0.18))
                    .frame(height: 2.5)

                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.goldLight, Color.goldAccent],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * CGFloat(progress), height: 2.5)
                    .shadow(color: Color.goldAccent.opacity(0.40), radius: 4, x: 0, y: 1)
                    .animation(AnimationConstants.slideTransition, value: progress)
            }
        }
        .frame(height: 2.5)
    }
}
