import SwiftUI

/// Hər tapşırıq üçün böyük, aydın kart. Söz azdır, ikon və rəng danışır.
struct TaskCardView: View {
    let task: KidTask
    var onTamamlandi: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(reng.opacity(0.15))
                    .frame(width: 50, height: 50)
                Image(systemName: task.iconName)
                    .font(.title3)
                    .foregroundColor(reng)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(AppTheme.textPrimary)
                    .lineLimit(2)

                HStack(spacing: 10) {
                    Label("\(task.mukafatPul, specifier: "%.1f") ₼", systemImage: "banknote.fill")
                    Label("\(task.mukafatXal)", systemImage: "star.fill")
                }
                .font(.caption.bold())
                .foregroundColor(AppTheme.textSecondary)
            }

            Spacer()

            statusDuymesi
        }
        .padding(14)
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(AppTheme.border, lineWidth: 1))
        .padding(.horizontal)
    }

    private var reng: Color {
        switch task.status {
        case .gozleyir: return AppTheme.primary
        case .tesdiqBekleyir: return AppTheme.warning
        case .tesdiqlendi: return AppTheme.success
        }
    }

    @ViewBuilder
    private var statusDuymesi: some View {
        switch task.status {
        case .gozleyir:
            Button(action: onTamamlandi) {
                Text("Etdim")
                    .font(.caption.bold())
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(AppTheme.primary)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        case .tesdiqBekleyir:
            Text("Gözlənilir")
                .font(.caption.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(AppTheme.warning.opacity(0.15))
                .foregroundColor(AppTheme.warning)
                .clipShape(Capsule())
        case .tesdiqlendi:
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(AppTheme.success)
                .font(.title2)
        }
    }
}
