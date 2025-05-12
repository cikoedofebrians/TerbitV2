//
//  Collectible.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 12/05/25.
//
import Foundation
import SwiftUI

enum CollectibleRarity: String, CaseIterable {
    case common
    case rare
    case epic
    case legendary
}

extension CollectibleRarity {
    var displayName: String {
        switch self {
        case .common:
            return "Common"
        case .rare:
            return "Rare"
        case .epic:
            return "Epic"
        case .legendary:
            return "Legendary"
        }
    }
}

struct Collectible: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let image: String
    let rarity: CollectibleRarity
    let obtainedAt: Date
    let locked: Bool
    
    init(name: String, image: String, rarity: CollectibleRarity, obtainedAt: Date, locked: Bool = true) {
        self.name = name
        self.image = image
        self.rarity = rarity
        self.obtainedAt = obtainedAt
        self.locked = locked
    }
}
