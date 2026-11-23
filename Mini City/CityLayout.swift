import Foundation

/// Əşya market-dən alınanda "hardan başlasın" sualının cavabı.
/// Kateqoriyaya uyğun zolaqda (məs: binalar üfüqdə, ağaclar parkda) görünür,
/// amma item id-yə görə deterministik səpələnir ki, üst-üstə düşməsin.
/// Sonra uşaq barmaqla istədiyi yerə sürüşdürə bilər.
enum CityLayout {
    static func bashlangicMovqeyi(item: MarketItem) -> CityPosition {
        let yAraligi: ClosedRange<Double>
        switch item.kateqoriya {
        case .bina: yAraligi = 0.10...0.32
        case .tebiet: yAraligi = 0.38...0.78
        case .idman: yAraligi = 0.48...0.82
        case .dekorasiya: yAraligi = 0.30...0.70
        }

        var hasher = Hasher()
        hasher.combine(item.id)
        let seed = abs(hasher.finalize())

        let xFaiz = Double(seed % 1000) / 1000.0
        let x = 0.12 + xFaiz * 0.76

        let yFaiz = Double((seed / 1000) % 1000) / 1000.0
        let y = yAraligi.lowerBound + yFaiz * (yAraligi.upperBound - yAraligi.lowerBound)

        return CityPosition(x: x, y: y)
    }
}
