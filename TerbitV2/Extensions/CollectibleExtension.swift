//
//  EntityExtension.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//


enum CollectibleRarity: String, CaseIterable {
    case common
    case rare
    case epic
    case legendary
}


extension Collectible {
    var rarity: CollectibleRarity {
        switch self.rarityValue {
        case "common":
            return .common
        case "rare":
            return .rare
        case "epic":
            return .epic
        case "legendary":
            return .legendary
        default:
            return .common
        }
    }
}

