import SwiftUI

/// App açılanda ilk göstərilən qərarverici ekran:
/// 1) Heç kim qeydiyyatdan keçməyibsə -> RegistrationView
/// 2) Valideyn PIN ilə daxil olubsa -> ParentDashboardView
/// 3) Əks halda (default) -> ChildTabView (Kart / Qənaət / Şəhər)
struct RootView: View {
    @EnvironmentObject var store: DataStore

    var body: some View {
        if store.parent == nil {
            RegistrationView()
        } else if store.valideynRejimindeyik {
            ParentDashboardView()
        } else {
            ChildTabView()
        }
    }
}

#Preview {
    RootView().environmentObject(DataStore())
}
