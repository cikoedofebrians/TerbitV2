//
//  CollectiblesViewModel.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 14/05/25.
//

import Observation
import SwiftUI

@Observable
class CollectiblesViewModel {
    var collectibles: [Collectible] = [] {
        didSet {
            print("Collectibles updated")
        }
    }
    var dataService: DataService = .shared
    var isLoading: Bool = false
    
    init() {
        fetchCollectibles()
    }
    
    var collectiblesGroupedByRarity: [[Collectible]] {
        var result: [[Collectible]] = []
        for rarity in CollectibleRarity.allCases.reversed() {
            let collectiblesByRarity: [Collectible] = collectibles.filter { $0.rarity == rarity }
            result.append(collectiblesByRarity)
        }
        return result
    }
    
    func fetchCollectibles() {
        do {
            collectibles = try dataService.fetch(Collectible.self)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func unlockCollectible(_ collectible: Collectible) {
        do {
            collectible.obtained = true
            collectible.obtainedAt = Date()
            try dataService.save()
            fetchCollectibles()
        } catch {
            print(error.localizedDescription)
        }
    }
}
