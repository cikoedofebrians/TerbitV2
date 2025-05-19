//
//  LevelsViewModel.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 15/05/25.
//
import SwiftUI

class LevelsViewModel: ObservableObject {
    @Published var levels: [Level] = []
    var dataService: DataService = .shared
    
    
    init() {
        fetchLevels()
    }
    
    var currentLevel: Level? {
        if let currentLevel = levels.first(where: { $0.currentXP < $0.neededXP }) {
            return currentLevel
        } else if let lastLevel = levels.last {
            return lastLevel
        }
        return nil
    }
    
    var currentLevelIndex: Int {
        if let currentLevel = levels.firstIndex(where: { $0.currentXP < $0.neededXP }) {
            return currentLevel
        } else if levels.count > 0 {
            return levels.count - 1
        }
        return 0
    }
    
    func unlockAllLevels() {
        do {
            for level in levels {
                
                level.currentXP = level.neededXP
            }
            try dataService.save()
            fetchLevels()
        } catch {
            print(error.localizedDescription)
        }
    }
    func lockAllLevels() {
        do {
            for level in levels {
                level.currentXP = 0
                if level.collectible?.obtained == true {
                    level.collectible?.obtained = false
                }
            }
            try dataService.save()
            fetchLevels()
        } catch {
            print(error.localizedDescription)
        }
    }
                    
    
    func checkIfCollectiblesUnopened() -> Bool {
        for i in (0...currentLevelIndex) {
            if levels[i].collectible?.obtained == false {
                return true
            }
        }
        return false
    }
    
    func checkIfLevelUnlocked(id: UUID) -> Bool {
        if let index = levels.firstIndex(where: { $0.id == id }) {
            if index == 0 || levels[index - 1].currentXP >= levels[index - 1].neededXP {
                return true
            }
        }
        return false
    }
    
    func addXPToLevel(xp: Int) {
        guard let currentLevel = currentLevel else { return }
        do {
            if currentLevel.neededXP - currentLevel.currentXP < Int64(xp) {
                if let levelIndex = levels.firstIndex(where: { $0.id == currentLevel.id }) {
                    if levelIndex < levels.count - 1 {
                        levels[levelIndex + 1].currentXP += abs((currentLevel.neededXP - currentLevel.currentXP) - Int64(xp))
                    }
                }
                currentLevel.currentXP = currentLevel.neededXP

            } else {
                currentLevel.currentXP += Int64(xp)
            }
            try dataService.save()
            fetchLevels()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchLevels() {
        do {
            let sortDescriptor = [NSSortDescriptor(key: "number", ascending: true)]
            levels = try dataService.fetch(Level.self, sortDescriptors: sortDescriptor)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
