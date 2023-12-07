//
//  exerciseApp.swift
//  exercise
//
//  Created by Jean paul on 2023-12-05.
//

import SwiftUI

@main
struct exerciseApp: App {
    private var dataController = DataController.shared
    // @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
