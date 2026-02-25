import SwiftUI

enum PatternStyle {
    case hieroglyphic
    case geometric
    case lotus
}

struct PharaonicPatternView: View {
    let style: PatternStyle

    var body: some View {
        switch style {
        case .hieroglyphic:
            HieroglyphicPattern()
        case .geometric:
            GeometricPattern()
        case .lotus:
            LotusPattern()
        }
    }
}

struct HieroglyphicPattern: View {
    private let symbols = ["𓂀", "𓋹", "𓇋", "𓆣", "𓈖", "𓏏", "𓂋", "𓅓", "𓃭"]
    private let gridSize: Int = 7
    private let cellSize: CGFloat = 52

    var body: some View {
        GeometryReader { geo in
            let cols = Int(geo.size.width / cellSize) + 2
            let rows = Int(geo.size.height / cellSize) + 2

            ForEach(0..<rows, id: \.self) { row in
                ForEach(0..<cols, id: \.self) { col in
                    let index = (row * cols + col) % symbols.count
                    Text(symbols[index])
                        .font(.system(size: 18))
                        .position(
                            x: CGFloat(col) * cellSize + (row % 2 == 0 ? 0 : cellSize * 0.5),
                            y: CGFloat(row) * cellSize * 0.86
                        )
                        .rotationEffect(.degrees(Double((row + col) % 3) * 12 - 12))
                }
            }
        }
        .clipped()
        .allowsHitTesting(false)
    }
}

struct GeometricPattern: View {
    private let tileSize: CGFloat = 44
    private let lineColor = Color.goldAccent

    var body: some View {
        GeometryReader { geo in
            let cols = Int(geo.size.width / tileSize) + 2
            let rows = Int(geo.size.height / tileSize) + 2

            Canvas { context, _ in
                for row in 0..<rows {
                    for col in 0..<cols {
                        let x = CGFloat(col) * tileSize
                        let y = CGFloat(row) * tileSize

                        var outerPath = Path()
                        outerPath.addRect(CGRect(
                            x: x + 3, y: y + 3,
                            width: tileSize - 6, height: tileSize - 6
                        ))
                        context.stroke(
                            outerPath,
                            with: .color(lineColor.opacity(0.60)),
                            lineWidth: 0.5
                        )

                        var innerPath = Path()
                        let inset = tileSize * 0.25
                        innerPath.move(to: CGPoint(x: x + inset, y: y + inset))
                        innerPath.addLine(to: CGPoint(x: x + tileSize - inset, y: y + inset))
                        innerPath.addLine(to: CGPoint(x: x + tileSize - inset, y: y + tileSize - inset))
                        innerPath.addLine(to: CGPoint(x: x + inset, y: y + tileSize - inset))
                        innerPath.closeSubpath()
                        context.stroke(
                            innerPath,
                            with: .color(lineColor.opacity(0.35)),
                            lineWidth: 0.4
                        )

                        let cx = x + tileSize / 2
                        let cy = y + tileSize / 2
                        let halfDiag = tileSize * 0.25

                        var diagonalPath = Path()
                        diagonalPath.move(to: CGPoint(x: cx, y: cy - halfDiag))
                        diagonalPath.addLine(to: CGPoint(x: cx + halfDiag, y: cy))
                        diagonalPath.addLine(to: CGPoint(x: cx, y: cy + halfDiag))
                        diagonalPath.addLine(to: CGPoint(x: cx - halfDiag, y: cy))
                        diagonalPath.closeSubpath()
                        context.stroke(
                            diagonalPath,
                            with: .color(lineColor.opacity(0.50)),
                            lineWidth: 0.45
                        )
                    }
                }
            }
        }
        .clipped()
        .allowsHitTesting(false)
    }
}

struct LotusPattern: View {
    private let spacing: CGFloat = 62

    var body: some View {
        GeometryReader { geo in
            let cols = Int(geo.size.width / spacing) + 2
            let rows = Int(geo.size.height / spacing) + 2

            ForEach(0..<rows, id: \.self) { row in
                ForEach(0..<cols, id: \.self) { col in
                    MiniLotusShape()
                        .stroke(Color.goldAccent, lineWidth: 0.7)
                        .frame(width: 28, height: 28)
                        .position(
                            x: CGFloat(col) * spacing + (row % 2 == 0 ? 0 : spacing * 0.5),
                            y: CGFloat(row) * spacing
                        )
                }
            }
        }
        .clipped()
        .allowsHitTesting(false)
    }
}

struct MiniLotusShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cx = rect.midX
        let cy = rect.midY
        let petalCount = 5

        for i in 0..<petalCount {
            let angle = (Double(i) * (2 * .pi / Double(petalCount))) - .pi / 2
            let petalLength = rect.height * 0.45
            let petalWidth = rect.width * 0.12

            let tipX = cx + cos(angle) * petalLength
            let tipY = cy + sin(angle) * petalLength

            let perpAngle = angle + .pi / 2
            let ctrl1X = cx + cos(perpAngle) * petalWidth + cos(angle) * petalLength * 0.5
            let ctrl1Y = cy + sin(perpAngle) * petalWidth + sin(angle) * petalLength * 0.5
            let ctrl2X = cx - cos(perpAngle) * petalWidth + cos(angle) * petalLength * 0.5
            let ctrl2Y = cy - sin(perpAngle) * petalWidth + sin(angle) * petalLength * 0.5

            path.move(to: CGPoint(x: cx, y: cy))
            path.addCurve(
                to: CGPoint(x: tipX, y: tipY),
                control1: CGPoint(x: ctrl1X, y: ctrl1Y),
                control2: CGPoint(x: ctrl2X, y: ctrl2Y)
            )
        }

        path.addEllipse(in: CGRect(
            x: cx - rect.width * 0.10,
            y: cy - rect.height * 0.10,
            width: rect.width * 0.20,
            height: rect.height * 0.20
        ))
        return path
    }
}
