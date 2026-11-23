import SwiftUI

/// Uşağın qənaət hədəflərini gördüyü ekran - məs. "Velosiped üçün yığıram"
struct SavingsGoalsView: View {
    @EnvironmentObject var store: DataStore
    @State private var yeniHedefAcigdir = false

    var child: ChildProfile? { store.aktivChild() }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            if let child = child {
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: 6) {
                            Text("Qənaət Hədəflərim")
                                .font(.title2.bold())
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Balansın: \(child.balans, specifier: "%.2f") ₼")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .padding(.top, 20)

                        if child.qenaetHedefleri.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "target")
                                    .font(.system(size: 46))
                                    .foregroundColor(AppTheme.primary.opacity(0.4))
                                Text("Hələ heç bir hədəfin yoxdur")
                                    .foregroundColor(AppTheme.textSecondary)
                            }
                            .padding(.top, 40)
                        }

                        ForEach(child.qenaetHedefleri) { goal in
                            SavingsGoalCardView(goal: goal, childId: child.id)
                        }

                        Button {
                            yeniHedefAcigdir = true
                        } label: {
                            Label("Yeni Hədəf Yarat", systemImage: "plus.circle.fill")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .sheet(isPresented: $yeniHedefAcigdir) {
            if let child { AddSavingsGoalView(childId: child.id) }
        }
    }
}

/// Tək bir hədəf üçün böyük, aydın kart - dairəvi progress bar ilə
struct SavingsGoalCardView: View {
    @EnvironmentObject var store: DataStore
    let goal: SavingsGoal
    let childId: UUID

    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .stroke(AppTheme.secondaryBackground, lineWidth: 7)
                    Circle()
                        .trim(from: 0, to: goal.faiz)
                        .stroke(goal.tamamlanib ? AppTheme.success : AppTheme.accent,
                                style: StrokeStyle(lineWidth: 7, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text(goal.emoji)
                        .font(.system(size: 26))
                }
                .frame(width: 64, height: 64)

                VStack(alignment: .leading, spacing: 4) {
                    Text(goal.basliq)
                        .font(.headline)
                        .foregroundColor(AppTheme.textPrimary)
                    Text("\(goal.yigilanMebleg, specifier: "%.1f") ₼ / \(goal.hedefMebleg, specifier: "%.0f") ₼")
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                    Text("Gündə \(goal.gunlukMebleg, specifier: "%.1f") ₼ yığılır")
                        .font(.caption2)
                        .foregroundColor(AppTheme.textSecondary)
                }
                Spacer()
            }

            if goal.tamamlanib {
                Label("Hədəf tamamlandı! +50 xal bonus", systemImage: "checkmark.seal.fill")
                    .font(.caption.bold())
                    .foregroundColor(AppTheme.success)
                    .frame(maxWidth: .infinity)
            } else {
                Button {
                    store.buGunkuQenaetiEt(childId: childId, goalId: goal.id)
                } label: {
                    Text(store.isBugunEdilib(goal) ? "Bu gün etdin" : "Bu günkü qənaəti et")
                        .font(.subheadline.bold())
                        .foregroundColor(store.isBugunEdilib(goal) ? AppTheme.textSecondary : .white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(store.isBugunEdilib(goal) ? AppTheme.secondaryBackground : AppTheme.primary)
                        .clipShape(Capsule())
                }
                .disabled(store.isBugunEdilib(goal))
            }
        }
        .padding(16)
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppTheme.border, lineWidth: 1))
        .padding(.horizontal)
    }
}
