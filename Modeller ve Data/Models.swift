import Foundation

// MARK: - Virtual Pet növləri
enum PetType: String, Codable, CaseIterable {
    case panda, pisik, it, dinozavr, aslan, peleng, unicorn, dovsan

    var emoji: String {
        switch self {
        case .panda: return "🐼"
        case .pisik: return "🐱"
        case .it: return "🐶"
        case .dinozavr: return "🦖"
        case .aslan: return "🦁"
        case .peleng: return "🐯"
        case .unicorn: return "🦄"
        case .dovsan: return "🐰"
        }
    }

    var adi: String {
        switch self {
        case .panda: return "Panda"
        case .pisik: return "Pişik"
        case .it: return "İt"
        case .dinozavr: return "Dinozavr"
        case .aslan: return "Aslan"
        case .peleng: return "Pələng"
        case .unicorn: return "Unicorn"
        case .dovsan: return "Dovşan"
        }
    }
}

// MARK: - Tapşırığın statusu
enum TaskStatus: String, Codable {
    case gozleyir        // uşağa verilib, hələ etməyib
    case tesdiqBekleyir  // uşaq "Etdim!" düyməsini basıb, valideyn təsdiqini gözləyir
    case tesdiqlendi     // valideyn təsdiqləyib, mükafat verilib
}

// MARK: - Uşaq tapşırığı
struct KidTask: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var iconName: String        // SF Symbol adı, məs: "book.fill", "house.fill"
    var mukafatPul: Double      // manat
    var mukafatXal: Int
    var status: TaskStatus = .gozleyir
}

// MARK: - Balans hərəkəti (tarixçə üçün)
struct TransactionRecord: Identifiable, Codable {
    var id: UUID = UUID()
    var tarix: Date = Date()
    var basliq: String
    var mebleg: Double   // müsbət = daxil olma
}

// MARK: - Qənaət hədəfinin prioriteti
enum GoalPriority: String, Codable, CaseIterable {
    case lazimdir, isteyirem, ehtiyat

    var basliq: String {
        switch self {
        case .lazimdir: return "Lazımdır"
        case .isteyirem: return "İstəyirəm"
        case .ehtiyat: return "Ehtiyat"
        }
    }

    var emoji: String {
        switch self {
        case .lazimdir: return "✅"
        case .isteyirem: return "⭐️"
        case .ehtiyat: return "🛡️"
        }
    }
}

// MARK: - Maliyyə hadisəsinin növü (FinancialSkills üçün)
enum FinancialEventType: String, Codable {
    case hedefYaradildi   // yeni qənaət hədəfi açıldı
    case qenaetEdildi     // gündəlik qənaət edildi
    case hedefTamamlandi  // hədəfə çatıldı
    case esyaAlindi       // marketten əşya satın alındı
}

// MARK: - Maliyyə hadisəsi qeydi (FinancialSkillsView üçün)
struct FinancialEvent: Identifiable, Codable {
    var id: UUID = UUID()
    var tarix: Date = Date()
    var tip: FinancialEventType
    var hedefId: UUID? = nil
    var mebleg: Double = 0
    var xal: Int = 0
    var aciqlama: String
}

// MARK: - Qənaət Hədəfi (məs: Velosiped almaq)
struct SavingsGoal: Identifiable, Codable {
    var id: UUID = UUID()
    var basliq: String
    var emoji: String
    var hedefMebleg: Double
    var yigilanMebleg: Double = 0
    var gunlukMebleg: Double
    var sonYatirimTarixi: Date? = nil
    var tamamlanib: Bool = false
    var prioritet: GoalPriority? = nil

    var faiz: Double {
        guard hedefMebleg > 0 else { return 0 }
        return min(yigilanMebleg / hedefMebleg, 1.0)
    }
}

// Hazır hədəf şablonları - uşaq bunlardan seçə bilər
struct SavingsGoalTemplate: Identifiable {
    var id: String { basliq }
    var basliq: String
    var emoji: String
    var tovsiyeMebleg: Double
}

enum MarketCategory: String, Codable, CaseIterable {
    case bina, tebiet, idman, dekorasiya

    var basliq: String {
        switch self {
        case .bina: return "Binalar"
        case .tebiet: return "Təbiət"
        case .idman: return "İdman"
        case .dekorasiya: return "Dekorasiya"
        }
    }
}

// MARK: - Market Əşyası (Mini-Şəhər üçün)
struct MarketItem: Identifiable, Codable, Equatable {
    var id: String        // sabit unikal id, məs: "agac1"
    var ad: String
    var emoji: String
    var qiymet: Int       // xal ilə ödənilir
    var kateqoriya: MarketCategory
    var unlockSeviyyesi: Int = 1   // bu Şəhər Səviyyəsinə çatmadan market-də satın alınmır
}

// MARK: - Şəhərdə bir əşyanın azad mövqeyi (0...1 nisbi koordinat)
struct CityPosition: Codable, Equatable {
    var x: Double
    var y: Double
}

// MARK: - Real Life Missions

/// Missiyanın aid olduğu kateqoriya - hər gün fərqli kateqoriyalardan qarışıq seçilir
enum MissionCategory: String, Codable, CaseIterable {
    case mesuliyyet, maliyyeVerdish, etrafMuhit, xeyirxahliq, tehsil, saglamliq

    var basliq: String {
        switch self {
        case .mesuliyyet: return "Məsuliyyət"
        case .maliyyeVerdish: return "Maliyyə Vərdişi"
        case .etrafMuhit: return "Ətraf Mühit"
        case .xeyirxahliq: return "Xeyirxahlıq"
        case .tehsil: return "Təhsil"
        case .saglamliq: return "Sağlamlıq"
        }
    }

    var emoji: String {
        switch self {
        case .mesuliyyet: return "🏠"
        case .maliyyeVerdish: return "💰"
        case .etrafMuhit: return "🌍"
        case .xeyirxahliq: return "❤️"
        case .tehsil: return "📚"
        case .saglamliq: return "🏃"
        }
    }
}

/// Kataloqdakı sabit missiya tərifi - real vaxt datası deyil, şablon kimidir
struct RealLifeMission: Identifiable, Codable {
    var id: String
    var title: String
    var emoji: String
    var kateqoriya: MissionCategory
    var niyeVacibdir: String
    var mukafatPul: Double
    var mukafatXal: Int
    var mukafatSeherProqresi: Int
    var mukafatXosbextlik: Int
}

/// Konkret bir uşağa, konkret bir günə təyin olunmuş missiya nüsxəsi
struct AssignedMission: Identifiable, Codable {
    var id: UUID = UUID()
    var missionId: String
    var tarix: Date = Date()
    var status: TaskStatus = .gozleyir
}


struct ChildProfile: Identifiable, Codable {
    var id: UUID = UUID()
    var ad: String
    var pet: PetType
    var balans: Double = 0
    var xal: Int = 0
    var tasks: [KidTask] = []
    var tarixce: [TransactionRecord] = []

    // Qənaət hədəfləri
    var qenaetHedefleri: [SavingsGoal] = []

    // Mini-Şəhər: hər sahib olunan əşyanın dünyadakı azad mövqeyi
    var sehirYerlesimi: [String: CityPosition] = [:]
    // Satın alınmış əşyaların id-ləri
    var sahibOlduguEsyalar: [String] = []
    // Gündəlik çevirmə çarxı üçün son tarix
    var sonCevirmeTarixi: Date? = nil

    // Real Life Missions
    var xosbextlik: Int = 60                        // 0...100 - şəhərin əhval-ruhiyyəsi
    var seherProqresi: Int = 0                       // City Level sisteminin əsasını təşkil edəcək məcmu xal
    var gunlukMissiyalar: [AssignedMission] = []     // bu günə təyin olunmuş missiyalar
    var sonMissiyaTarixi: Date? = nil                // günlük missiyaların nə vaxt yaradıldığı
    var tamamlanmisMissiyaIdleri: [String] = []      // təkrarın qarşısını almaq üçün son tamamlananlar

    // Maliyyə bacarıqları üçün hadisə qeydləri
    var maliyyeQeydleri: [FinancialEvent] = []
}

// MARK: - Valideyn hesabı
struct ParentProfile: Codable {
    var ad: String
    var pin: String              // Valideyn Rejiminə keçid üçün 4 rəqəmli PIN
    var children: [ChildProfile] = []
}
