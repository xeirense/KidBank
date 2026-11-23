import SwiftUI

struct MarketView: View {
    @EnvironmentObject var store: DataStore
    @Environment(\.dismiss) var dismiss
    let childId: UUID

    var child: ChildProfile? { store.aktivChild() }

    var body: some View {
        NavigationView {
            List {
                if let child {
                    Section {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Səviyyə \(CityLevelSystem.seviyye(proqres: child.seherProqresi)) — \(CityLevelSystem.adi(proqres: child.seherProqresi))")
                                    .font(.subheadline.bold())
                                    .foregroundColor(AppTheme.textPrimary)
                                Spacer()
                            }
                            ProgressView(value: CityLevelSystem.faiz(proqres: child.seherProqresi))
                                .tint(AppTheme.accent)
                            Text("Növbəti səviyyəyə \(CityLevelSystem.qalanProqres(proqres: child.seherProqresi)) proqres qalıb")
                                .font(.caption2)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .padding(.vertical, 4)
                    }
                }

                ForEach(MarketCategory.allCases, id: \.self) { kateqoriya in
                    Section(kateqoriya.basliq) {
                        ForEach(MarketCatalog.esyalar.filter { $0.kateqoriya == kateqoriya }) { item in
                            esyaSetri(item)
                        }
                    }
                }
            }
            .tint(AppTheme.primary)
            .navigationTitle("Market")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if let child {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Text("\(child.xal) xal")
                        }
                        .font(.headline)
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Bağla") { dismiss() }
                }
            }
        }
    }

    @ViewBuilder
    private func esyaSetri(_ item: MarketItem) -> some View {
        let sahibdir = child?.sahibOlduguEsyalar.contains(item.id) ?? false
        let cariSeviyye = CityLevelSystem.seviyye(proqres: child?.seherProqresi ?? 0)
        let kiliddedir = item.unlockSeviyyesi > cariSeviyye
        let alaBilir = (child?.xal ?? 0) >= item.qiymet && !kiliddedir

        HStack {
            EsyaSekli(item: item, olcu: 32)
                .opacity(kiliddedir ? 0.35 : 1.0)
            VStack(alignment: .leading) {
                Text(item.ad).font(.subheadline.bold())
                    .foregroundColor(kiliddedir ? AppTheme.textSecondary : AppTheme.textPrimary)
                if kiliddedir {
                    Label("Səviyyə \(item.unlockSeviyyesi) lazımdır", systemImage: "lock.fill")
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                } else {
                    Label("\(item.qiymet) xal", systemImage: "star.fill")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()

            if kiliddedir {
                Image(systemName: "lock.fill")
                    .foregroundColor(AppTheme.textSecondary)
                    .font(.body)
            } else if sahibdir {
                Text("Alınıb")
                    .font(.caption.bold())
                    .foregroundColor(AppTheme.success)
            } else {
                Button("Al") {
                    if let childId = child?.id {
                        store.esyaSatinAl(childId: childId, item: item)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(AppTheme.primary)
                .disabled(!alaBilir)
            }
        }
    }
}
