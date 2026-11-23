import Foundation

/// Bütün gündəlik missiyaların sabit kataloqu.
/// Hər gün buradan 3 missiya seçilir (bugunkuMissiyalariYarat funksiyası ilə).
enum RealLifeMissionCatalog {
    static let missiyalar: [RealLifeMission] = [

        // MARK: Məsuliyyət
        RealLifeMission(id: "mes_otag", title: "Otağını yığışdır", emoji: "🧹",
                        kateqoriya: .mesuliyyet, niyeVacibdir: "Öz yerini nizamlamaq özünəidarəni gücləndirir.",
                        mukafatPul: 1.0, mukafatXal: 8, mukafatSeherProqresi: 5, mukafatXosbextlik: 3),
        RealLifeMission(id: "mes_disher", title: "Dişlərini fırçala", emoji: "🪥",
                        kateqoriya: .mesuliyyet, niyeVacibdir: "Sağlamlıq vərdişi erkən başlamalıdır.",
                        mukafatPul: 0.5, mukafatXal: 5, mukafatSeherProqresi: 3, mukafatXosbextlik: 2),
        RealLifeMission(id: "mes_canta", title: "Çantanı yığ", emoji: "🎒",
                        kateqoriya: .mesuliyyet, niyeVacibdir: "Planlaşdırma bacarığını inkişaf etdirir.",
                        mukafatPul: 0.5, mukafatXal: 5, mukafatSeherProqresi: 3, mukafatXosbextlik: 2),
        RealLifeMission(id: "mes_yemek", title: "Yeməyi özün hazırla", emoji: "🥪",
                        kateqoriya: .mesuliyyet, niyeVacibdir: "Ev işlərini öyrənmək müstəqilliyi artırır.",
                        mukafatPul: 1.5, mukafatXal: 10, mukafatSeherProqresi: 6, mukafatXosbextlik: 4),

        // MARK: Maliyyə Vərdişi
        RealLifeMission(id: "mal_qiymet", title: "Bir əşyanın qiymətini araşdır", emoji: "🔍",
                        kateqoriya: .maliyyeVerdish, niyeVacibdir: "Qiymət müqayisəsi ağıllı alıcı olmağı öyrədir.",
                        mukafatPul: 1.0, mukafatXal: 10, mukafatSeherProqresi: 8, mukafatXosbextlik: 3),
        RealLifeMission(id: "mal_qezebet", title: "Heç nə almadan marketdən çıx", emoji: "🛒",
                        kateqoriya: .maliyyeVerdish, niyeVacibdir: "İstək ilə ehtiyacı ayırmaq maliyyə savadıdır.",
                        mukafatPul: 2.0, mukafatXal: 15, mukafatSeherProqresi: 10, mukafatXosbextlik: 5),
        RealLifeMission(id: "mal_hedef", title: "Bu həftəki qənaət hədəfini yaz", emoji: "📝",
                        kateqoriya: .maliyyeVerdish, niyeVacibdir: "Hədəf yazmaq həyata keçmə ehtimalını artırır.",
                        mukafatPul: 1.0, mukafatXal: 8, mukafatSeherProqresi: 6, mukafatXosbextlik: 4),
        RealLifeMission(id: "mal_serfeh", title: "Bu gün 1 manat belə xərcləmə", emoji: "💪",
                        kateqoriya: .maliyyeVerdish, niyeVacibdir: "Nəfsinə sahib olmaq zəngin adamların sirridir.",
                        mukafatPul: 2.0, mukafatXal: 12, mukafatSeherProqresi: 8, mukafatXosbextlik: 4),

        // MARK: Ətraf Mühit
        RealLifeMission(id: "etr_zibil", title: "Zibili doğru yerə at", emoji: "♻️",
                        kateqoriya: .etrafMuhit, niyeVacibdir: "Ətrafına qayğı göstərmək böyük qəhrəmanlıqdır.",
                        mukafatPul: 0.5, mukafatXal: 6, mukafatSeherProqresi: 5, mukafatXosbextlik: 3),
        RealLifeMission(id: "etr_su", title: "Dişlərini fırçalayanda kranı bağla", emoji: "💧",
                        kateqoriya: .etrafMuhit, niyeVacibdir: "Su qənaəti planeti xilas edir.",
                        mukafatPul: 0.5, mukafatXal: 5, mukafatSeherProqresi: 4, mukafatXosbextlik: 3),
        RealLifeMission(id: "etr_isiq", title: "Otaqdan çıxanda işığı söndür", emoji: "💡",
                        kateqoriya: .etrafMuhit, niyeVacibdir: "Enerji qənaəti xərclərini azaldır, planeti qoruyur.",
                        mukafatPul: 0.5, mukafatXal: 5, mukafatSeherProqresi: 4, mukafatXosbextlik: 2),
        RealLifeMission(id: "etr_agac", title: "Bitki/ağaca su ver", emoji: "🌱",
                        kateqoriya: .etrafMuhit, niyeVacibdir: "Canlılara qayğı göstərmək empatiyanı gücləndirir.",
                        mukafatPul: 0.5, mukafatXal: 6, mukafatSeherProqresi: 5, mukafatXosbextlik: 4),

        // MARK: Xeyirxahlıq
        RealLifeMission(id: "xey_konek", title: "Qonşuna kömək et", emoji: "🤝",
                        kateqoriya: .xeyirxahliq, niyeVacibdir: "Kömək etmək həm özünü həm başqasını xoşbəxt edir.",
                        mukafatPul: 1.0, mukafatXal: 10, mukafatSeherProqresi: 7, mukafatXosbextlik: 6),
        RealLifeMission(id: "xey_dosuna", title: "Dostuna xoş bir söz de", emoji: "😊",
                        kateqoriya: .xeyirxahliq, niyeVacibdir: "Pozitiv ünsiyyət sosial bacarıq inkişaf etdirir.",
                        mukafatPul: 0.5, mukafatXal: 6, mukafatSeherProqresi: 4, mukafatXosbextlik: 5),
        RealLifeMission(id: "xey_paylash", title: "Bir əşyanı başqası ilə paylaş", emoji: "🎁",
                        kateqoriya: .xeyirxahliq, niyeVacibdir: "Bölüşmək cəmiyyəti daha gözəl edir.",
                        mukafatPul: 1.5, mukafatXal: 12, mukafatSeherProqresi: 8, mukafatXosbextlik: 6),

        // MARK: Təhsil
        RealLifeMission(id: "teh_oxu", title: "30 dəqiqə kitab oxu", emoji: "📖",
                        kateqoriya: .tehsil, niyeVacibdir: "Oxumaq beyin inkişafının ən güclü yoludur.",
                        mukafatPul: 1.5, mukafatXal: 12, mukafatSeherProqresi: 9, mukafatXosbextlik: 4),
        RealLifeMission(id: "teh_tapshiriq", title: "Ev tapşırığını vaxtında et", emoji: "✏️",
                        kateqoriya: .tehsil, niyeVacibdir: "Öhdəlikləri yerinə yetirmək uğurun açarıdır.",
                        mukafatPul: 2.0, mukafatXal: 15, mukafatSeherProqresi: 10, mukafatXosbextlik: 5),
        RealLifeMission(id: "teh_yeni", title: "Yeni bir söz/fakt öyrən", emoji: "🧠",
                        kateqoriya: .tehsil, niyeVacibdir: "Hər gün yeni şey öyrənmək ağlı itiləşdirir.",
                        mukafatPul: 1.0, mukafatXal: 8, mukafatSeherProqresi: 6, mukafatXosbextlik: 4),

        // MARK: Sağlamlıq
        RealLifeMission(id: "sag_idman", title: "15 dəqiqə idman et", emoji: "🏃",
                        kateqoriya: .saglamliq, niyeVacibdir: "Hər gün hərəkət etmək uzun ömrün sirridir.",
                        mukafatPul: 1.5, mukafatXal: 12, mukafatSeherProqresi: 8, mukafatXosbextlik: 5),
        RealLifeMission(id: "sag_meyvə", title: "Meyvə və ya tərəvəz ye", emoji: "🍎",
                        kateqoriya: .saglamliq, niyeVacibdir: "Sağlam qidalanma güclü enerji verir.",
                        mukafatPul: 0.5, mukafatXal: 6, mukafatSeherProqresi: 4, mukafatXosbextlik: 3),
        RealLifeMission(id: "sag_su", title: "Gün ərzində 6 stəkan su iç", emoji: "🥤",
                        kateqoriya: .saglamliq, niyeVacibdir: "Yetərli su içmək diqqəti artırır.",
                        mukafatPul: 0.5, mukafatXal: 5, mukafatSeherProqresi: 3, mukafatXosbextlik: 3),
        RealLifeMission(id: "sag_yuxu", title: "Vaxtında yat", emoji: "😴",
                        kateqoriya: .saglamliq, niyeVacibdir: "Yaxşı yuxu öyrənməni gücləndirir.",
                        mukafatPul: 1.0, mukafatXal: 8, mukafatSeherProqresi: 5, mukafatXosbextlik: 5)
    ]

    static func tap(_ id: String) -> RealLifeMission? {
        missiyalar.first { $0.id == id }
    }
}
