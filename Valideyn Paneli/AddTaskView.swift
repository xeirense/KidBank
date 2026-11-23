import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var store: DataStore
    @Environment(\.dismiss) var dismiss
    let childId: UUID

    @State private var basliq: String = ""
    @State private var secilenIkon: String = "book.fill"
    @State private var pul: Double = 1.0
    @State private var xal: Int = 5

    // Valideynin seçə biləcəyi hazır ikon dəsti - uşaq işləri üçün uyğun
    let ikonlar = ["book.fill", "house.fill", "sparkles", "bed.double.fill",
                   "trash.fill", "pawprint.fill", "figure.walk", "paintpalette.fill"]

    var body: some View {
        NavigationView {
            Form {
                Section("Tapşırığın adı") {
                    TextField("Məs: Ev tapşırıqlarını həll et", text: $basliq)
                }

                Section("İkon seç") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                        ForEach(ikonlar, id: \.self) { ikon in
                            Image(systemName: ikon)
                                .font(.title2)
                                .frame(width: 50, height: 50)
                                .background(secilenIkon == ikon ? Color.indigo.opacity(0.3) : Color.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .onTapGesture { secilenIkon = ikon }
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("Mükafat") {
                    Stepper("Pul: \(pul, specifier: "%.1f") ₼", value: $pul, in: 0.5...50, step: 0.5)
                    Stepper("Xal: \(xal)", value: $xal, in: 1...100, step: 1)
                }

                Button("Tapşırığı əlavə et") {
                    guard !basliq.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    store.yeniTapsirigEle(childId: childId, title: basliq, icon: secilenIkon, pul: pul, xal: xal)
                    dismiss()
                }
                .disabled(basliq.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .navigationTitle("Yeni Tapşırıq")
            .tint(AppTheme.primary)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Bağla") { dismiss() }
                }
            }
        }
    }
}
