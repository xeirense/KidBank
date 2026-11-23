import Foundation

/// Bütün market əşyaları burada - yeni əşya əlavə etmək istəsən sadəcə bu siyahıya yeni sətir at.
enum MarketCatalog {
    static let esyalar: [MarketItem] = [
        // Təbiət - ucuz və çoxsaylı, uşaq şəhəri yaşıllaşdıra bilsin
        MarketItem(id: "agac1", ad: "Ağac", emoji: "🌳", qiymet: 6, kateqoriya: .tebiet, unlockSeviyyesi: 1),
        MarketItem(id: "agac2", ad: "Şam ağacı", emoji: "🌲", qiymet: 6, kateqoriya: .tebiet, unlockSeviyyesi: 1),
        MarketItem(id: "gul1", ad: "Gül dəstəsi", emoji: "🌷", qiymet: 6, kateqoriya: .tebiet, unlockSeviyyesi: 1),
        MarketItem(id: "park1", ad: "Park skamyası", emoji: "🪑", qiymet: 10, kateqoriya: .tebiet, unlockSeviyyesi: 1),
        MarketItem(id: "palma1", ad: "Palma", emoji: "🌴", qiymet: 8, kateqoriya: .tebiet, unlockSeviyyesi: 2),
        MarketItem(id: "kaktus1", ad: "Kaktus", emoji: "🌵", qiymet: 7, kateqoriya: .tebiet, unlockSeviyyesi: 2),
        MarketItem(id: "deniz1", ad: "Çimərlik", emoji: "🏖️", qiymet: 40, kateqoriya: .tebiet, unlockSeviyyesi: 8),

        // Binalar
        MarketItem(id: "ev1", ad: "Balaca ev", emoji: "🏠", qiymet: 50, kateqoriya: .bina, unlockSeviyyesi: 3),
        MarketItem(id: "market1", ad: "Dükan", emoji: "🏪", qiymet: 60, kateqoriya: .bina, unlockSeviyyesi: 4),
        MarketItem(id: "kafe1", ad: "Kafe", emoji: "☕️", qiymet: 55, kateqoriya: .bina, unlockSeviyyesi: 5),
        MarketItem(id: "xestexana1", ad: "Xəstəxana", emoji: "🏥", qiymet: 90, kateqoriya: .bina, unlockSeviyyesi: 6),
        MarketItem(id: "ev2", ad: "Bələdiyyə binası", emoji: "🏛️", qiymet: 80, kateqoriya: .bina, unlockSeviyyesi: 7),
        MarketItem(id: "kino1", ad: "Kinoteatr", emoji: "🎬", qiymet: 85, kateqoriya: .bina, unlockSeviyyesi: 8),
        MarketItem(id: "lunapark1", ad: "Fırlanan çarx", emoji: "🎡", qiymet: 100, kateqoriya: .bina, unlockSeviyyesi: 8),

        // İdman (oğlanlar üçün futbol mövzusu daxil)
        MarketItem(id: "futbol1", ad: "Futbol meydançası", emoji: "⚽️", qiymet: 45, kateqoriya: .idman, unlockSeviyyesi: 6),
        MarketItem(id: "futbol2", ad: "Futbol qapısı", emoji: "🥅", qiymet: 25, kateqoriya: .idman, unlockSeviyyesi: 7),
        MarketItem(id: "basketbol1", ad: "Basketbol həlqəsi", emoji: "🏀", qiymet: 30, kateqoriya: .idman, unlockSeviyyesi: 7),

        // Dekorasiya
        MarketItem(id: "fener1", ad: "Küçə fənəri", emoji: "🏮", qiymet: 12, kateqoriya: .dekorasiya, unlockSeviyyesi: 2),
        MarketItem(id: "bayraq1", ad: "Rəngli bayraqlar", emoji: "🎏", qiymet: 10, kateqoriya: .dekorasiya, unlockSeviyyesi: 3),
        MarketItem(id: "heykel1", ad: "Fəvvarə", emoji: "⛲️", qiymet: 35, kateqoriya: .dekorasiya, unlockSeviyyesi: 4),
        MarketItem(id: "qayiq1", ad: "Yelkənli qayıq", emoji: "⛵️", qiymet: 30, kateqoriya: .dekorasiya, unlockSeviyyesi: 5)
    ]

    static func tap(_ id: String) -> MarketItem? {
        esyalar.first(where: { $0.id == id })
    }
}

/// Qənaət hədəfi yaradanda uşağa göstəriləcək hazır şablonlar
enum SavingsGoalCatalog {
    static let sablonlar: [SavingsGoalTemplate] = [
        SavingsGoalTemplate(basliq: "Velosiped", emoji: "🚲", tovsiyeMebleg: 150),
        SavingsGoalTemplate(basliq: "Oyuncaq", emoji: "🧸", tovsiyeMebleg: 40),
        SavingsGoalTemplate(basliq: "Telefon", emoji: "📱", tovsiyeMebleg: 300),
        SavingsGoalTemplate(basliq: "Kitab dəsti", emoji: "📚", tovsiyeMebleg: 25),
        SavingsGoalTemplate(basliq: "Futbol topu", emoji: "⚽️", tovsiyeMebleg: 20),
        SavingsGoalTemplate(basliq: "Skuter", emoji: "🛴", tovsiyeMebleg: 120)
    ]
}
