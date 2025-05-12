import Foundation

struct CollectibleData {
    static let dummyCollectibles: [Collectible] = [
        // Common collectibles
        Collectible(

            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 10),
            locked: false// 10 days ago
        ),
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 8),
            locked: false
        ),
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 5) // 5 days ago
        ),
        
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 5) // 5 days ago
        ),
        
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 5) // 5 days ago
        ),
        
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 5) // 5 days ago
        ),
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 5) // 5 days ago
        ),
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 5) // 5 days ago
        ),
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 5) // 5 days ago
        ),
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .common,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 5) // 5 days ago
        ),
        
        // Rare collectibles
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .rare,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 15) // 15 days ago
        ),
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .rare,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 7) // 7 days ago
        ),
        
        // Epic collectibles
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .epic,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 20) // 20 days ago
        ),
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .epic,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 3),
            locked: false // 3 days ago
        ),
        
        // Legendary collectibles
        Collectible(
            name: "Poker Mentari",
            image: "PokerMentari",
            rarity: .legendary,
            obtainedAt: Date().addingTimeInterval(-3600 * 24 * 30),
            locked: true // 30 days ago
        )
    ]
    
    // Helper method to get collectibles by rarity
    static func getCollectibles(byRarity rarity: CollectibleRarity) -> [Collectible] {
        return dummyCollectibles.filter { $0.rarity == rarity }
    }
    
    // Helper method to get all collectibles sorted by rarity (highest to lowest)
    static func getAllCollectiblesSortedByRarity() -> [[Collectible]] {
        var result: [[Collectible]] = []
        for rarity in CollectibleRarity.allCases.reversed() {
            result.append(getCollectibles(byRarity: rarity))
        }
        return result
    }
    
    // Helper method to get all collectibles sorted by obtainedAt (newest to oldest)
    static func getAllCollectiblesSortedByDate() -> [Collectible] {
        return dummyCollectibles.sorted { $0.obtainedAt > $1.obtainedAt }
    }
    
    // Helper method to convert rarity to numeric value for sorting
//    private static func getRarityValue(for rarity: CollectibleRarity) -> Int {
//        switch rarity {
//        case .common: return 1
//        case .rare: return 2
//        case .epic: return 3
//        case .legendary: return 4
//        }
//    }
} 
