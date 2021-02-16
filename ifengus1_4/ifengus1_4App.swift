//
//  ifengus1_4App.swift
//  ifengus1_4
//
//  Created by Alan Yang on 2/16/21.
//

import SwiftUI

@main
struct ifengus1_4App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AppMainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
