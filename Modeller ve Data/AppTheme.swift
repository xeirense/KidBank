import SwiftUI

/// Bütün tətbiqin istifadə etdiyi mərkəzi, sakit rəng palitrası.
/// Hələlik nümunədir - sonra real bank brendinə uyğunlaşdırılacaq,
/// amma indi məqsəd: göz yormayan, sadə, "standart" fintech görünüşü.
enum AppTheme {
    // Fon rəngləri - açıq, boz-mavi çalarlı, ağ ekrandan daha yumşaq
    static let background = Color(red: 0.96, green: 0.97, blue: 0.98)
    static let cardBackground = Color.white
    static let secondaryBackground = Color(red: 0.93, green: 0.94, blue: 0.96)

    // Əsas marka rəngi - sakit, etibarlı bank mavisi
    static let primary = Color(red: 0.24, green: 0.44, blue: 0.68)
    static let primaryDark = Color(red: 0.15, green: 0.3, blue: 0.5)
    static let primaryLight = Color(red: 0.85, green: 0.9, blue: 0.96)

    // Vurğu rəngi - mükafat/xal/bonus üçün isti qızılı-sarı
    static let accent = Color(red: 0.85, green: 0.62, blue: 0.22)

    // Status rəngləri
    static let success = Color(red: 0.32, green: 0.6, blue: 0.46)
    static let warning = Color(red: 0.82, green: 0.55, blue: 0.25)
    static let danger = Color(red: 0.74, green: 0.35, blue: 0.35)

    // Mətn rəngləri
    static let textPrimary = Color(red: 0.14, green: 0.16, blue: 0.2)
    static let textSecondary = Color(red: 0.46, green: 0.49, blue: 0.54)
    static let textOnPrimary = Color.white

    // Kənar/xətt rəngi
    static let border = Color(red: 0.88, green: 0.9, blue: 0.93)
}
