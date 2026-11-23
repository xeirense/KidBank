import SwiftUI

/// Valideynin gördüyü panel: təsdiq gözləyən tapşırıqlar + yeni tapşırıq əlavə etmək.
struct ParentDashboardView: View {
    @EnvironmentObject var store: DataStore
    @State private var yeniTapsirigAcigdir = false
    @State private var cixisTesdiqiAcigdir = false

    var child: ChildProfile? { store.aktivChild() }

    var body: some View {
        NavigationView {
            List {
                if let child = child {
                    Section("Uşağın hesabı") {
                        HStack {
                            Text(child.pet.emoji).font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(child.ad).font(.headline)
                                Text("\(child.balans, specifier: "%.2f") ₼ · \(child.xal) xal")
                                    .font(.caption).foregroundColor(.secondary)
                            }
                        }
                    }

                    Section {
                        NavigationLink(destination: FinancialSkillsView()) {
                            Label("Maliyyə bacarıqları", systemImage: "chart.bar.doc.horizontal")
                        }
                    } footer: {
                        Text("Uşağınızın qənaət və qərar vərdişlərinin qeydlərə əsaslanan hesabatı")
                    }

                    let bekleyenler = child.tasks.filter { $0.status == .tesdiqBekleyir }
                    if !bekleyenler.isEmpty {
                        Section("Təsdiq gözləyir (\(bekleyenler.count))") {
                            ForEach(bekleyenler) { task in
                                HStack {
                                    Image(systemName: task.iconName).foregroundColor(.orange)
                                    VStack(alignment: .leading) {
                                        Text(task.title).font(.subheadline.bold())
                                        Text("+\(task.mukafatPul, specifier: "%.1f") ₼ · +\(task.mukafatXal) xal")
                                            .font(.caption).foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Button {
                                        store.valideynRedEtsin(childId: child.id, taskId: task.id)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                                    }.buttonStyle(.plain)
                                    Button {
                                        store.valideynTesdiqEtsin(childId: child.id, taskId: task.id)
                                    } label: {
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                    }.buttonStyle(.plain)
                                }
                            }
                        }
                    }

                    let missiyaBekleyenler = child.gunlukMissiyalar.filter { $0.status == .tesdiqBekleyir }
                    if !missiyaBekleyenler.isEmpty {
                        Section("Missiya təsdiqi gözləyir (\(missiyaBekleyenler.count))") {
                            ForEach(missiyaBekleyenler) { assigned in
                                if let mission = RealLifeMissionCatalog.tap(assigned.missionId) {
                                    HStack {
                                        Text(mission.emoji)
                                        VStack(alignment: .leading) {
                                            Text(mission.title).font(.subheadline.bold())
                                            Text("💰\(mission.mukafatPul, specifier: "%.1f") ₼ · ⭐\(mission.mukafatXal) · 🏙️\(mission.mukafatSeherProqresi) · 😊\(mission.mukafatXosbextlik)")
                                                .font(.caption2).foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Button {
                                            store.missiyaRedEt(childId: child.id, assignedId: assigned.id)
                                        } label: {
                                            Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                                        }.buttonStyle(.plain)
                                        Button {
                                            store.missiyaTesdiqle(childId: child.id, assignedId: assigned.id)
                                        } label: {
                                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                        }.buttonStyle(.plain)
                                    }
                                }
                            }
                        }
                    }

                    Section("Bütün tapşırıqlar") {
                        ForEach(child.tasks) { task in
                            HStack {
                                Image(systemName: task.iconName)
                                Text(task.title)
                                Spacer()
                                Text(statusMetni(task.status))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Button {
                            yeniTapsirigAcigdir = true
                        } label: {
                            Label("Yeni tapşırıq əlavə et", systemImage: "plus.circle.fill")
                        }
                    }

                    if !child.tarixce.isEmpty {
                        Section("Son əməliyyatlar") {
                            ForEach(child.tarixce.prefix(5)) { record in
                                HStack {
                                    Text(record.basliq)
                                    Spacer()
                                    Text("+\(record.mebleg, specifier: "%.2f") ₼")
                                        .foregroundColor(.green)
                                }
                                .font(.caption)
                            }
                        }
                    }
                }

                Section {
                    Button(role: .destructive) {
                        store.valideynRejimindeyik = false
                    } label: {
                        Label("Uşaq Rejiminə qayıt", systemImage: "arrow.uturn.left")
                    }
                }

                Section {
                    Button(role: .destructive) {
                        cixisTesdiqiAcigdir = true
                    } label: {
                        Label("Hesabdan çıx", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                } footer: {
                    Text("Bu, bütün lokal datanı siləcək və Qeydiyyat ekranına qaytaracaq.")
                }
            }
            .navigationTitle("Valideyn Paneli")
            .tint(AppTheme.primary)
            .alert("Hesabdan çıxmaq istəyirsən?", isPresented: $cixisTesdiqiAcigdir) {
                Button("Ləğv et", role: .cancel) { }
                Button("Hesabdan çıx", role: .destructive) {
                    store.hesabdanCixis()
                }
            } message: {
                Text("Bütün uşaq, tapşırıq və şəhər datası silinəcək. Bu addım geri qaytarıla bilməz.")
            }
            .sheet(isPresented: $yeniTapsirigAcigdir) {
                if let child = child {
                    AddTaskView(childId: child.id)
                }
            }
        }
    }

    private func statusMetni(_ status: TaskStatus) -> String {
        switch status {
        case .gozleyir: return "Gözləyir"
        case .tesdiqBekleyir: return "Təsdiq lazımdır"
        case .tesdiqlendi: return "Tamamlanıb ✓"
        }
    }
}
