import Foundation

/// Uşaq qənaət hədəfinin adını yazanda, bu, mətndəki açar sözlərə görə
/// ən uyğun emoji-ni tapır. Real AI API-si (Claude/GPT) client tətbiqinin
/// içindən birbaşa çağırılmır, çünki API açarını mobil app-da saxlamaq
/// təhlükəsiz deyil - bunun üçün ayrıca backend server lazımdır.
/// Bu açar-söz sistemi isə pulsuz, sürətli və tam offline işləyir.
enum SmartEmojiMatcher {
    private static let sozluk: [(acarSozler: [String], emoji: String)] = [
        (["velosiped", "bisiklet", "bike", "bicycle"], "🚲"),
        (["skuter", "scooter"], "🛴"),
        (["moped", "motosiklet", "motorbike"], "🏍️"),
        (["telefon", "phone", "iphone", "smartfon", "samsung"], "📱"),
        (["noutbuk", "laptop", "komputer", "kompüter", "notebook"], "💻"),
        (["oyuncaq", "toy", "ayı", "ayi", "kukla", "oyuncaq ayı"], "🧸"),
        (["kitab", "book", "roman"], "📚"),
        (["futbol", "football", "meydança"], "⚽️"),
        (["basketbol", "basketball"], "🏀"),
        (["voleybol", "volleyball"], "🏐"),
        (["saat", "watch", "smartwatch"], "⌚️"),
        (["ayaqqabı", "ayaqqabi", "krossovka", "shoes", "sneaker", "sneakers"], "👟"),
        (["oyun", "konsol", "playstation", "ps5", "ps4", "xbox", "nintendo", "switch", "game"], "🎮"),
        (["gitara", "guitar"], "🎸"),
        (["piano", "royal", "fortepiano"], "🎹"),
        (["kamera", "camera", "foto", "fotoaparat"], "📷"),
        (["it", "köpək", "kopek", "pes", "dog", "küçük"], "🐶"),
        (["pişik", "pisik", "pes pişik", "kot", "cat", "kitten"], "🐱"),
        (["paltar", "geyim", "dress", "jacket", "gödəkçə", "godekce", "kurtka"], "👕"),
        (["seyahət", "seyahet", "bilet", "travel", "trip", "sefer", "sefer bileti"], "✈️"),
        (["rəsm", "resm", "boya", "rəssamlıq", "cizgi", "art", "qələm"], "🎨"),
        (["dron", "drone"], "🚁"),
        (["dondurma", "ice cream", "morojnoye"], "🍦"),
        (["pizza"], "🍕"),
        (["ev", "house", "domik", "kukla evi"], "🏠"),
        (["musiqi", "music", "qulaqlıq", "qulaqliq", "headphone", "airpods"], "🎧"),
        (["planşet", "planshet", "ipad", "tablet"], "📱"),
        (["skateboard", "skeytbord"], "🛹"),
        (["lego", "konstruktor"], "🧱"),
        (["maşın", "masin", "car", "avtomobil"], "🚗"),
        (["dəniz", "deniz", "çimərlik", "cimerlik", "beach"], "🏖️"),
        (["park", "parkda", "attraksion", "lunapark"], "🎡"),
        (["çadır", "cadir", "kamp", "camping"], "⛺️"),
        (["dinozavr", "dinosaur"], "🦖"),
        (["unicorn", "vahiqarn"], "🦄"),
        (["balon", "balloon"], "🎈"),
        (["quru meyvə", "şirniyyat", "sirniyyat", "candy", "şokolad", "sokolad", "chocolate"], "🍫")
    ]

    /// Mətnə uyğun ən yaxşı emoji-ni qaytarır, uyğunluq tapılmasa ümumi hədiyyə emoji-si qaytarır.
    static func tap(_ metn: String) -> String {
        let kicik = metn.lowercased()
        guard !kicik.trimmingCharacters(in: .whitespaces).isEmpty else { return "🎯" }

        for (sozler, emoji) in sozluk {
            for soz in sozler where kicik.contains(soz) {
                return emoji
            }
        }
        return "🎁"
    }
}
