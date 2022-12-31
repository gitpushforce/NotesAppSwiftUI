//
//  NotasApp.swift
//  Notas
//
//  Created by masaki on 2022/12/29.
//

import SwiftUI

@main
struct NotasApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
