import SwiftUI

/// Gündə bir dəfə fırlanan bonus çarxı - uşağa əlavə xal qazandırır.
/// Hər seqment mükafatı göstərir, ox göstəricisi qalır, çarx fırlanır.
struct SpinWheelView: View {
    @EnvironmentObject var store: DataStore
    @Environment(\.dismiss) var dismiss
    let childId: UUID

    @State private var firlanmaBucaqi: Double = 0
    @State private var neticeGorsenir = false
    @State private var qazanilanXal = 0
    @State private var firlanirmi = false
    @State private var kutlamaGorunur = false

    // Mükafat siyahısı (görüntü + dəyər cütü)
    let segmentler: [(xal: Int, reng: Color)] = [
        (5,  Color(red: 0.98, green: 0.36, blue: 0.36)),
        (20, Color(red: 0.24, green: 0.44, blue: 0.86)),
        (8,  Color(red: 0.98, green: 0.62, blue: 0.22)),
        (15, Color(red: 0.32, green: 0.74, blue: 0.46)),
        (10, Color(red: 0.74, green: 0.36, blue: 0.86)),
        (12, Color(red: 0.22, green: 0.72, blue: 0.84))
    ]

    var artiqFirlanibmi: Bool { store.buGunCevrilibmi(childId: childId) }

    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.background.ignoresSafeArea()

                VStack(spacing: 28) {
                    Text("🎡 Gündəlik Bonus")
                        .font(.title2.bold())
                        .foregroundColor(AppTheme.textPrimary)
                        .padding(.top, 24)

                    // Çarx + ox
                    ZStack {
                        // Kölgə
                        Circle()
                            .fill(Color.black.opacity(0.08))
                            .frame(width: 266, height: 266)
                            .offset(y: 6)

                        // Çarx
                        WheelShape(segmentler: segmentler)
                            .frame(width: 258, height: 258)
                            .rotationEffect(.degrees(firlanmaBucaqi))
                            .animation(
                                firlanirmi
                                    ? .timingCurve(0.15, 0.85, 0.3, 1.0, duration: 3.2)
                                    : .none,
                                value: firlanmaBucaqi
                            )

                        // Ortadakı ağ dairə
                        Circle()
                            .fill(Color.white)
                            .frame(width: 52, height: 52)
                            .shadow(color: .black.opacity(0.15), radius: 4, y: 2)

                        Image(systemName: "star.fill")
                            .font(.title3.bold())
                            .foregroundColor(AppTheme.accent)

                        // Çarx kənarı
                        Circle()
                            .stroke(Color.white.opacity(0.6), lineWidth: 4)
                            .frame(width: 258, height: 258)

                        // Yuxarıdakı ox göstərici
                        ArrowPointer()
                            .frame(width: 28, height: 36)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 3, y: 2)
                            .offset(y: -142)
                    }
                    .frame(width: 268, height: 268)

                    // Nəticə mesajı
                    if neticeGorsenir {
                        HStack(spacing: 10) {
                            Text("🎉")
                            Text("+\(qazanilanXal) xal qazandın!")
                                .font(.title3.bold())
                                .foregroundColor(AppTheme.success)
                            Text("🎉")
                        }
                        .transition(.asymmetric(
                            insertion: .scale(scale: 0.6).combined(with: .opacity),
                            removal: .opacity
                        ))
                    } else if artiqFirlanibmi {
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(AppTheme.success)
                            Text("Bu gün artıq fırlatdın. Sabah gəl!")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                    } else {
                        Text("Çarxı fırlat, bonus xal qazan!")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                    }

                    Spacer()

                    // Fırlat düyməsi
                    Button {
                        firlat()
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: artiqFirlanibmi ? "checkmark" : "arrow.triangle.2.circlepath")
                            Text(artiqFirlanibmi ? "Sabah gəl" : (firlanirmi ? "Fırlanır..." : "Fırlat!"))
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(buttonReng)
                        .clipShape(Capsule())
                        .shadow(color: buttonReng.opacity(0.4), radius: 8, y: 4)
                    }
                    .disabled(artiqFirlanibmi || firlanirmi)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                }

                // Kutlama konfetti effekti
                if kutlamaGorunur {
                    ConfettiBurst()
                        .allowsHitTesting(false)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Bağla") { dismiss() }
                }
            }
        }
    }

    private var buttonReng: Color {
        if artiqFirlanibmi { return Color.gray.opacity(0.5) }
        if firlanirmi { return AppTheme.primary.opacity(0.6) }
        return Color.orange
    }

    private func firlat() {
        guard !artiqFirlanibmi, !firlanirmi else { return }
        firlanirmi = true
        neticeGorsenir = false

        // Rastgele 5-7 dövrə + ortaya düşmüş seqment mövqeyi
        let dovreCount = Double.random(in: 5...7)
        let ekstraBucaq = Double.random(in: 0..<360)
        withAnimation(.timingCurve(0.15, 0.85, 0.3, 1.0, duration: 3.2)) {
            firlanmaBucaqi += dovreCount * 360 + ekstraBucaq
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
            let netice = store.gunlukCarxiCevir(childId: childId)
            qazanilanXal = netice
            firlanirmi = false
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                neticeGorsenir = true
                kutlamaGorunur = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation { kutlamaGorunur = false }
            }
        }
    }
}

// MARK: - Çarx forması (seqmentlər + etiketlər)

private struct WheelShape: View {
    let segmentler: [(xal: Int, reng: Color)]

    var body: some View {
        let count = segmentler.count
        let parcaBucaq = 360.0 / Double(count)

        ZStack {
            ForEach(0..<count, id: \.self) { i in
                let baslangic = Double(i) * parcaBucaq - 90
                let son = baslangic + parcaBucaq

                // Rəngli seqment
                PieSlice(baslangicDerece: baslangic, sonDerece: son)
                    .fill(segmentler[i].reng)

                // Ayırıcı xətt
                PieSlice(baslangicDerece: baslangic, sonDerece: son)
                    .stroke(Color.white.opacity(0.5), lineWidth: 2)

                // Seqment etiketi
                let ortaDerece = baslangic + parcaBucaq / 2
                let ortaRad = ortaDerece * Double.pi / 180
                let radius = 85.0
                let tx = radius * cos(ortaRad)
                let ty = radius * sin(ortaRad)

                VStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 11))
                        .foregroundColor(.white.opacity(0.9))
                    Text("\(segmentler[i].xal)")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                .shadow(color: .black.opacity(0.3), radius: 2, y: 1)
                .offset(x: tx, y: ty)
            }
        }
    }
}

// MARK: - Pie dilim şəkli

private struct PieSlice: Shape {
    let baslangicDerece: Double
    let sonDerece: Double

    func path(in rect: CGRect) -> Path {
        let merkez = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()
        path.move(to: merkez)
        path.addArc(center: merkez, radius: radius,
                    startAngle: .degrees(baslangicDerece),
                    endAngle: .degrees(sonDerece),
                    clockwise: false)
        path.closeSubpath()
        return path
    }
}

// MARK: - Ox göstəricisi

private struct ArrowPointer: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Sadə konfetti efekti

private struct ConfettiBurst: View {
    let emojiler = ["⭐️", "🎉", "✨", "🌟", "💫"]
    @State private var hissecikler: [ConfettiParticle] = (0..<18).map { _ in ConfettiParticle() }

    var body: some View {
        GeometryReader { geo in
            ForEach(hissecikler) { p in
                Text(p.emoji)
                    .font(.system(size: p.boyukluk))
                    .position(x: p.x * geo.size.width, y: p.y * geo.size.height)
                    .opacity(p.opaslik)
                    .rotationEffect(.degrees(p.don))
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 2.0)) {
                hissecikler = hissecikler.map { p in
                    var n = p
                    n.y = Double.random(in: 0.1...0.9)
                    n.opaslik = 0
                    n.don = Double.random(in: -180...180)
                    return n
                }
            }
        }
    }
}

private struct ConfettiParticle: Identifiable {
    let id = UUID()
    let emoji: String
    let x: Double
    var y: Double
    let boyukluk: CGFloat
    var opaslik: Double
    var don: Double

    init() {
        let emojiler = ["⭐️", "🎉", "✨", "🌟", "💫"]
        emoji = emojiler.randomElement()!
        x = Double.random(in: 0.05...0.95)
        y = Double.random(in: -0.1...0.3)
        boyukluk = CGFloat.random(in: 16...30)
        opaslik = Double.random(in: 0.7...1.0)
        don = Double.random(in: -30...30)
    }
}
