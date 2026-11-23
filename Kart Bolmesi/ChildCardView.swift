import SwiftUI

/// Uşaq telefonu açanda gördüyü ƏSAS ekran.
/// Çox az söz, aydın rənglər - kiçik uşaq da başa düşsün deyə, amma göz yormasın.
struct ChildCardView: View {
    @EnvironmentObject var store: DataStore
    @State private var pinEkraniAcigdir = false
    @State private var petAcigdir = false

    var child: ChildProfile? { store.aktivChild() }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            if let child = child {
                ScrollView {
                    VStack(spacing: 22) {

                        HStack {
                            Button {
                                petAcigdir = true
                            } label: {
                                Text(child.pet.emoji)
                                    .font(.system(size: 40))
                            }
                            Spacer()
                            Button {
                                pinEkraniAcigdir = true
                            } label: {
                                Image(systemName: "person.fill.badge.plus")
                                    .foregroundColor(AppTheme.textSecondary)
                                    .font(.title3)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)

                        // KART
                        VStack(alignment: .leading, spacing: 14) {
                            Text(child.ad)
                                .font(.title3.bold())
                                .foregroundColor(AppTheme.textOnPrimary)

                            Text("\(child.balans, specifier: "%.2f") ₼")
                                .font(.system(size: 42, weight: .bold, design: .rounded))
                                .foregroundColor(AppTheme.textOnPrimary)

                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(AppTheme.accent)
                                Text("\(child.xal) xal")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textOnPrimary.opacity(0.9))
                            }
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark],
                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .padding(.horizontal)

                        // TAPŞIRIQLAR
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Tapşırıqların")
                                .font(.title3.bold())
                                .foregroundColor(AppTheme.textPrimary)
                                .padding(.horizontal)

                            ForEach(child.tasks) { task in
                                TaskCardView(task: task) {
                                    store.uşaqTapsirigiTamamladi(childId: child.id, taskId: task.id)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 40)
                }
            } else {
                Text("Yüklənir...")
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
        .sheet(isPresented: $pinEkraniAcigdir) {
            PinLockView()
        }
        .sheet(isPresented: $petAcigdir) {
            if let child { PetDetailView(pet: child.pet) }
        }
    }
}

#Preview {
    let store = DataStore()
    store.qeydiyyatiTamamla(valideynAdi: "Ayşə", pin: "1234", usaqAdi: "Kərim", pet: .aslan)
    return ChildCardView().environmentObject(store)
}
