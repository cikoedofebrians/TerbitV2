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
        seedLevels()
        seedSkins()
        UserDefaults.standard.set(true, forKey: hasSeededKey)
    }
    
    func seedCollectibles() {
        // Common collectibles
        seedCollectiblesFromRarity(.common, [
            "GoofyMentari": "A playful and silly Mentari with a goofy expression.",
            "HolyMentari": "A sacred Mentari that radiates divine energy.",
            "Mentaread": "A studious Mentari who loves reading and learning.",
            "Santari": "A festive Mentari bringing holiday cheer.",
            "CoolMentari": "A trendy Mentari with undeniable swagger.",
            "DevilMentari": "A devilish Mentari with a mischievous grin."
        ])
        
        // Epic collectibles
        seedCollectiblesFromRarity(.rare, [
            "Emontari": "A deeply emotional Mentari expressing intense feelings.",
            "MusicMentari": "A melodious Mentari who brings harmony wherever it goes.",
            "Sigmentari": "A Mentari with unique signature style.",
            "Menchaplin": "A classic Mentari inspired by silent film stars.",
            "RacerMentari": "A speedy Mentari who loves racing and speed."
        ])
        
        // Rare collectibles
        seedCollectiblesFromRarity(.epic, [
            "Mystari": "A mysterious Mentari shrouded in enigmatic energy.",
            "Miniontari": "A cute and cuddly Mentari with a playful spirit.",
            "Choppertari": "A legendary Mentari with a unique chopper design."
        ])
        
        // Legendary collectibles
        seedCollectiblesFromRarity(.legendary, [
            "UzumakiMentari": "A spiraling legendary Mentari with incredible power.",
            "PokerMentari": "A legendary Mentari with unmatched poker face and strategy.",
        ])
        
        do {
            try service.save()
        } catch {
            print("Error saving seeded collectibles: \(error)")
        }
    }
    
    func seedSkins() {
        do {
            let context = service.managedObjectContext
            
            let collectibles = try service.fetch(Collectible.self)
            
            let skins: [String: [String: String]] = [
                "Default" : [
                    "beforeRoutine" : "MentariBeforeRoutine",
                    "afterRoutine" : "MentariAfterRoutine",
                    "dizzy" : "MentariDizzy",
                    "congratulations" : "MentariCongratulations",
                ],
                "Poker Mentari" : [
                    "beforeRoutine" : "PokerMentariBeforeRoutine",
                    "afterRoutine" : "PokerMentariAfterRoutine",
                    "dizzy" : "PokerMentariDizzy",
                    "congratulations" : "PokerMentariCongratulations",
                ],
            ]
            
            for (name, properties) in skins {
                let skin = Skin(context: context)
                skin.setValue(UUID(), forKey: "id")
                skin.setValue(properties["beforeRoutine"], forKey: "beforeRoutine")
                skin.setValue(properties["afterRoutine"], forKey: "afterRoutine")
                skin.setValue(properties["dizzy"], forKey: "dizzy")
                skin.setValue(properties["congratulations"], forKey: "congratulations")
                skin.setValue(name == "Default" ? true : false, forKey: "used")
                skin.setValue(name, forKey: "name")
                
                if let collectible = collectibles.first(where: { $0.name == name }) {
                    skin.setValue(collectible, forKey: "collectible")
                }
            }
            
            try service.save()
        } catch {
            print("Error saving seeded skins: \(error)")
        }
    }
    
    func seedLevels() {
        do {
            let context = service.managedObjectContext
            let collectibles = try service.fetch(Collectible.self)
            
            let levelRewards: [Int: String] = [
                1: "Racer Mentari",
                2: "Mystari",
                3: "Uzumaki Mentari",
            ]
            
            for (levelNumber, collectibleName) in levelRewards {
                if let collectible = collectibles.first(where: { $0.name == collectibleName }) {
                    let level = Level(context: context)
                    level.setValue(UUID(), forKey: "id")
                    level.setValue(levelNumber, forKey: "number")
                    level.setValue(levelNumber * 100, forKey: "neededXP")
                    level.setValue(0, forKey: "currentXP")
                    
                    level.collectible =  collectible
                }
            }
            
            try service.save()
        } catch {
            print("Error fetching collectibles: \(error)")
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
//            collectible.setValue(false, forKey: "obtained")
            collectible.setValue(true, forKey: "obtained")
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
