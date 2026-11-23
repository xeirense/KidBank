import SwiftUI

/// Uşaq bura təsadüfən girsə belə, PIN bilmədən Valideyn Rejiminə keçə bilmir.
struct PinLockView: View {
    @EnvironmentObject var store: DataStore
    @Environment(\.dismiss) var dismiss
    @State private var girisPin: String = ""
    @State private var sehvMesaji: String? = nil

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            VStack(spacing: 24) {
                ZStack {
                    Circle().fill(AppTheme.primaryLight).frame(width: 80, height: 80)
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 32))
                        .foregroundColor(AppTheme.primary)
                }

                Text("Valideyn Rejimi")
                    .font(.title3.bold())
                    .foregroundColor(AppTheme.textPrimary)

                SecureField("PIN daxil et", text: $girisPin)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .font(.title2.bold())
                    .padding()
                    .background(AppTheme.secondaryBackground)
                    .foregroundColor(AppTheme.textPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 60)
                    .onChange(of: girisPin) { (yeniDeger: String) in
                        girisPin = String(yeniDeger.filter { $0.isNumber }.prefix(4))
                    }

                if let sehvMesaji {
                    Text(sehvMesaji)
                        .foregroundColor(AppTheme.danger)
                        .font(.caption)
                }

                Button("Daxil ol") {
                    if girisPin == store.parent?.pin {
                        store.valideynRejimindeyik = true
                        dismiss()
                    } else {
                        sehvMesaji = "PIN səhvdir, yenidən yoxla."
                    }
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 200)
                .padding()
                .background(AppTheme.primary)
                .clipShape(Capsule())

                Button("Ləğv et") { dismiss() }
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
    }
}
