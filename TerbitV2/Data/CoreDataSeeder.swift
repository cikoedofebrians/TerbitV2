//
//  Seeder.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 13/05/25.
//

import CoreData

class CoreDataSeeder {
    let service: DataService = .shared
    
    init() {
        prepareSeed()
    }
    
    let hasSeededKey = "hasSeeded"
    
    func prepareSeed() {
        let hasBeenSeeded = UserDefaults.standard.bool(forKey: hasSeededKey)
        guard !hasBeenSeeded else { return }
        
        seedCollectibles()
        
        UserDefaults.standard.set(true, forKey: hasSeededKey)
    }
    
    func seedCollectibles() {
        // Common collectibles
        seedCollectiblesFromRarity(.common, [
            "GoofyMentari": "A playful and silly Mentari with a goofy expression.",
            "HolyMentari": "A sacred Mentari that radiates divine energy.",
            "Mentaread": "A studious Mentari who loves reading and learning.",
            "Santari": "A festive Mentari bringing holiday cheer."
        ])
        
        // Rare collectibles
        seedCollectiblesFromRarity(.rare, [
            "Menchaplin": "A classic Mentari inspired by silent film stars.",
            "Mystari": "A mysterious Mentari shrouded in enigmatic energy.",
            "Sigmentari": "A Mentari with unique signature style."
        ])
        
        // Epic collectibles
        seedCollectiblesFromRarity(.epic, [
            "EmoMentari": "A deeply emotional Mentari expressing intense feelings.",
            "CoolMentari": "A trendy Mentari with undeniable swagger.",
            "MusicMentari": "A melodious Mentari who brings harmony wherever it goes."
        ])
        
        // Legendary collectibles
        seedCollectiblesFromRarity(.legendary, [
            "UzumakiMentari": "A spiraling legendary Mentari with incredible power.",
            "Mintari": "The freshest and rarest Mentari of them all.",
            "PokerMentari": "A legendary Mentari with unmatched poker face and strategy."
        ])
        
        do {
            try service.save()
        } catch {
            print("Error saving seeded collectibles: \(error)")
        }
    }
    
    private func seedCollectiblesFromRarity(_ rarity: CollectibleRarity, _ collectibles: [String: String]) {
        let context = service.managedObjectContext
        
        for (name, description) in collectibles {
            // Format the name from camel case to normal text with spaces
            let formattedName = name.contains(" ") ? name : formatCamelCase(name)
            
            // Create entity
            let collectible = Collectible(context: context)
            
            collectible.setValue(UUID(), forKey: "id")
            collectible.setValue(formattedName, forKey: "name")
            collectible.setValue(name, forKey: "image")
            collectible.setValue(rarity.rawValue, forKey: "rarityValue")
            collectible.setValue(description, forKey: "desc")
            collectible.setValue(false, forKey: "obtained")
            collectible.setValue(nil, forKey: "obtainedAt")
        }
    }
    
    private func formatCamelCase(_ text: String) -> String {
        let spaced = text.replacingOccurrences(
            of: "([a-z])([A-Z])",
            with: "$1 $2",
            options: .regularExpression
        )
        
        return spaced
    }
}
