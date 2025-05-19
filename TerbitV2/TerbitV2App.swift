//
//  TerbitV2App.swift
//  TerbitV2
//
//  Created by Ciko Edo Febrian on 07/05/25.
//

import SwiftUI

// Import the CoreDataSeeder
import CoreData

@main
struct TerbitV2App: App {
    init() {
        // Initialize the seeder on app launch
        _ = CoreDataSeeder()
    }
    
    var body: some Scene {
        WindowGroup {
            MyRoutineView(myRoutineViewModel: MyRoutineViewModel(), collectiblesViewModel: CollectiblesViewModel(), levelViewModel: LevelsViewModel(), router: Router())
        }
    }
}
