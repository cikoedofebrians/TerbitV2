//
//  CollectiblesViewModel.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 14/05/25.
//

import Observation
import SwiftUI

class CollectiblesViewModel: ObservableObject {
    @Published var collectibles: [Collectible] = []
    @Published var skins: [Skin] = []
    var dataService: DataService = .shared
    
    init() {
        fetchCollectibles()
        fetchSkins()
    }
    
    var currentSkinCollectible: Collectible? {
        currentSkin?.collectible
    }
    
    var currentSkin: Skin? {
        skins.first(where: { $0.used == true })
    }
    
    func unlockAllCollectibles() {
        do {
            for collectible in collectibles {
                if collectible.obtained == false {
                    collectible.obtained = true
                    collectible.obtainedAt = Date()
                }
            }
            try dataService.save()
            fetchCollectibles()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func lockAllCollectibles() {
        for collectible in collectibles {
            if collectible.obtained == true {
                collectible.obtained = false
                collectible.obtainedAt = nil
            }
        }
        changeSkin(collectible: nil)
    }
    
    func changeSkin(collectible: Collectible?) {
        do {
            currentSkin?.used = false
            if collectible != nil {
                collectible?.skin?.used = true
            } else {
                skins.first(where: { $0.name == "Default" })?.used = true
            }
            try dataService.save()
            fetchCollectibles()
            fetchSkins()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var collectiblesGroupedByRarity: [[Collectible]] {
        var result: [[Collectible]] = []
        for rarity in CollectibleRarity.allCases.reversed() {
            result.append(getCollectibleByRarity(rarity))
        }
        return result
    }
    
    func getCollectibleByRarity(_ rarity: CollectibleRarity) -> [Collectible] {
        return collectibles.filter { $0.rarity == rarity }
    }
    
    func fetchCollectibles() {
        do {
            collectibles = try dataService.fetch(Collectible.self)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchSkins() {
        do {
            skins = try dataService.fetch(Skin.self)
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
