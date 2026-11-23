import Foundation

/// Şəhərin böyümə səviyyəsi sistemi. Bütün girişlər (missiya, tapşırıq, qənaət)
/// "Şəhər Proqresi" xalını artırır, bu da öz növbəsində Şəhər Səviyyəsini müəyyən edir.
/// Səviyyə artdıqca yeni market əşyaları kilidini açır (bax: MarketItem.unlockSeviyyesi).
enum CityLevelSystem {
    /// Hər indeks bir səviyyənin BAŞLANĞIC həddidir (məcmu Şəhər Proqresi)
    static let esikler: [Int] = [0, 30, 80, 160, 280, 450, 700, 1000]

    static let adlar: [String] = [
        "Balaca Ada", "Kiçik Kənd", "Böyüyən Qəsəbə", "Canlı Məhəllə",
        "İnkişaf Edən Şəhər", "Parlaq Şəhər", "Böyük Şəhər", "Metropolis"
    ]

    static var maksimumSeviyye: Int { adlar.count }

    static func seviyye(proqres: Int) -> Int {
        var seviyye = 1
        for (i, esik) in esikler.enumerated() where proqres >= esik {
            seviyye = i + 1
        }
        return min(seviyye, maksimumSeviyye)
    }

    static func adi(proqres: Int) -> String {
        let s = seviyye(proqres: proqres)
        return adlar[min(s - 1, adlar.count - 1)]
    }

    /// Cari səviyyə daxilindəki tamamlanma faizi (progress bar üçün, 0...1)
    static func faiz(proqres: Int) -> Double {
        let s = seviyye(proqres: proqres)
        guard s < esikler.count else { return 1.0 }
        let altEsik = esikler[s - 1]
        let ustEsik = esikler[s]
        let genislik = Double(ustEsik - altEsik)
        guard genislik > 0 else { return 1.0 }
        return min(max(Double(proqres - altEsik) / genislik, 0), 1)
    }

    /// Növbəti səviyyəyə neçə proqres qaldığı
    static func qalanProqres(proqres: Int) -> Int {
        let s = seviyye(proqres: proqres)
        guard s < esikler.count else { return 0 }
        return max(esikler[s] - proqres, 0)
    }
}
