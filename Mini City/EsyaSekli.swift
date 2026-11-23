import SwiftUI

/// Əşyanın vizual görünüşü.
/// Assets.xcassets-də item.id adında Image Set varsa onu göstərir,
/// yoxdursa GameSprite-dan xüsusi çəkilmiş oyun sprite-ı istifadə edir.
struct EsyaSekli: View {
    let item: MarketItem
    var olcu: CGFloat = 36

    var body: some View {
        if UIImage(named: item.id) != nil {
            Image(item.id)
                .resizable()
                .scaledToFit()
                .frame(width: olcu, height: olcu)
        } else {
            GameSprite(itemId: item.id, olcu: olcu)
        }
    }
}
