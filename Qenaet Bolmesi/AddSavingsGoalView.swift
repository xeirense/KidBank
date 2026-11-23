import SwiftUI

/// Uşaq istədiyi hədəfin adını özü yazır - sistem yazılan mətnə görə
/// avtomatik uyğun emoji seçir (SmartEmojiMatcher).
struct AddSavingsGoalView: View {
    @EnvironmentObject var store: DataStore
    @Environment(\.dismiss) var dismiss
    let childId: UUID

    @State private var basliq: String = ""
    @State private var hedefMebleg: Double = 50
    @State private var gunlukMebleg: Double = 2.0
    @State private var prioritet: GoalPriority? = nil

    var canliEmoji: String { SmartEmojiMatcher.tap(basliq) }
    var formDoludur: Bool { !basliq.trimmingCharacters(in: .whitespaces).isEmpty }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 22) {
                    Text(canliEmoji)
                        .font(.system(size: 66))
                        .padding(.top, 16)
                        .animation(.spring(response: 0.35), value: canliEmoji)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nə üçün pul yığmaq istəyirsən?")
                            .font(.subheadline.bold())
                            .foregroundColor(AppTheme.textPrimary)
                        TextField("Məs: Velosiped, PlayStation, Kitab...", text: $basliq)
                            .textFieldStyle(.roundedBorder)
                        Text("Yazan kimi şəkil özü seçilir")
                            .font(.caption2)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Və ya bunlardan seç:")
                            .font(.caption.bold())
                            .foregroundColor(AppTheme.textSecondary)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(SavingsGoalCatalog.sablonlar) { sablon in
                                    Button {
                                        basliq = sablon.basliq
                                        hedefMebleg = sablon.tovsiyeMebleg
                                    } label: {
                                        Text("\(sablon.emoji) \(sablon.basliq)")
                                            .font(.caption.bold())
                                            .padding(.horizontal, 14)
                                            .padding(.vertical, 9)
                                            .background(AppTheme.primaryLight)
                                            .foregroundColor(AppTheme.primary)
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Stepper("Hədəf: \(hedefMebleg, specifier: "%.0f") ₼", value: $hedefMebleg, in: 5...1000, step: 5)
                        Stepper("Gündə: \(gunlukMebleg, specifier: "%.1f") ₼", value: $gunlukMebleg, in: 0.5...50, step: 0.5)

                        let gunSayi = Int(ceil(hedefMebleg / max(gunlukMebleg, 0.1)))
                        Text("Təxminən \(gunSayi) gündə hədəfə çatacaqsan")
                            .font(.caption)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding()
                    .background(AppTheme.secondaryBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bu hədəf sənin üçün nədir? (istəyə bağlı)")
                            .font(.caption.bold())
                            .foregroundColor(AppTheme.textSecondary)
                        HStack(spacing: 8) {
                            ForEach(GoalPriority.allCases, id: \.self) { p in
                                Button {
                                    prioritet = (prioritet == p) ? nil : p
                                } label: {
                                    Text("\(p.emoji) \(p.basliq)")
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(prioritet == p ? AppTheme.primary : AppTheme.primaryLight)
                                        .foregroundColor(prioritet == p ? .white : AppTheme.primary)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        Text("Lazımdır — vacib ehtiyac · İstəyirəm — arzu · Ehtiyat — gözlənilməz hallar üçün")
                            .font(.caption2)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.horizontal)

                    Button("Hədəfi Yarat") {
                        guard formDoludur else { return }
                        store.yeniHedefElaEt(childId: childId, basliq: basliq, emoji: canliEmoji,
                                              hedefMebleg: hedefMebleg, gunlukMebleg: gunlukMebleg,
                                              prioritet: prioritet)
                        dismiss()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(formDoludur ? AppTheme.primary : Color.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .disabled(!formDoludur)
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
            .background(AppTheme.background)
            .navigationTitle("Yeni Hədəf")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Bağla") { dismiss() }
                }
            }
        }
    }
}
