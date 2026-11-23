import SwiftUI

/// Uşaq rejiminin əsas skeleti - altda 3 böyük, aydın tab.
struct ChildTabView: View {
    var body: some View {
        TabView {
            ChildCardView()
                .tabItem {
                    Label("Kartım", systemImage: "creditcard.fill")
                }

            SavingsGoalsView()
                .tabItem {
                    Label("Qənaət", systemImage: "target")
                }

            MiniCityView()
                .tabItem {
                    Label("Şəhərim", systemImage: "building.2.fill")
                }
        }
        .tint(AppTheme.primary)
    }
}

#Preview {
    let store = DataStore()
    store.qeydiyyatiTamamla(valideynAdi: "Ayşə", pin: "1234", usaqAdi: "Kərim", pet: .aslan)
    return ChildTabView().environmentObject(store)
}
