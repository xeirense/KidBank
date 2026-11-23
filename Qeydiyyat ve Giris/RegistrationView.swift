import SwiftUI

/// X Bank kimi düşün: valideyn buradan "kart hesabı" açır və uşağını qeyd edir.
struct RegistrationView: View {
    @EnvironmentObject var store: DataStore

    @State private var valideynAdi: String = ""
    @State private var usaqAdi: String = ""
    @State private var pin: String = ""
    @State private var secilenPet: PetType = .panda

    var formDoludur: Bool {
        !valideynAdi.trimmingCharacters(in: .whitespaces).isEmpty &&
        !usaqAdi.trimmingCharacters(in: .whitespaces).isEmpty &&
        pin.count == 4
    }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 6) {
                        ZStack {
                            Circle().fill(AppTheme.primaryLight).frame(width: 84, height: 84)
                            Image(systemName: "building.columns.fill")
                                .font(.system(size: 34))
                                .foregroundColor(AppTheme.primary)
                        }
                        Text("Uşaq Kartı Hesabı Aç")
                            .font(.title2.bold())
                            .foregroundColor(AppTheme.textPrimary)
                        Text("Valideyn nəzarəti altında, sadə və əyləncəli")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.top, 40)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Valideynin adı")
                            .foregroundColor(AppTheme.textSecondary).font(.caption.bold())
                        TextField("Məs: Ayşə", text: $valideynAdi)
                            .textFieldStyle()

                        Text("4 rəqəmli PIN (Valideyn Rejiminə giriş üçün)")
                            .foregroundColor(AppTheme.textSecondary).font(.caption.bold())
                        SecureField("• • • •", text: $pin)
                            .keyboardType(.numberPad)
                            .textFieldStyle()
                            .onChange(of: pin) { (yeniDeger: String) in
                                pin = String(yeniDeger.filter { $0.isNumber }.prefix(4))
                            }

                        Divider().background(AppTheme.border)

                        Text("Uşağının adı")
                            .foregroundColor(AppTheme.textSecondary).font(.caption.bold())
                        TextField("Məs: Kərim", text: $usaqAdi)
                            .textFieldStyle()

                        Text("Onun üçün heyvan seç")
                            .foregroundColor(AppTheme.textSecondary).font(.caption.bold())

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                            ForEach(PetType.allCases, id: \.self) { pet in
                                Button {
                                    secilenPet = pet
                                } label: {
                                    Text(pet.emoji)
                                        .font(.system(size: 30))
                                        .frame(width: 58, height: 58)
                                        .background(secilenPet == pet ? AppTheme.primaryLight : AppTheme.secondaryBackground)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(secilenPet == pet ? AppTheme.primary : .clear, lineWidth: 2)
                                        )
                                }
                            }
                        }
                    }
                    .padding(20)
                    .background(AppTheme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .overlay(RoundedRectangle(cornerRadius: 22).stroke(AppTheme.border, lineWidth: 1))
                    .padding(.horizontal)

                    Button {
                        store.qeydiyyatiTamamla(valideynAdi: valideynAdi, pin: pin, usaqAdi: usaqAdi, pet: secilenPet)
                    } label: {
                        Text("Hesabı Aç")
                            .font(.headline)
                            .foregroundColor(AppTheme.textOnPrimary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .disabled(!formDoludur)
                    .opacity(formDoludur ? 1 : 0.5)
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

private extension View {
    func textFieldStyle() -> some View {
        self
            .padding()
            .background(AppTheme.secondaryBackground)
            .foregroundColor(AppTheme.textPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    RegistrationView().environmentObject(DataStore())
}
