import SwiftUI

struct MiniCityView: View {
    @EnvironmentObject var store: DataStore
    @State private var marketAcigdir = false
    @State private var carxAcigdir = false
    @State private var canlanma = false
    @State private var oncekiSeviyye: Int? = nil
    @State private var seviyyeKecidiGorunur = false
    @State private var yeniSeviyyeMetni = ""

    var child: ChildProfile? { store.aktivChild() }
    var saat: Int { Calendar.current.component(.hour, from: Date()) }
    var gunduzdurmu: Bool { saat >= 7 && saat < 19 }

    var fonRengleri: [Color] {
        gunduzdurmu
            ? [Color(red: 0.22, green: 0.46, blue: 0.72), Color(red: 0.08, green: 0.22, blue: 0.42)]
            : [Color(red: 0.04, green: 0.06, blue: 0.18), Color(red: 0.01, green: 0.02, blue: 0.10)]
    }

    let parildalar: [CGPoint] = [
        CGPoint(x: 0.08, y: 0.16), CGPoint(x: 0.90, y: 0.14), CGPoint(x: 0.04, y: 0.55),
        CGPoint(x: 0.94, y: 0.50), CGPoint(x: 0.12, y: 0.85), CGPoint(x: 0.86, y: 0.82),
        CGPoint(x: 0.50, y: 0.06), CGPoint(x: 0.30, y: 0.92), CGPoint(x: 0.70, y: 0.90)
    ]

    var body: some View {
        GeometryReader { geo in
            let adaGenislik = geo.size.width * 0.86
            let adaHundurluk = geo.size.height * 0.60

            ZStack {
                // ── FON ──────────────────────────────────────────────────
                LinearGradient(colors: fonRengleri, startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                // Gecə/gündüz arxa gradient
                if !gunduzdurmu {
                    RadialGradient(
                        colors: [Color(red: 0.28, green: 0.14, blue: 0.60).opacity(0.35), .clear],
                        center: .topTrailing, startRadius: 0, endRadius: geo.size.width)
                    .ignoresSafeArea()
                }

                // Üzən parıltılar (ulduzlar)
                ForEach(0..<parildalar.count, id: \.self) { i in
                    Image(systemName: gunduzdurmu ? "sparkle" : "star.fill")
                        .font(.system(size: gunduzdurmu ? 12 : 7))
                        .foregroundColor(gunduzdurmu ? Color.white.opacity(0.5) : Color.yellow.opacity(0.8))
                        .position(x: geo.size.width * parildalar[i].x,
                                  y: geo.size.height * parildalar[i].y)
                        .opacity(canlanma ? 0.95 : 0.20)
                        .scaleEffect(canlanma ? 1.15 : 0.80)
                        .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)
                            .delay(Double(i) * 0.20), value: canlanma)
                }

                // Günəş / Ay
                Text(gunduzdurmu ? "☀️" : "🌙")
                    .font(.system(size: 32))
                    .position(x: geo.size.width * 0.88, y: geo.size.height * 0.09)

                // Buludlar (gündüz)
                if gunduzdurmu {
                    AmbientDrifter(emoji: "☁️", boyukluk: 24, y: 0.05, muddet: 14, geo: geo, canlanma: canlanma)
                    AmbientDrifter(emoji: "☁️", boyukluk: 17, y: 0.11, muddet: 20, geo: geo, canlanma: canlanma)
                    AmbientDrifter(emoji: "🐦", boyukluk: 15, y: 0.17, muddet: 8,  geo: geo, canlanma: canlanma)
                    AmbientDrifter(emoji: "🐦", boyukluk: 12, y: 0.21, muddet: 11, geo: geo, canlanma: canlanma)
                }

                // ── ADA ──────────────────────────────────────────────────
                ZStack {
                    // Əsas zemin - çoxqatlı gradient
                    RoundedRectangle(cornerRadius: 48)
                        .fill(LinearGradient(
                            colors: [Color(red: 0.40, green: 0.78, blue: 0.36),
                                     Color(red: 0.28, green: 0.64, blue: 0.26),
                                     Color(red: 0.22, green: 0.54, blue: 0.22)],
                            startPoint: .topLeading, endPoint: .bottomTrailing))

                    // Torpaq yolu (sinusoidal bezier)
                    Canvas { ctx, size in
                        var road = Path()
                        road.move(to: CGPoint(x: size.width * 0.06, y: size.height * 0.52))
                        road.addCurve(
                            to: CGPoint(x: size.width * 0.94, y: size.height * 0.50),
                            control1: CGPoint(x: size.width * 0.30, y: size.height * 0.24),
                            control2: CGPoint(x: size.width * 0.70, y: size.height * 0.76)
                        )
                        ctx.stroke(road,
                                   with: .color(Color(red: 0.68, green: 0.54, blue: 0.36).opacity(0.60)),
                                   style: StrokeStyle(lineWidth: size.width * 0.085, lineCap: .round))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 48))

                    // Ot tutamları (çəmənlik toxuması)
                    Canvas { ctx, size in
                        let positions: [(Double, Double)] = [
                            (0.14, 0.24), (0.76, 0.21), (0.36, 0.73), (0.82, 0.66),
                            (0.56, 0.14), (0.21, 0.61), (0.68, 0.46), (0.44, 0.44),
                            (0.88, 0.32), (0.10, 0.80), (0.60, 0.80), (0.28, 0.40),
                            (0.50, 0.58), (0.18, 0.46), (0.72, 0.60), (0.38, 0.86)
                        ]
                        for pos in positions {
                            let x = CGFloat(pos.0) * size.width
                            let y = CGFloat(pos.1) * size.height
                            let r = size.width * 0.026
                            var circle = Path()
                            circle.addEllipse(in: CGRect(x: x - r, y: y - r * 0.6,
                                                         width: r * 2, height: r * 1.2))
                            ctx.fill(circle, with: .color(Color(red: 0.26, green: 0.62, blue: 0.22).opacity(0.42)))
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 48))

                    // Üst işıq parlaması
                    LinearGradient(colors: [Color.white.opacity(0.14), .clear],
                                   startPoint: .topLeading, endPoint: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 48))

                    // ── Şəhər əşyaları ──────────────────────────────────
                    if let child, !child.sahibOlduguEsyalar.isEmpty {
                        ForEach(child.sahibOlduguEsyalar, id: \.self) { itemId in
                            if let item = MarketCatalog.tap(itemId),
                               let movqe = child.sehirYerlesimi[itemId] {
                                SehirEsyasi(item: item, movqe: movqe,
                                            adaGenislik: adaGenislik, adaHundurluk: adaHundurluk,
                                            childId: child.id, canlanma: canlanma)
                                .zIndex(movqe.y * 1000)
                            }
                        }

                        if gunduzdurmu, child.sahibOlduguEsyalar.contains(where: {
                            MarketCatalog.tap($0)?.kateqoriya == .tebiet }) {
                            AmbientDrifter(emoji: "🦋", boyukluk: 14, y: 0.55, muddet: 9,
                                           geo: nil, genislik: adaGenislik, hundurluk: adaHundurluk, canlanma: canlanma)
                            .zIndex(2000)
                        }

                        if child.sahibOlduguEsyalar.contains(where: {
                            MarketCatalog.tap($0)?.kateqoriya == .bina }) {
                            AmbientDrifter(emoji: "🚶", boyukluk: 20, y: 0.90, muddet: 12,
                                           geo: nil, genislik: adaGenislik, hundurluk: adaHundurluk, canlanma: canlanma)
                            .zIndex(2000)
                        }
                    } else {
                        VStack(spacing: 10) {
                            Text("🏝️").font(.system(size: 46))
                            Text("Şəhərin hələ boşdur!")
                                .font(.headline).foregroundColor(.white)
                            Text("Marketdən ilk əşyanı al 🎉")
                                .font(.subheadline).foregroundColor(.white.opacity(0.85))
                        }
                    }

                    // Ada kənarı
                    RoundedRectangle(cornerRadius: 48)
                        .stroke(Color.white.opacity(0.28), lineWidth: 2.5)
                }
                .frame(width: adaGenislik, height: adaHundurluk)
                .shadow(color: Color(red: 0.22, green: 0.56, blue: 0.22).opacity(0.40), radius: 28, y: 0)
                .shadow(color: .black.opacity(0.50), radius: 24, y: 22)
                .position(x: geo.size.width / 2, y: geo.size.height * 0.58)

                // ── OYUN HUD ─────────────────────────────────────────────
                VStack(spacing: 10) {
                    // Başlıq + XP
                    HStack {
                        HStack(spacing: 6) {
                            Image(systemName: "building.2.crop.circle.fill")
                                .foregroundColor(.white)
                            Text("Şəhərim")
                                .font(.headline.bold())
                                .foregroundColor(.white)
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                            Text("\(child?.xal ?? 0)")
                                .font(.headline.bold())
                                .foregroundColor(.white)
                            Text("XP")
                                .font(.caption.bold())
                                .foregroundColor(.yellow.opacity(0.85))
                        }
                        .padding(.horizontal, 10).padding(.vertical, 5)
                        .background(Color.black.opacity(0.30))
                        .clipShape(Capsule())
                    }

                    // Səviyyə
                    if let child {
                        HStack(spacing: 10) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(colors: [.spYellow, Color(red: 0.92, green: 0.68, blue: 0.08)],
                                                         startPoint: .top, endPoint: .bottom))
                                    .frame(width: 34, height: 34)
                                    .shadow(color: .spYellow.opacity(0.5), radius: 4)
                                Text("\(CityLevelSystem.seviyye(proqres: child.seherProqresi))")
                                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                                    .foregroundColor(Color(red: 0.55, green: 0.30, blue: 0))
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text(CityLevelSystem.adi(proqres: child.seherProqresi))
                                    .font(.caption.bold())
                                    .foregroundColor(.white)
                                ProgressView(value: CityLevelSystem.faiz(proqres: child.seherProqresi))
                                    .tint(.spYellow)
                                    .scaleEffect(y: 1.3)
                            }
                            Spacer()
                            HStack(spacing: 3) {
                                Text("😊").font(.caption)
                                Text("\(child.xosbextlik)")
                                    .font(.caption.bold())
                                    .foregroundColor(.white)
                            }
                        }
                    }

                    // Düymələr
                    HStack(spacing: 10) {
                        GameHUDButton(label: "Market", icon: "cart.fill",
                                      reng: Color(red: 0.98, green: 0.88, blue: 0.22),
                                      textReng: Color(red: 0.55, green: 0.30, blue: 0)) {
                            marketAcigdir = true
                        }

                        if let child {
                            let cevrilib = store.buGunCevrilibmi(childId: child.id)
                            GameHUDButton(
                                label: cevrilib ? "Fırlanıb" : "Çarx",
                                icon: cevrilib ? "checkmark" : "arrow.triangle.2.circlepath",
                                reng: cevrilib ? Color.white.opacity(0.20) : Color.orange,
                                textReng: .white
                            ) { carxAcigdir = true }
                            .disabled(cevrilib)
                        }
                    }
                }
                .padding(14)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .overlay(RoundedRectangle(cornerRadius: 22).stroke(Color.white.opacity(0.20), lineWidth: 1))
                .padding(.horizontal, 14)
                .padding(.top, 8)
                .frame(maxHeight: .infinity, alignment: .top)

                // ── SƏVIYYƏ KUTLAMASI ────────────────────────────────────
                if seviyyeKecidiGorunur {
                    VStack(spacing: 10) {
                        Text("🎉").font(.system(size: 56))
                        Text("Yeni Səviyyə!")
                            .font(.title2.bold()).foregroundColor(.white)
                        Text(yeniSeviyyeMetni)
                            .font(.headline).foregroundColor(.spYellow)
                    }
                    .padding(28)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                    .overlay(RoundedRectangle(cornerRadius: 28).stroke(Color.spYellow.opacity(0.5), lineWidth: 1.5))
                    .shadow(color: .black.opacity(0.3), radius: 20)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(5000)
                }
            }
        }
        .onAppear {
            canlanma = true
            if let child { oncekiSeviyye = CityLevelSystem.seviyye(proqres: child.seherProqresi) }
        }
        .onChange(of: child?.seherProqresi ?? 0) { (yeniProqres: Int) in
            let yeniSeviyye = CityLevelSystem.seviyye(proqres: yeniProqres)
            if let onceki = oncekiSeviyye, yeniSeviyye > onceki {
                yeniSeviyyeMetni = "Səviyyə \(yeniSeviyye) — \(CityLevelSystem.adi(proqres: yeniProqres))"
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    seviyyeKecidiGorunur = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                    withAnimation { seviyyeKecidiGorunur = false }
                }
            }
            oncekiSeviyye = yeniSeviyye
        }
        .sheet(isPresented: $marketAcigdir) {
            if let child { MarketView(childId: child.id) }
        }
        .sheet(isPresented: $carxAcigdir) {
            if let child { SpinWheelView(childId: child.id) }
        }
    }
}

// MARK: - HUD Düyməsi

private struct GameHUDButton: View {
    let label: String
    let icon: String
    let reng: Color
    let textReng: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon).font(.subheadline.bold())
                Text(label).font(.caption.bold())
            }
            .foregroundColor(textReng)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 11)
            .background(reng)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: reng.opacity(0.45), radius: 5, y: 3)
        }
    }
}

// MARK: - Şəhər əşyası (sürüşdürülə bilən, silinə bilən)

private struct SehirEsyasi: View {
    @EnvironmentObject var store: DataStore
    let item: MarketItem
    let movqe: CityPosition
    let adaGenislik: Double
    let adaHundurluk: Double
    let childId: UUID
    let canlanma: Bool

    @State private var surukleme: CGSize = .zero

    private var gecikme: Double {
        Double(abs(item.id.hashValue) % 100) / 100.0 * 1.2
    }

    var body: some View {
        EsyaSekli(item: item, olcu: 42)
            .shadow(color: .black.opacity(0.28), radius: 4, y: 3)
            .offset(y: canlanma ? -4 : 2)
            .animation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true).delay(gecikme),
                       value: canlanma)
            .position(
                x: adaGenislik * movqe.x + surukleme.width,
                y: adaHundurluk * movqe.y + surukleme.height
            )
            .gesture(
                DragGesture()
                    .onChanged { v in surukleme = v.translation }
                    .onEnded { v in
                        let yeniX = ((adaGenislik * movqe.x + v.translation.width) / adaGenislik)
                            .clamped(0.06...0.94)
                        let yeniY = ((adaHundurluk * movqe.y + v.translation.height) / adaHundurluk)
                            .clamped(0.08...0.92)
                        store.esyaninYeriniYenile(childId: childId, itemId: item.id, x: yeniX, y: yeniY)
                        surukleme = .zero
                    }
            )
            .contextMenu {
                Button(role: .destructive) {
                    store.esyaniSehirdenSil(childId: childId, itemId: item.id)
                } label: {
                    Label("Şəhərdən sil", systemImage: "trash")
                }
            }
    }
}

// MARK: - Ambient hərəkət (bulud, quş, kəpənək, insan)

private struct AmbientDrifter: View {
    let emoji: String
    let boyukluk: CGFloat
    let y: Double
    let muddet: Double
    var geo: GeometryProxy? = nil
    var genislik: Double? = nil
    var hundurluk: Double? = nil
    let canlanma: Bool

    @State private var sagdami = false

    private var en: Double { geo.map { Double($0.size.width) } ?? genislik ?? 300 }
    private var boy: Double { geo.map { Double($0.size.height) } ?? hundurluk ?? 300 }

    var body: some View {
        Text(emoji)
            .font(.system(size: boyukluk))
            .scaleEffect(x: sagdami ? -1 : 1, y: 1)
            .position(x: en * (sagdami ? 0.92 : 0.08), y: boy * y)
            .animation(.linear(duration: muddet).repeatForever(autoreverses: true), value: sagdami)
            .onAppear { if canlanma { sagdami = true } }
            .onChange(of: canlanma) { (yeni: Bool) in if yeni { sagdami = true } }
    }
}

// MARK: - Yardımçı

private extension Double {
    func clamped(_ r: ClosedRange<Double>) -> Double { min(max(self, r.lowerBound), r.upperBound) }
}


