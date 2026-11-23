import SwiftUI

// DİQQƏT: Swift-də tip/struct adı rəqəmlə başlaya bilməz (məs: "111App" xəta verər).
// Ona görə struct-un daxili adı "BankKidsApp"-dır, amma Xcode-da layihənin
// "Display Name"-ni (App ikonun altındakı ad) "111" olaraq ayarlaya bilərsən:
// Xcode -> Project Settings -> General -> Display Name -> "111"

@main
struct BankKidsApp: App {
    @StateObject private var store = DataStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
    }
}
