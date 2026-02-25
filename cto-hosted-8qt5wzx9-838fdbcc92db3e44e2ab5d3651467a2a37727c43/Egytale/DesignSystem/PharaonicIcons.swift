import SwiftUI

enum PharaonicIcons {
    static let ankh = Image(systemName: "cross.circle.fill")
    static let scarab = Image(systemName: "shield.lefthalf.filled")
    static let lotus = Image(systemName: "leaf.fill")
    static let pyramid = Image(systemName: "triangle.fill")
    static let eye = Image(systemName: "eye.fill")
    static let sun = Image(systemName: "sun.max.fill")
    static let star = Image(systemName: "star.fill")
    static let scroll = Image(systemName: "scroll.fill")
    static let crown = Image(systemName: "crown.fill")
    static let certification = Image(systemName: "checkmark.seal.fill")
    static let marketplace = Image(systemName: "storefront.fill")
}

struct PyramidShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct TriplePyramidView: View {
    var size: CGFloat = 80
    var animated: Bool = false
    @State private var shimmerOffset: CGFloat = -1.0

    var body: some View {
        ZStack {
            PyramidShape()
                .fill(LinearGradient(
                    colors: [Color.goldLight.opacity(0.4), Color.goldAccent.opacity(0.2)],
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .frame(width: size * 0.55, height: size * 0.42)
                .offset(x: -size * 0.30, y: size * 0.18)

            PyramidShape()
                .fill(LinearGradient(
                    colors: [Color.goldLight.opacity(0.35), Color.goldAccent.opacity(0.18)],
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .frame(width: size * 0.48, height: size * 0.36)
                .offset(x: size * 0.30, y: size * 0.22)

            PyramidShape()
                .fill(.pharaonicGold)
                .frame(width: size * 0.72, height: size * 0.58)
                .overlay(
                    PyramidShape()
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.35), Color.clear],
                                startPoint: .init(x: 0.3 + shimmerOffset * 0.5, y: 0),
                                endPoint: .init(x: 0.7 + shimmerOffset * 0.5, y: 1)
                            )
                        )
                        .frame(width: size * 0.72, height: size * 0.58)
                )
                .shadow(color: Color.goldAccent.opacity(0.45), radius: 20, x: 0, y: 8)

            Rectangle()
                .fill(LinearGradient(
                    colors: [Color.goldAccent.opacity(0.60), Color.goldAccent.opacity(0.20)],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .frame(width: size * 0.95, height: 2.5)
                .offset(y: size * 0.37)
                .blur(radius: 1)
        }
        .frame(width: size, height: size)
        .onAppear {
            if animated {
                withAnimation(
                    .easeInOut(duration: 2.8)
                    .repeatForever(autoreverses: true)
                ) {
                    shimmerOffset = 1.0
                }
            }
        }
    }
}

struct AnkhView: View {
    var size: CGFloat = 56
    var color: Color = .goldAccent

    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: size * 0.10)
                .frame(width: size * 0.44, height: size * 0.44)
                .offset(y: -size * 0.24)

            Rectangle()
                .fill(color)
                .frame(width: size * 0.10, height: size * 0.65)
                .offset(y: size * 0.06)

            Rectangle()
                .fill(color)
                .frame(width: size * 0.52, height: size * 0.10)
                .offset(y: -size * 0.06)
        }
        .frame(width: size, height: size)
    }
}

struct LotusView: View {
    var size: CGFloat = 60
    var color: Color = .goldAccent

    var body: some View {
        ZStack {
            ForEach(0..<5) { index in
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [color.opacity(0.80), color.opacity(0.35)],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(width: size * 0.18, height: size * 0.55)
                    .offset(y: -size * 0.15)
                    .rotationEffect(.degrees(Double(index - 2) * 22.0))
            }

            Capsule()
                .fill(
                    LinearGradient(
                        colors: [color, color.opacity(0.60)],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .frame(width: size * 0.14, height: size * 0.65)
                .offset(y: -size * 0.10)
                .shadow(color: color.opacity(0.35), radius: 8, x: 0, y: -4)

            Rectangle()
                .fill(color.opacity(0.70))
                .frame(width: size * 0.14, height: size * 0.28)
                .offset(y: size * 0.30)

            Capsule()
                .fill(color.opacity(0.45))
                .frame(width: size * 0.40, height: size * 0.12)
                .offset(y: size * 0.40)
        }
        .frame(width: size, height: size)
    }
}

struct ScarabView: View {
    var size: CGFloat = 60
    var color: Color = .goldAccent

    var body: some View {
        ZStack {
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [color.opacity(0.90), color.opacity(0.50)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.55, height: size * 0.62)

            ForEach(0..<3) { index in
                Capsule()
                    .fill(color.opacity(0.55))
                    .frame(width: size * 0.08, height: size * 0.35)
                    .rotationEffect(.degrees(Double(index - 1) * 28.0 - 90))
                    .offset(x: CGFloat(index - 1) * size * 0.18, y: -size * 0.24)
            }

            ForEach(0..<3) { index in
                Capsule()
                    .fill(color.opacity(0.55))
                    .frame(width: size * 0.08, height: size * 0.35)
                    .rotationEffect(.degrees(Double(index - 1) * 28.0 + 90))
                    .offset(x: CGFloat(index - 1) * size * 0.18, y: size * 0.24)
            }

            Circle()
                .fill(
                    LinearGradient(
                        colors: [color, color.opacity(0.65)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.28, height: size * 0.28)
                .shadow(color: color.opacity(0.40), radius: 10, x: 0, y: 4)
        }
        .frame(width: size, height: size)
    }
}

struct EyeOfHorusView: View {
    var size: CGFloat = 60
    var color: Color = .goldAccent

    var body: some View {
        ZStack {
            Ellipse()
                .stroke(color, lineWidth: size * 0.06)
                .frame(width: size * 0.72, height: size * 0.38)

            Circle()
                .fill(color)
                .frame(width: size * 0.22, height: size * 0.22)

            Circle()
                .fill(Color.darkChocolate.opacity(0.75))
                .frame(width: size * 0.10, height: size * 0.10)

            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: size * 0.18, y: size * 0.22))
                path.addLine(to: CGPoint(x: size * 0.06, y: size * 0.22))
            }
            .stroke(color, lineWidth: size * 0.055)
            .offset(x: size * 0.04, y: size * 0.14)

            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addCurve(
                    to: CGPoint(x: size * 0.20, y: 0),
                    control1: CGPoint(x: size * 0.05, y: size * 0.20),
                    control2: CGPoint(x: size * 0.15, y: size * 0.20)
                )
            }
            .stroke(color, lineWidth: size * 0.055)
            .offset(x: -size * 0.10, y: size * 0.14)
        }
        .frame(width: size, height: size)
    }
}
