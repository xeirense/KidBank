import SwiftUI

// MARK: - Rəng palitrası

extension Color {
    static let spGreen     = Color(red: 0.22, green: 0.73, blue: 0.30)
    static let spDarkGreen = Color(red: 0.13, green: 0.52, blue: 0.20)
    static let spBrown     = Color(red: 0.55, green: 0.37, blue: 0.18)
    static let spDarkBrown = Color(red: 0.35, green: 0.22, blue: 0.08)
    static let spGray      = Color(red: 0.72, green: 0.74, blue: 0.78)
    static let spYellow    = Color(red: 0.98, green: 0.84, blue: 0.22)
    static let spBlue      = Color(red: 0.28, green: 0.56, blue: 0.92)
}

// MARK: - Əsas dispatcher

struct GameSprite: View {
    let itemId: String
    var olcu: CGFloat = 36

    var body: some View {
        Group {
            switch itemId {
            case "agac1":    TreeSprite(olcu: olcu, crowC: Color.spGreen)
            case "agac2":    FirTreeSprite(olcu: olcu)
            case "gul1":     FlowerSprite(olcu: olcu)
            case "park1":    BenchSprite(olcu: olcu)
            case "palma1":   PalmSprite(olcu: olcu)
            case "kaktus1":  CactusSprite(olcu: olcu)
            case "deniz1":   BeachSprite(olcu: olcu)
            case "ev1":
                HouseSprite(olcu: olcu,
                            wallC: Color(red: 0.98, green: 0.90, blue: 0.72),
                            roofC: Color(red: 0.86, green: 0.28, blue: 0.22))
            case "market1":
                HouseSprite(olcu: olcu,
                            wallC: Color(red: 0.70, green: 0.86, blue: 0.98),
                            roofC: Color(red: 0.22, green: 0.46, blue: 0.78))
            case "kafe1":
                HouseSprite(olcu: olcu,
                            wallC: Color(red: 0.98, green: 0.84, blue: 0.60),
                            roofC: Color(red: 0.72, green: 0.38, blue: 0.12))
            case "xestexana1": HospitalSprite(olcu: olcu)
            case "ev2":        TownHallSprite(olcu: olcu)
            case "kino1":      CinemaSprite(olcu: olcu)
            case "lunapark1":  FerrisWheelSprite(olcu: olcu)
            case "futbol1":    FootballFieldSprite(olcu: olcu)
            case "futbol2":    GoalPostSprite(olcu: olcu)
            case "basketbol1": BasketballSprite(olcu: olcu)
            case "fener1":     LanternSprite(olcu: olcu)
            case "bayraq1":    FlagSprite(olcu: olcu)
            case "heykel1":    FountainSprite(olcu: olcu)
            case "qayiq1":     SailboatSprite(olcu: olcu)
            default:
                Text("?").font(.system(size: olcu * 0.5, weight: .bold))
                    .foregroundColor(Color.white.opacity(0.5))
            }
        }
        .frame(width: olcu, height: olcu)
    }
}

// MARK: - Paylaşılan şəkil

private struct TriangleUp: Shape {
    func path(in r: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: r.midX, y: r.minY))
            p.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
            p.addLine(to: CGPoint(x: r.minX, y: r.maxY))
            p.closeSubpath()
        }
    }
}

// MARK: - Ağac

struct TreeSprite: View {
    var olcu: CGFloat
    var crowC: Color = Color.spGreen

    var body: some View {
        let trunk = olcu * 0.20
        let crownD = olcu * 0.70
        let trunkH = olcu * 0.32
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.10))
                .frame(width: trunk * 1.6, height: trunk * 0.5).offset(y: 1)

            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(colors: [Color.spBrown, Color.spDarkBrown],
                                     startPoint: .leading, endPoint: .trailing))
                .frame(width: trunk, height: trunkH)

            Circle()
                .fill(crowC.opacity(0.55))
                .frame(width: crownD * 0.78, height: crownD * 0.78)
                .offset(x: olcu * 0.1, y: -trunkH * 0.9)

            Circle()
                .fill(LinearGradient(colors: [crowC, crowC.opacity(0.76)],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: crownD, height: crownD)
                .offset(y: -trunkH * 0.72)

            Circle()
                .fill(Color.white.opacity(0.20))
                .frame(width: crownD * 0.36, height: crownD * 0.30)
                .offset(x: -olcu * 0.10, y: -trunkH * 0.72 - crownD * 0.18)
        }
    }
}

// MARK: - Şam ağacı

struct FirTreeSprite: View {
    var olcu: CGFloat

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.spBrown)
                .frame(width: olcu * 0.14, height: olcu * 0.24)

            TriangleUp()
                .fill(LinearGradient(colors: [Color.spDarkGreen, Color(red: 0.18, green: 0.60, blue: 0.24)],
                                     startPoint: .top, endPoint: .bottom))
                .frame(width: olcu * 0.90, height: olcu * 0.44).offset(y: -olcu * 0.17)

            TriangleUp()
                .fill(LinearGradient(colors: [Color.spGreen, Color.spDarkGreen],
                                     startPoint: .top, endPoint: .bottom))
                .frame(width: olcu * 0.68, height: olcu * 0.38).offset(y: -olcu * 0.35)

            TriangleUp()
                .fill(LinearGradient(colors: [Color(red: 0.30, green: 0.80, blue: 0.36), Color.spGreen],
                                     startPoint: .top, endPoint: .bottom))
                .frame(width: olcu * 0.46, height: olcu * 0.30).offset(y: -olcu * 0.54)

            Circle().fill(Color.white.opacity(0.28))
                .frame(width: olcu * 0.10, height: olcu * 0.10)
                .offset(x: -olcu * 0.05, y: -olcu * 0.72)
        }
    }
}

// MARK: - Gül

struct FlowerSprite: View {
    var olcu: CGFloat
    var body: some View {
        let r = olcu * 0.17
        ZStack {
            RoundedRectangle(cornerRadius: 2).fill(Color.spGreen)
                .frame(width: olcu * 0.08, height: olcu * 0.44).offset(y: olcu * 0.14)

            ForEach(0..<5) { i in
                let a = Double(i) * 72.0 * .pi / 180
                Circle()
                    .fill(Color(red: 0.98, green: 0.42, blue: 0.60))
                    .frame(width: r * 1.5, height: r * 1.5)
                    .offset(x: cos(a) * r * 1.4, y: sin(a) * r * 1.4 - olcu * 0.08)
            }

            Circle().fill(Color.spYellow)
                .frame(width: r * 1.3, height: r * 1.3).offset(y: -olcu * 0.08)
        }
    }
}

// MARK: - Park skamyası

struct BenchSprite: View {
    var olcu: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            ForEach([-0.33, -0.11, 0.11, 0.33], id: \.self) { x in
                RoundedRectangle(cornerRadius: 1.5).fill(Color.spDarkBrown)
                    .frame(width: olcu * 0.07, height: olcu * 0.26)
                    .offset(x: olcu * CGFloat(x))
            }
            RoundedRectangle(cornerRadius: 3)
                .fill(LinearGradient(colors: [Color.spBrown, Color.spDarkBrown],
                                     startPoint: .top, endPoint: .bottom))
                .frame(width: olcu * 0.84, height: olcu * 0.17).offset(y: -olcu * 0.26)

            ForEach([-0.30, 0.30], id: \.self) { x in
                RoundedRectangle(cornerRadius: 2).fill(Color.spDarkBrown)
                    .frame(width: olcu * 0.10, height: olcu * 0.44)
                    .offset(x: olcu * CGFloat(x), y: -olcu * 0.22)
            }
            RoundedRectangle(cornerRadius: 3).fill(Color.spBrown)
                .frame(width: olcu * 0.84, height: olcu * 0.12).offset(y: -olcu * 0.52)
        }
    }
}

// MARK: - Palma

struct PalmSprite: View {
    var olcu: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 3)
                .fill(LinearGradient(colors: [Color(red: 0.72, green: 0.56, blue: 0.26), Color.spBrown],
                                     startPoint: .leading, endPoint: .trailing))
                .frame(width: olcu * 0.14, height: olcu * 0.58)
                .offset(x: olcu * 0.06, y: -olcu * 0.10)

            ForEach(0..<4) { i in
                let angle = Double(i) * 50.0 - 75.0
                Ellipse()
                    .fill(LinearGradient(colors: [Color.spGreen, Color.spDarkGreen],
                                         startPoint: .leading, endPoint: .trailing))
                    .frame(width: olcu * 0.50, height: olcu * 0.14)
                    .rotationEffect(.degrees(angle))
                    .offset(x: olcu * 0.06, y: -olcu * 0.56)
            }

            ForEach([CGPoint(x: -0.04, y: -0.44), CGPoint(x: 0.12, y: -0.42)], id: \.x) { p in
                Circle()
                    .fill(Color(red: 0.55, green: 0.38, blue: 0.12))
                    .frame(width: olcu * 0.14, height: olcu * 0.14)
                    .offset(x: olcu * p.x, y: olcu * p.y)
            }
        }
    }
}

// MARK: - Kaktus

struct CactusSprite: View {
    var olcu: CGFloat
    var body: some View {
        let gc = Color(red: 0.28, green: 0.68, blue: 0.34)
        let gd = Color(red: 0.18, green: 0.50, blue: 0.24)
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.10))
                .frame(width: olcu * 0.46, height: olcu * 0.09).offset(y: 1)

            RoundedRectangle(cornerRadius: olcu * 0.14)
                .fill(LinearGradient(colors: [gc, gd], startPoint: .leading, endPoint: .trailing))
                .frame(width: olcu * 0.30, height: olcu * 0.72)

            RoundedRectangle(cornerRadius: olcu * 0.10)
                .fill(LinearGradient(colors: [gc, gd], startPoint: .top, endPoint: .bottom))
                .frame(width: olcu * 0.18, height: olcu * 0.32)
                .offset(x: -olcu * 0.22, y: -olcu * 0.26)

            RoundedRectangle(cornerRadius: olcu * 0.10)
                .fill(LinearGradient(colors: [gc, gd], startPoint: .top, endPoint: .bottom))
                .frame(width: olcu * 0.18, height: olcu * 0.26)
                .offset(x: olcu * 0.22, y: -olcu * 0.32)
        }
    }
}

// MARK: - Çimərlik

struct BeachSprite: View {
    var olcu: CGFloat
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: olcu * 0.2)
                .fill(LinearGradient(
                    colors: [Color(red: 0.28, green: 0.68, blue: 0.92), Color(red: 0.18, green: 0.52, blue: 0.78)],
                    startPoint: .topLeading, endPoint: .bottomTrailing))

            Circle()
                .fill(Color(red: 0.96, green: 0.88, blue: 0.64))
                .frame(width: olcu * 0.58, height: olcu * 0.52)
                .offset(x: olcu * 0.10, y: olcu * 0.10)

            ForEach([0.0, 0.1], id: \.self) { off in
                Capsule().fill(Color.white.opacity(0.30))
                    .frame(width: olcu * 0.38, height: olcu * 0.05)
                    .offset(x: -olcu * 0.14, y: olcu * CGFloat(off) - olcu * 0.16)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: olcu * 0.2))
    }
}

// MARK: - Ev

struct HouseSprite: View {
    var olcu: CGFloat
    var wallC: Color
    var roofC: Color

    var body: some View {
        let bW = olcu * 0.78
        let bH = olcu * 0.48
        let roofH = olcu * 0.36
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.13))
                .frame(width: bW * 0.88, height: bH * 0.14).offset(y: 1.5)

            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(colors: [wallC, wallC.opacity(0.82)],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: bW, height: bH)

            HStack(spacing: olcu * 0.14) {
                ForEach(0..<2) { _ in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.60, green: 0.84, blue: 0.96))
                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white.opacity(0.55), lineWidth: 1))
                        .frame(width: olcu * 0.16, height: olcu * 0.16)
                }
            }
            .offset(y: -bH * 0.25)

            RoundedRectangle(cornerRadius: 3).fill(Color.spDarkBrown.opacity(0.80))
                .frame(width: olcu * 0.18, height: olcu * 0.24)

            TriangleUp()
                .fill(LinearGradient(colors: [roofC.opacity(0.90), roofC],
                                     startPoint: .top, endPoint: .bottom))
                .frame(width: bW + olcu * 0.08, height: roofH)
                .offset(y: -(bH + roofH) / 2 + 2)

            RoundedRectangle(cornerRadius: 2).fill(Color.spGray)
                .frame(width: olcu * 0.10, height: olcu * 0.14)
                .offset(x: olcu * 0.17, y: -(bH + roofH) / 2 + olcu * 0.08)
        }
    }
}

// MARK: - Xəstəxana

struct HospitalSprite: View {
    var olcu: CGFloat
    var body: some View {
        let bW = olcu * 0.84, bH = olcu * 0.60
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.12))
                .frame(width: bW * 0.88, height: bH * 0.12).offset(y: 1.5)

            RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(
                    colors: [Color(red: 0.96, green: 0.98, blue: 1.0), Color(red: 0.88, green: 0.92, blue: 0.96)],
                    startPoint: .top, endPoint: .bottom))
                .frame(width: bW, height: bH)

            Rectangle()
                .fill(Color(red: 0.88, green: 0.22, blue: 0.22))
                .frame(width: bW, height: olcu * 0.14)
                .offset(y: -(bH / 2 - olcu * 0.07))

            ZStack {
                RoundedRectangle(cornerRadius: 1.5).fill(Color.white)
                    .frame(width: olcu * 0.26, height: olcu * 0.07)
                ForEach([-1, 1], id: \.self) { s in
                    RoundedRectangle(cornerRadius: 1.5).fill(Color.white)
                        .frame(width: olcu * 0.07, height: olcu * 0.17)
                        .offset(x: CGFloat(s) * olcu * 0.095)
                }
            }
            .offset(y: -(bH / 2 - olcu * 0.07))

            HStack(spacing: olcu * 0.10) {
                ForEach(0..<3) { _ in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.60, green: 0.84, blue: 0.96))
                        .frame(width: olcu * 0.14, height: olcu * 0.14)
                }
            }
            .offset(y: -olcu * 0.10)

            RoundedRectangle(cornerRadius: 3)
                .fill(Color(red: 0.60, green: 0.80, blue: 0.60))
                .frame(width: olcu * 0.22, height: olcu * 0.26)
        }
    }
}

// MARK: - Bələdiyyə Binası

struct TownHallSprite: View {
    var olcu: CGFloat
    var body: some View {
        let bW = olcu * 0.88, bH = olcu * 0.54
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.12))
                .frame(width: bW * 0.88, height: bH * 0.12).offset(y: 1.5)

            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(
                    colors: [Color(red: 0.86, green: 0.84, blue: 0.78), Color(red: 0.72, green: 0.70, blue: 0.64)],
                    startPoint: .top, endPoint: .bottom))
                .frame(width: bW, height: bH)

            HStack(spacing: olcu * 0.12) {
                ForEach(0..<3) { _ in
                    RoundedRectangle(cornerRadius: 2).fill(Color.white.opacity(0.70))
                        .frame(width: olcu * 0.07, height: bH * 0.70)
                }
            }
            .offset(y: -bH * 0.10)

            TriangleUp()
                .fill(Color(red: 0.80, green: 0.78, blue: 0.72))
                .frame(width: bW * 0.70, height: olcu * 0.17).offset(y: -bH * 0.70)

            Circle()
                .fill(LinearGradient(
                    colors: [Color(red: 0.72, green: 0.78, blue: 0.86), Color(red: 0.52, green: 0.58, blue: 0.70)],
                    startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: olcu * 0.24, height: olcu * 0.24)
                .offset(y: -(bH * 0.70 + olcu * 0.14))

            RoundedRectangle(cornerRadius: 4).fill(Color.spDarkBrown.opacity(0.75))
                .frame(width: olcu * 0.20, height: olcu * 0.28)
        }
    }
}

// MARK: - Kinoteatr

struct CinemaSprite: View {
    var olcu: CGFloat
    var body: some View {
        let bW = olcu * 0.88, bH = olcu * 0.60
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.12))
                .frame(width: bW * 0.88, height: bH * 0.12).offset(y: 1.5)

            RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(
                    colors: [Color(red: 0.18, green: 0.20, blue: 0.30), Color(red: 0.12, green: 0.14, blue: 0.22)],
                    startPoint: .top, endPoint: .bottom))
                .frame(width: bW, height: bH)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color(red: 0.98, green: 0.26, blue: 0.52))
                .frame(width: bW * 0.70, height: olcu * 0.14).offset(y: -bH * 0.46)
                .shadow(color: Color(red: 0.98, green: 0.26, blue: 0.52).opacity(0.80), radius: 6)

            HStack(spacing: olcu * 0.07) {
                ForEach([Color.red, Color.yellow, Color.green, Color.blue, Color.purple], id: \.self) { c in
                    Circle().fill(c).frame(width: olcu * 0.07, height: olcu * 0.07)
                }
            }
            .offset(y: -bH * 0.28)

            RoundedRectangle(cornerRadius: 3)
                .fill(Color(red: 0.98, green: 0.84, blue: 0.22))
                .frame(width: olcu * 0.26, height: olcu * 0.30)
        }
    }
}

// MARK: - Fırlanan çarx

struct FerrisWheelSprite: View {
    var olcu: CGFloat
    var body: some View {
        let purple = Color(red: 0.68, green: 0.26, blue: 0.78)
        ZStack(alignment: .bottom) {
            ForEach([-1, 1], id: \.self) { side in
                RoundedRectangle(cornerRadius: 2).fill(purple)
                    .frame(width: olcu * 0.10, height: olcu * 0.38)
                    .rotationEffect(.degrees(Double(side) * 14))
                    .offset(x: olcu * 0.26 * CGFloat(side), y: -olcu * 0.12)
            }
            ForEach(0..<4) { i in
                Rectangle().fill(purple.opacity(0.70))
                    .frame(width: olcu * 0.03, height: olcu * 0.70)
                    .rotationEffect(.degrees(Double(i) * 45))
                    .offset(y: -olcu * 0.26)
            }
            Circle().stroke(purple, lineWidth: olcu * 0.07)
                .frame(width: olcu * 0.70, height: olcu * 0.70).offset(y: -olcu * 0.26)

            ForEach(0..<4) { i in
                let a = Double(i) * 90.0 * .pi / 180
                let r = olcu * 0.32
                Circle()
                    .fill([Color.red, Color.yellow, Color.green, Color.blue][i])
                    .frame(width: olcu * 0.14, height: olcu * 0.14)
                    .offset(x: cos(a) * r, y: sin(a) * r - olcu * 0.26)
            }
            Circle().fill(Color.spYellow)
                .frame(width: olcu * 0.16, height: olcu * 0.16).offset(y: -olcu * 0.26)
        }
    }
}

// MARK: - Futbol meydançası

struct FootballFieldSprite: View {
    var olcu: CGFloat
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(
                    colors: [Color(red: 0.22, green: 0.66, blue: 0.28), Color(red: 0.18, green: 0.56, blue: 0.22)],
                    startPoint: .top, endPoint: .bottom))
                .frame(width: olcu * 0.94, height: olcu * 0.72)

            RoundedRectangle(cornerRadius: 1).stroke(Color.white.opacity(0.70), lineWidth: 1)
                .frame(width: olcu * 0.84, height: olcu * 0.62)
            Rectangle().fill(Color.white.opacity(0.70)).frame(width: 1, height: olcu * 0.62)
            Circle().stroke(Color.white.opacity(0.70), lineWidth: 1)
                .frame(width: olcu * 0.24, height: olcu * 0.24)

            ForEach([-1, 1], id: \.self) { side in
                Rectangle().stroke(Color.white.opacity(0.70), lineWidth: 1)
                    .frame(width: olcu * 0.14, height: olcu * 0.32)
                    .offset(x: CGFloat(side) * olcu * 0.39)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

// MARK: - Futbol qapısı

struct GoalPostSprite: View {
    var olcu: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 2).fill(Color.white.opacity(0.12))
                .frame(width: olcu * 0.76, height: olcu * 0.50).offset(y: -olcu * 0.26)

            ForEach([-1, 1], id: \.self) { side in
                RoundedRectangle(cornerRadius: 2).fill(Color.white)
                    .frame(width: olcu * 0.07, height: olcu * 0.50)
                    .offset(x: CGFloat(side) * olcu * 0.345, y: -olcu * 0.26)
                    .shadow(color: Color.white.opacity(0.4), radius: 2)
            }
            RoundedRectangle(cornerRadius: 2).fill(Color.white)
                .frame(width: olcu * 0.76, height: olcu * 0.07).offset(y: -olcu * 0.49)
                .shadow(color: Color.white.opacity(0.4), radius: 3)

            VStack(spacing: olcu * 0.10) {
                ForEach(0..<3) { _ in
                    Rectangle().fill(Color.white.opacity(0.22))
                        .frame(width: olcu * 0.72, height: 0.5)
                }
            }
            .offset(y: -olcu * 0.26)

            RoundedRectangle(cornerRadius: 1)
                .fill(Color(red: 0.22, green: 0.66, blue: 0.28))
                .frame(width: olcu * 0.84, height: olcu * 0.10)
        }
    }
}

// MARK: - Basketbol

struct BasketballSprite: View {
    var olcu: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color(red: 0.86, green: 0.56, blue: 0.22))
                .frame(width: olcu * 0.90, height: olcu * 0.58)

            RoundedRectangle(cornerRadius: 1).stroke(Color.white.opacity(0.55), lineWidth: 1)
                .frame(width: olcu * 0.80, height: olcu * 0.48)

            Circle().trim(from: 0.0, to: 0.5)
                .stroke(Color.white.opacity(0.55), lineWidth: 1)
                .frame(width: olcu * 0.44, height: olcu * 0.44)
                .rotationEffect(.degrees(180)).offset(y: -olcu * 0.16)

            Rectangle().fill(Color.white.opacity(0.70))
                .frame(width: olcu * 0.24, height: olcu * 0.14).offset(y: -olcu * 0.46)

            Circle().stroke(Color.orange, lineWidth: olcu * 0.055)
                .frame(width: olcu * 0.18, height: olcu * 0.18).offset(y: -olcu * 0.42)
        }
        .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}

// MARK: - Küçə fənəri

struct LanternSprite: View {
    var olcu: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.10))
                .frame(width: olcu * 0.28, height: olcu * 0.07).offset(y: 1)

            RoundedRectangle(cornerRadius: 2)
                .fill(LinearGradient(colors: [Color.spGray, Color(red: 0.55, green: 0.57, blue: 0.60)],
                                     startPoint: .leading, endPoint: .trailing))
                .frame(width: olcu * 0.07, height: olcu * 0.72)

            Circle()
                .fill(Color.spYellow.opacity(0.28))
                .frame(width: olcu * 0.44, height: olcu * 0.44)
                .blur(radius: 5).offset(y: -olcu * 0.60)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color(red: 0.98, green: 0.90, blue: 0.44))
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.spGray, lineWidth: 1.5))
                .frame(width: olcu * 0.26, height: olcu * 0.24).offset(y: -olcu * 0.60)

            Rectangle().fill(Color.spGray)
                .frame(width: olcu * 0.32, height: olcu * 0.05).offset(y: -olcu * 0.72)
        }
    }
}

// MARK: - Rəngli bayraqlar

struct FlagSprite: View {
    var olcu: CGFloat
    let rengler: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    var body: some View {
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.10))
                .frame(width: olcu * 0.46, height: olcu * 0.07).offset(y: 1)

            ForEach([-0.38, 0.38], id: \.self) { x in
                RoundedRectangle(cornerRadius: 1).fill(Color.spGray)
                    .frame(width: olcu * 0.05, height: olcu * 0.72)
                    .offset(x: olcu * CGFloat(x))
            }

            Path { p in
                p.move(to: CGPoint(x: olcu * 0.12, y: 0))
                p.addCurve(to: CGPoint(x: olcu * 0.88, y: 0),
                           control1: CGPoint(x: olcu * 0.32, y: olcu * 0.18),
                           control2: CGPoint(x: olcu * 0.68, y: olcu * 0.08))
            }
            .stroke(Color.spGray, lineWidth: 1)
            .offset(y: -olcu * 0.56)

            HStack(spacing: olcu * 0.05) {
                ForEach(0..<5) { i in
                    FlagTriangleShape()
                        .fill(rengler[i % rengler.count])
                        .frame(width: olcu * 0.14, height: olcu * 0.17)
                        .rotationEffect(.degrees(180))
                }
            }
            .offset(y: -olcu * 0.56)
        }
    }
}

private struct FlagTriangleShape: Shape {
    func path(in r: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: r.midX, y: r.minY))
            p.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
            p.addLine(to: CGPoint(x: r.minX, y: r.maxY))
            p.closeSubpath()
        }
    }
}

// MARK: - Fəvvarə

struct FountainSprite: View {
    var olcu: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            Ellipse().fill(Color.black.opacity(0.12))
                .frame(width: olcu * 0.72, height: olcu * 0.10).offset(y: 1.5)

            Ellipse()
                .fill(LinearGradient(
                    colors: [Color(red: 0.42, green: 0.76, blue: 0.96), Color(red: 0.22, green: 0.56, blue: 0.86)],
                    startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: olcu * 0.84, height: olcu * 0.26)
            Ellipse().stroke(Color.white.opacity(0.50), lineWidth: 1.5)
                .frame(width: olcu * 0.84, height: olcu * 0.26)

            RoundedRectangle(cornerRadius: 3)
                .fill(Color(red: 0.86, green: 0.86, blue: 0.90))
                .frame(width: olcu * 0.14, height: olcu * 0.44).offset(y: -olcu * 0.22)

            Ellipse().fill(Color(red: 0.86, green: 0.86, blue: 0.90))
                .frame(width: olcu * 0.32, height: olcu * 0.10).offset(y: -olcu * 0.42)

            ForEach([CGPoint(x: -0.08, y: -0.60), CGPoint(x: 0, y: -0.68), CGPoint(x: 0.08, y: -0.62)], id: \.x) { p in
                Circle()
                    .fill(Color(red: 0.60, green: 0.86, blue: 0.98))
                    .frame(width: olcu * 0.07, height: olcu * 0.07)
                    .offset(x: olcu * p.x, y: olcu * p.y)
            }
        }
    }
}

// MARK: - Yelkənli qayıq

struct SailboatSprite: View {
    var olcu: CGFloat
    var body: some View {
        ZStack(alignment: .bottom) {
            Ellipse()
                .fill(Color(red: 0.28, green: 0.62, blue: 0.88).opacity(0.55))
                .frame(width: olcu * 0.88, height: olcu * 0.18).offset(y: 1)

            BoatHullShape()
                .fill(LinearGradient(
                    colors: [Color(red: 0.86, green: 0.44, blue: 0.14), Color(red: 0.68, green: 0.30, blue: 0.08)],
                    startPoint: .top, endPoint: .bottom))
                .frame(width: olcu * 0.72, height: olcu * 0.26)

            RoundedRectangle(cornerRadius: 1).fill(Color.spBrown)
                .frame(width: olcu * 0.05, height: olcu * 0.62)
                .offset(x: olcu * 0.02, y: -olcu * 0.44)

            BigSailShape()
                .fill(LinearGradient(colors: [Color.white, Color(red: 0.90, green: 0.92, blue: 0.98)],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: olcu * 0.40, height: olcu * 0.50)
                .offset(x: olcu * 0.12, y: -olcu * 0.56)

            BigSailShape()
                .fill(Color(red: 0.86, green: 0.26, blue: 0.26))
                .frame(width: olcu * 0.20, height: olcu * 0.34)
                .offset(x: -olcu * 0.10, y: -olcu * 0.46)
        }
    }
}

private struct BoatHullShape: Shape {
    func path(in r: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: r.minX + r.width * 0.08, y: r.minY))
            p.addLine(to: CGPoint(x: r.maxX - r.width * 0.08, y: r.minY))
            p.addCurve(to: CGPoint(x: r.minX, y: r.maxY),
                       control1: CGPoint(x: r.maxX, y: r.maxY * 0.5),
                       control2: CGPoint(x: r.maxX * 0.5, y: r.maxY))
            p.addLine(to: CGPoint(x: r.minX + r.width * 0.08, y: r.minY))
        }
    }
}

private struct BigSailShape: Shape {
    func path(in r: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: r.midX, y: r.minY))
            p.addLine(to: CGPoint(x: r.maxX, y: r.maxY))
            p.addLine(to: CGPoint(x: r.minX, y: r.maxY))
            p.addCurve(to: CGPoint(x: r.midX, y: r.minY),
                       control1: CGPoint(x: r.minX + r.width * 0.1, y: r.maxY * 0.4),
                       control2: CGPoint(x: r.minX + r.width * 0.3, y: r.minY + r.height * 0.1))
        }
    }
}
