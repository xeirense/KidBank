import SwiftUI

/// Uşaq kartındakı heyvana basanda açılan, canlı animasiyalı ekran.
struct PetDetailView: View {
    let pet: PetType
    @Environment(\.dismiss) var dismiss

    @State private var peydaOldu = false
    @State private var yellenir = false
    @State private var parildalarGorunur = false

    let parildaMovqeleri: [CGPoint] = [
        CGPoint(x: 0.15, y: 0.25), CGPoint(x: 0.85, y: 0.2), CGPoint(x: 0.1, y: 0.6),
        CGPoint(x: 0.9, y: 0.65), CGPoint(x: 0.5, y: 0.12)
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                AppTheme.background.ignoresSafeArea()

                // Ətrafda parıldayan ulduzcuqlar
                ForEach(0..<parildaMovqeleri.count, id: \.self) { i in
                    Image(systemName: "sparkle")
                        .font(.system(size: 16))
                        .foregroundColor(AppTheme.accent)
                        .position(x: geo.size.width * parildaMovqeleri[i].x,
                                  y: geo.size.height * parildaMovqeleri[i].y)
                        .opacity(parildalarGorunur ? 0.9 : 0.15)
                        .scaleEffect(parildalarGorunur ? 1.1 : 0.7)
                        .animation(
                            .easeInOut(duration: 1.4).repeatForever(autoreverses: true).delay(Double(i) * 0.2),
                            value: parildalarGorunur
                        )
                }

                VStack(spacing: 22) {
                    Spacer()

                    ZStack {
                        Circle()
                            .fill(AppTheme.primaryLight)
                            .frame(width: 220, height: 220)
                            .scaleEffect(peydaOldu ? 1 : 0.3)
                            .opacity(peydaOldu ? 1 : 0)

                        Text(pet.emoji)
                            .font(.system(size: 130))
                            .scaleEffect(peydaOldu ? 1 : 0.1)
                            .rotationEffect(.degrees(peydaOldu ? 0 : -30))
                            .offset(y: yellenir ? -12 : 8)
                    }
                    .animation(.spring(response: 0.6, dampingFraction: 0.55), value: peydaOldu)
                    .animation(
                        .easeInOut(duration: 1.1).repeatForever(autoreverses: true).delay(0.5),
                        value: yellenir
                    )

                    VStack(spacing: 6) {
                        Text(pet.adi)
                            .font(.title.bold())
                            .foregroundColor(AppTheme.textPrimary)
                        Text("Sənin sadiq dostundur!")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .opacity(peydaOldu ? 1 : 0)
                    .animation(.easeIn(duration: 0.4).delay(0.3), value: peydaOldu)

                    Spacer()

                    Button("Bağla") { dismiss() }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 32)
                        .padding(.bottom, 30)
                }
            }
        }
        .onAppear {
            peydaOldu = true
            yellenir = true
            parildalarGorunur = true
        }
    }
}
