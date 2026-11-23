import SwiftUI

/// Valideyn Panelindən açılan maliyyə bacarıqları hesabatı.
/// Uşağın qənaət davamlılığı, harcama özünü-idarəsi və hədəf tamamlaması göstərilir.
struct FinancialSkillsView: View {
    @EnvironmentObject var store: DataStore

    var child: ChildProfile? { store.aktivChild() }

    var body: some View {
        Group {
            if let child {
                let hesabat = FinancialSkillsEvaluator.hesabla(child: child)
                ScrollView {
                    VStack(spacing: 20) {

                        // Ümumi səviyyə kartı
                        VStack(spacing: 8) {
                            Text(hesabat.seviyye)
                                .font(.title2.bold())
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Ümumi xal: \(hesabat.umumi)%")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                            ProgressView(value: Double(hesabat.umumi) / 100)
                                .tint(AppTheme.accent)
                                .padding(.horizontal)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppTheme.border))
                        .padding(.horizontal)

                        // 3 bacarıq metriki
                        VStack(spacing: 12) {
                            SkillRow(
                                ikon: "calendar.badge.checkmark",
                                basliq: "Qənaət Davamlılığı",
                                aciklama: "Son 14 günün neçəsində qənaət edilib",
                                xal: hesabat.qenaetDavamlilik,
                                reng: AppTheme.primary
                            )
                            Divider()
                            SkillRow(
                                ikon: "cart.badge.minus",
                                basliq: "Harcamanı İdarəetmə",
                                aciklama: "İstəkdən imtina missiyaları",
                                xal: hesabat.harcamaOzuneDarbe,
                                reng: AppTheme.warning
                            )
                            Divider()
                            SkillRow(
                                ikon: "checkmark.seal.fill",
                                basliq: "Hədəf Tamamlama",
                                aciklama: "Tamamlanan qənaət hədəflərinin faizi",
                                xal: hesabat.hedefTamamlama,
                                reng: AppTheme.success
                            )
                        }
                        .padding(20)
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppTheme.border))
                        .padding(.horizontal)

                        // Son maliyyə hadisələri
                        if !child.maliyyeQeydleri.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Son Hadisələr")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)

                                ForEach(child.maliyyeQeydleri.suffix(10).reversed()) { qeyd in
                                    HStack(spacing: 12) {
                                        Image(systemName: qeyd.tip.ikon)
                                            .foregroundColor(qeyd.tip.reng)
                                            .frame(width: 32)
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(qeyd.aciqlama)
                                                .font(.subheadline)
                                                .foregroundColor(AppTheme.textPrimary)
                                            Text(qeyd.tarix.formatted(date: .abbreviated, time: .omitted))
                                                .font(.caption2)
                                                .foregroundColor(AppTheme.textSecondary)
                                        }
                                        Spacer()
                                        if qeyd.mebleg > 0 {
                                            Text("+\(qeyd.mebleg, specifier: "%.1f") ₼")
                                                .font(.caption.bold())
                                                .foregroundColor(AppTheme.success)
                                        } else if qeyd.xal > 0 {
                                            Text("+\(qeyd.xal) xal")
                                                .font(.caption.bold())
                                                .foregroundColor(AppTheme.accent)
                                        }
                                    }
                                }
                            }
                            .padding(20)
                            .background(AppTheme.cardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppTheme.border))
                            .padding(.horizontal)
                        }

                        Spacer().frame(height: 20)
                    }
                    .padding(.top, 16)
                }
                .background(AppTheme.background)
            } else {
                Text("Uşaq tapılmadı")
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
        .navigationTitle("Maliyyə Bacarıqları")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct SkillRow: View {
    let ikon: String
    let basliq: String
    let aciklama: String
    let xal: Int
    let reng: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: ikon)
                    .foregroundColor(reng)
                    .frame(width: 24)
                Text(basliq)
                    .font(.subheadline.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Spacer()
                Text("\(xal)%")
                    .font(.subheadline.bold())
                    .foregroundColor(reng)
            }
            Text(aciklama)
                .font(.caption)
                .foregroundColor(AppTheme.textSecondary)
            ProgressView(value: Double(xal) / 100)
                .tint(reng)
        }
    }
}

// MARK: - FinancialEventType UI köməkçiləri

private extension FinancialEventType {
    var ikon: String {
        switch self {
        case .hedefYaradildi:  return "plus.circle.fill"
        case .qenaetEdildi:    return "arrow.down.circle.fill"
        case .hedefTamamlandi: return "checkmark.seal.fill"
        case .esyaAlindi:      return "cart.fill"
        }
    }

    var reng: Color {
        switch self {
        case .hedefYaradildi:  return AppTheme.primary
        case .qenaetEdildi:    return AppTheme.success
        case .hedefTamamlandi: return AppTheme.accent
        case .esyaAlindi:      return AppTheme.warning
        }
    }
}
