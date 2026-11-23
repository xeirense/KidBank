# KidBank 🏦

**Uşaqlar üçün oyunlaşdırılmış maliyyə tətbiqi**
*A gamified financial literacy app for children*

---

## Haqqında / About

KidBank — uşaqlara pul idarəetməsini, qənaəti və maliyyə məsuliyyətini **oyun vasitəsilə** öyrədən iOS tətbiqidir.

Valideyn uşağa tapşırıqlar verir, uşaq tapşırıqları yerinə yetirərək virtual pul qazanır, qənaət hədəfləri qoyur, Mini City-sini inkişaf etdirir.

> Built with SwiftUI for iOS. No third-party dependencies.

---

## Xüsusiyyətlər / Features

### 👦 Uşaq tərəfi
| Bölmə | Funksiya |
|-------|---------|
| **Virtual Kart** | Uşağın balansı, tapşırıqlar və mükafatlar |
| **Mini City** | Qazanılan pullarla şəhər tikmək, əşyalar almaq |
| **Qənaət Hədəfləri** | Hədəf qoy, pul yığ, mükafat al |
| **Fırlan Çarx** | Bonus xallar qazanmaq üçün oyun |
| **Maliyyə Bacarıqları** | Şəxsi maliyyə statistikası |

### 👨‍👩‍👧 Valideyn tərəfi
| Bölmə | Funksiya |
|-------|---------|
| **Valideyn Paneli** | Uşağın aktivliyini izlə |
| **Tapşırıq əlavə et** | Ev işləri, öhdəliklər, hədəflər |
| **Mükafat sistemi** | Tapşırıq üçün pul miqdarı təyin et |
| **Maliyyə hesabatı** | Uşağın qənaət davranışlarını analiz et |

---

## Texnologiya / Tech Stack

- **Platform**: iOS 17+
- **Dil / Language**: Swift 5.9
- **UI Framework**: SwiftUI
- **Arxitektura**: ObservableObject + EnvironmentObject
- **Saxlama / Storage**: UserDefaults (JSON encoding)
- **Qrafika**: Custom SwiftUI `Shape` / `Path` sprites (no external assets)

---

## Layihə Strukturu / Project Structure

```
KidBank/
├── Navigation/          # App entry, tab views, root navigation
├── Modeller ve Data/    # Models, AppTheme, FinancialSkillsEvaluator
├── Kart Bolmesi/        # Virtual card & task card views
├── Mini City/           # Game city: sprites, market, missions, spin wheel
├── Qenaet Bolmesi/      # Savings goals, DataStore, financial skills
├── Valideyn Paneli/     # Parent dashboard & add task flow
└── Qeydiyyat ve Giris/  # Registration & PIN lock
```

---

## Quraşdırma / Installation

1. Repo-nu klonla:
   ```bash
   git clone https://github.com/xeirense/KidBank.git
   cd KidBank
   ```
2. `111.xcodeproj` faylını Xcode ilə aç
3. Simulator və ya real cihaz seç
4. **Run** (`⌘R`)

> Minimum Xcode 15, iOS 17 SDK tələb olunur.

---

## Skrinşotlar / Screenshots

*Tezliklə əlavə ediləcək / Coming soon*

---

## Lisenziya / License

Bu layihə innovasiya məqsədi ilə hazırlanmışdır.
*This project was built as an innovation showcase.*
