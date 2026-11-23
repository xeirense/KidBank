import Foundation
import Combine

/// Bütün app-ın "beyni". Bütün ekranlar buradan data oxuyur/yazır.
/// Hələlik data telefonda lokal saxlanılır (UserDefaults + JSON).
final class DataStore: ObservableObject {

    @Published var parent: ParentProfile? {
        didSet { save() }
    }

    /// Hazırda Uşaq Rejimindəyiksə, hansı uşağın kartına baxırıq
    @Published var aktivChildId: UUID?

    /// Valideyn Rejimindəyikmi (PIN ilə açılır)
    @Published var valideynRejimindeyik: Bool = false

    private let saveKey = "parentProfileData_v1"

    init() {
        load()
        aktivChildId = parent?.children.first?.id
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else { return }
        if let decoded = try? JSONDecoder().decode(ParentProfile.self, from: data) {
            self.parent = decoded
        }
    }

    private func save() {
        guard let parent = parent else { return }
        if let encoded = try? JSONEncoder().encode(parent) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    // MARK: - Qeydiyyat

    func qeydiyyatiTamamla(valideynAdi: String, pin: String, usaqAdi: String, pet: PetType) {
        var yeniUsaq = ChildProfile(ad: usaqAdi, pet: pet)
        // Nümunə tapşırıqlar - MVP üçün əvvəlcədən doldurulub
        yeniUsaq.tasks = [
            KidTask(title: "Ev tapşırıqlarını həll et", iconName: "book.fill", mukafatPul: 2, mukafatXal: 10),
            KidTask(title: "Otağını yığışdır", iconName: "house.fill", mukafatPul: 1.5, mukafatXal: 8),
            KidTask(title: "Dişlərini fırçala", iconName: "sparkles", mukafatPul: 0.5, mukafatXal: 5)
        ]
        let yeniValideyn = ParentProfile(ad: valideynAdi, pin: pin, children: [yeniUsaq])
        self.parent = yeniValideyn
        self.aktivChildId = yeniUsaq.id
    }

    // MARK: - Uşaq əməliyyatları

    func uşaqTapsirigiTamamladi(childId: UUID, taskId: UUID) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }),
              let tIdx = parent.children[cIdx].tasks.firstIndex(where: { $0.id == taskId }) else { return }
        parent.children[cIdx].tasks[tIdx].status = .tesdiqBekleyir
        self.parent = parent
    }

    // MARK: - Valideyn əməliyyatları

    func valideynTesdiqEtsin(childId: UUID, taskId: UUID) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }),
              let tIdx = parent.children[cIdx].tasks.firstIndex(where: { $0.id == taskId }) else { return }

        var task = parent.children[cIdx].tasks[tIdx]
        guard task.status == .tesdiqBekleyir else { return }

        task.status = .tesdiqlendi
        parent.children[cIdx].tasks[tIdx] = task
        parent.children[cIdx].balans += task.mukafatPul
        parent.children[cIdx].xal += task.mukafatXal
        parent.children[cIdx].tarixce.insert(
            TransactionRecord(basliq: task.title, mebleg: task.mukafatPul),
            at: 0
        )
        self.parent = parent
    }

    func valideynRedEtsin(childId: UUID, taskId: UUID) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }),
              let tIdx = parent.children[cIdx].tasks.firstIndex(where: { $0.id == taskId }) else { return }
        parent.children[cIdx].tasks[tIdx].status = .gozleyir
        self.parent = parent
    }

    func yeniTapsirigEle(childId: UUID, title: String, icon: String, pul: Double, xal: Int) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }) else { return }
        let yeni = KidTask(title: title, iconName: icon, mukafatPul: pul, mukafatXal: xal)
        parent.children[cIdx].tasks.append(yeni)
        self.parent = parent
    }

    // MARK: - Hesabdan çıxış

    /// Bütün lokal datanı silir və Qeydiyyat ekranına qaytarır - demo göstərmək
    /// və ya başqa hesabla yenidən başlamaq üçün.
    func hesabdanCixis() {
        UserDefaults.standard.removeObject(forKey: saveKey)
        self.parent = nil
        self.aktivChildId = nil
        self.valideynRejimindeyik = false
    }

    func aktivChild() -> ChildProfile? {
        parent?.children.first(where: { $0.id == aktivChildId })
    }

    // MARK: - Qənaət Hədəfləri

    func yeniHedefElaEt(childId: UUID, basliq: String, emoji: String, hedefMebleg: Double, gunlukMebleg: Double,
                        prioritet: GoalPriority? = nil) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }) else { return }
        let yeni = SavingsGoal(basliq: basliq, emoji: emoji, hedefMebleg: hedefMebleg,
                               gunlukMebleg: gunlukMebleg, prioritet: prioritet)
        parent.children[cIdx].qenaetHedefleri.append(yeni)
        parent.children[cIdx].maliyyeQeydleri.append(
            FinancialEvent(tip: .hedefYaradildi, hedefId: yeni.id, mebleg: hedefMebleg, aciqlama: basliq)
        )
        self.parent = parent
    }

    /// Uşaq gündə bir dəfə "Bu günkü qənaəti et" deyə bilər - balansından hədəfə pul köçürülür.
    /// Eyni gün ikinci dəfə etməyə çalışsa, heç nə baş vermir (artıq isBugunEdilib true olacaq).
    @discardableResult
    func buGunkuQenaetiEt(childId: UUID, goalId: UUID) -> Bool {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }),
              let gIdx = parent.children[cIdx].qenaetHedefleri.firstIndex(where: { $0.id == goalId }) else { return false }

        var goal = parent.children[cIdx].qenaetHedefleri[gIdx]

        if let son = goal.sonYatirimTarixi, Calendar.current.isDateInToday(son) { return false }
        guard !goal.tamamlanib else { return false }
        guard parent.children[cIdx].balans >= goal.gunlukMebleg else { return false }

        parent.children[cIdx].balans -= goal.gunlukMebleg
        goal.yigilanMebleg += goal.gunlukMebleg
        goal.sonYatirimTarixi = Date()

        var bonusXal = 0
        if goal.yigilanMebleg >= goal.hedefMebleg && !goal.tamamlanib {
            goal.tamamlanib = true
            bonusXal = FinancialSkillsEvaluator.hedefBonusuXal   // Hədəfi tamamlama bonusu
        }

        let simdi = Date()
        parent.children[cIdx].maliyyeQeydleri.append(
            FinancialEvent(tarix: simdi, tip: .qenaetEdildi, hedefId: goal.id,
                           mebleg: goal.gunlukMebleg, aciqlama: goal.basliq)
        )
        if bonusXal > 0 {
            parent.children[cIdx].maliyyeQeydleri.append(
                FinancialEvent(tarix: simdi, tip: .hedefTamamlandi, hedefId: goal.id,
                               xal: bonusXal, aciqlama: goal.basliq)
            )
        }

        parent.children[cIdx].qenaetHedefleri[gIdx] = goal
        parent.children[cIdx].xal += bonusXal
        self.parent = parent
        return true
    }

    func isBugunEdilib(_ goal: SavingsGoal) -> Bool {
        guard let son = goal.sonYatirimTarixi else { return false }
        return Calendar.current.isDateInToday(son)
    }

    // MARK: - Mini-Şəhər / Market

    func esyaSatinAl(childId: UUID, item: MarketItem) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }) else { return }
        guard parent.children[cIdx].xal >= item.qiymet else { return }
        guard !parent.children[cIdx].sahibOlduguEsyalar.contains(item.id) else { return }

        parent.children[cIdx].xal -= item.qiymet
        parent.children[cIdx].sahibOlduguEsyalar.append(item.id)
        parent.children[cIdx].maliyyeQeydleri.append(
            FinancialEvent(tip: .esyaAlindi, xal: item.qiymet, aciqlama: item.ad)
        )
        // Əşya alınan kimi avtomatik şəhərdə peyda olur - anbar yoxdur
        parent.children[cIdx].sehirYerlesimi[item.id] = CityLayout.bashlangicMovqeyi(item: item)
        self.parent = parent
    }

    /// Uşaq əşyanı barmaqla sürüşdürüb buraxanda yeni mövqeni yadda saxlayır
    func esyaninYeriniYenile(childId: UUID, itemId: String, x: Double, y: Double) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }) else { return }
        parent.children[cIdx].sehirYerlesimi[itemId] = CityPosition(x: x, y: y)
        self.parent = parent
    }

    /// Əşyanı tamamilə şəhərdən çıxarır (uzun basıb "Sil" seçiləndə)
    func esyaniSehirdenSil(childId: UUID, itemId: String) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }) else { return }
        parent.children[cIdx].sehirYerlesimi.removeValue(forKey: itemId)
        parent.children[cIdx].sahibOlduguEsyalar.removeAll { $0 == itemId }
        self.parent = parent
    }

    /// Gündə bir dəfə fırlana bilən bonus çarxı. Uğurlu olarsa, qazanılan xal sayını qaytarır (0 = artıq fırlanıb).
    @discardableResult
    func gunlukCarxiCevir(childId: UUID) -> Int {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }) else { return 0 }

        if let son = parent.children[cIdx].sonCevirmeTarixi, Calendar.current.isDateInToday(son) {
            return 0
        }

        let mukafatlar = [5, 8, 10, 12, 15, 20]
        let qazanilan = mukafatlar.randomElement() ?? 5

        parent.children[cIdx].xal += qazanilan
        parent.children[cIdx].sonCevirmeTarixi = Date()
        self.parent = parent
        return qazanilan
    }

    func buGunCevrilibmi(childId: UUID) -> Bool {
        guard let child = parent?.children.first(where: { $0.id == childId }),
              let son = child.sonCevirmeTarixi else { return false }
        return Calendar.current.isDateInToday(son)
    }

    // MARK: - Real Life Missions

    /// Gündə bir dəfə çağırılmalıdır (məs. MissionsView açılanda). Əgər bu gün üçün
    /// artıq missiya yaradılıbsa heç nə etmir. Yaratmırsa: son 15 tamamlanmış missiyanı
    /// çıxarıb qalan hovuzdan, mümkün qədər fərqli kateqoriyalardan, 1-3 missiya seçir.
    func bugunkuMissiyalariYarat(childId: UUID) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }) else { return }

        if let son = parent.children[cIdx].sonMissiyaTarixi, Calendar.current.isDateInToday(son) {
            return
        }

        let sonTamamlananlar = Set(parent.children[cIdx].tamamlanmisMissiyaIdleri.suffix(15))
        let hovuz = RealLifeMissionCatalog.missiyalar.filter { !sonTamamlananlar.contains($0.id) }
        let istifadeOlunacaqHovuz = hovuz.isEmpty ? RealLifeMissionCatalog.missiyalar : hovuz

        var secilenler: [RealLifeMission] = []
        var istifadeOlunanKateqoriyalar: Set<MissionCategory> = []

        for kateqoriya in MissionCategory.allCases.shuffled() {
            guard secilenler.count < 3 else { break }
            if let namizet = istifadeOlunacaqHovuz.first(where: { $0.kateqoriya == kateqoriya && !istifadeOlunanKateqoriyalar.contains($0.kateqoriya) }) {
                secilenler.append(namizet)
                istifadeOlunanKateqoriyalar.insert(kateqoriya)
            }
        }
        // Əgər 3-ə çatmadısa, qalan hovuzdan təsadüfi tamamla
        while secilenler.count < 3, let elave = istifadeOlunacaqHovuz.filter({ m in !secilenler.contains(where: { $0.id == m.id }) }).randomElement() {
            secilenler.append(elave)
        }

        parent.children[cIdx].gunlukMissiyalar = secilenler.map { AssignedMission(missionId: $0.id) }
        parent.children[cIdx].sonMissiyaTarixi = Date()
        self.parent = parent
    }

    func missiyaTamamlandi(childId: UUID, assignedId: UUID) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }),
              let mIdx = parent.children[cIdx].gunlukMissiyalar.firstIndex(where: { $0.id == assignedId }) else { return }
        parent.children[cIdx].gunlukMissiyalar[mIdx].status = .tesdiqBekleyir
        self.parent = parent
    }

    func missiyaTesdiqle(childId: UUID, assignedId: UUID) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }),
              let mIdx = parent.children[cIdx].gunlukMissiyalar.firstIndex(where: { $0.id == assignedId }),
              let mission = RealLifeMissionCatalog.tap(parent.children[cIdx].gunlukMissiyalar[mIdx].missionId) else { return }

        guard parent.children[cIdx].gunlukMissiyalar[mIdx].status == .tesdiqBekleyir else { return }

        parent.children[cIdx].gunlukMissiyalar[mIdx].status = .tesdiqlendi
        parent.children[cIdx].balans += mission.mukafatPul
        parent.children[cIdx].xal += mission.mukafatXal
        parent.children[cIdx].seherProqresi += mission.mukafatSeherProqresi
        parent.children[cIdx].xosbextlik = min(100, parent.children[cIdx].xosbextlik + mission.mukafatXosbextlik)
        parent.children[cIdx].tamamlanmisMissiyaIdleri.append(mission.id)
        if mission.mukafatPul > 0 {
            parent.children[cIdx].tarixce.insert(
                TransactionRecord(basliq: mission.title, mebleg: mission.mukafatPul), at: 0
            )
        }
        self.parent = parent
    }

    func missiyaRedEt(childId: UUID, assignedId: UUID) {
        guard var parent = parent,
              let cIdx = parent.children.firstIndex(where: { $0.id == childId }),
              let mIdx = parent.children[cIdx].gunlukMissiyalar.firstIndex(where: { $0.id == assignedId }) else { return }
        parent.children[cIdx].gunlukMissiyalar[mIdx].status = .gozleyir
        self.parent = parent
    }
}
