//
//  thy_cuzdan_qrApp.swift
//  thy-cuzdan-qr
//
//  Created by MacBook on 22.05.2024.
//

import SwiftUI

@main
struct thy_cuzdan_qrApp: App {
    let persistenceController = PersistenceController.shared

        var body: some Scene {
            WindowGroup {
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
