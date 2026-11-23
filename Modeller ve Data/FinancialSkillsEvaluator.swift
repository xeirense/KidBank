import Foundation

/// Uşağın maliyyə davranışlarını qiymətləndirən yardımçı.
/// Xam hadisə qeydlərindən oxunaqlı hesabat çıxarır.
enum FinancialSkillsEvaluator {

    /// Hədəfi tamamlayanda verilən bonus xal
    static let hedefBonusuXal: Int = 50

    // MARK: - Bacarıq xalları (0...100)

    struct SkillReport {
        let qenaetDavamlilik: Int    // ardıcıl qənaət etmə - %
        let harcamaOzuneDarbe: Int   // "heç nə almadan marketdən çıx" tipli missiyalar - %
        let hedefTamamlama: Int      // tamamlanan hədəflərin faizi - %
        let umumi: Int               // ortalama

        var seviyye: String {
            switch umumi {
            case 80...100: return "🏆 Maliyyə Dahisi"
            case 60..<80:  return "⭐️ Yaxşı Qənaətçi"
            case 40..<60:  return "📈 İnkişafdayam"
            default:       return "🌱 Yeni Başlayıram"
            }
        }
    }

    static func hesabla(child: ChildProfile) -> SkillReport {
        let qeydler = child.maliyyeQeydleri
        let hedefler = child.qenaetHedefleri

        // Qənaət davamlılığı: son 14 günün neçə günündə qənaət edilib
        let bugun = Date()
        let son14gun = (0..<14).compactMap { d -> Date? in
            Calendar.current.date(byAdding: .day, value: -d, to: bugun)
        }
        let qenaetGunleri = Set(
            qeydler
                .filter { $0.tip == .qenaetEdildi }
                .map { Calendar.current.startOfDay(for: $0.tarix) }
        )
        let aktivGunler = son14gun.filter { qenaetGunleri.contains(Calendar.current.startOfDay(for: $0)) }.count
        let qenaetDavamlilik = Int(Double(aktivGunler) / 14.0 * 100)

        // Harcama özünə-darbəsi: ".mal_serfeh" / ".mal_qezebet" missiyaları tamamlanıb mı
        let harcamaMissiyaIdsler = ["mal_serfeh", "mal_qezebet"]
        let tamamlananHarcama = child.tamamlanmisMissiyaIdleri.filter { harcamaMissiyaIdsler.contains($0) }.count
        let harcamaOzuneDarbe = min(tamamlananHarcama * 25, 100)

        // Hədəf tamamlama faizi
        let hedefTamamlama: Int
        if hedefler.isEmpty {
            hedefTamamlama = 0
        } else {
            let tamamlanan = hedefler.filter { $0.tamamlanib }.count
            hedefTamamlama = Int(Double(tamamlanan) / Double(hedefler.count) * 100)
        }

        let umumi = (qenaetDavamlilik + harcamaOzuneDarbe + hedefTamamlama) / 3

        return SkillReport(
            qenaetDavamlilik: qenaetDavamlilik,
            harcamaOzuneDarbe: harcamaOzuneDarbe,
            hedefTamamlama: hedefTamamlama,
            umumi: umumi
        )
    }
}
