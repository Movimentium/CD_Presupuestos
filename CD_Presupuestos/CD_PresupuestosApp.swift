//  CD_PresupuestosApp.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 26/3/25.
import SwiftUI

@main
struct CD_PresupuestosApp: App {
    let provider = CDProvider()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PresupuestoScreen()
            }
            .onAppear {
                @AppStorage("areTagsAdded") var areTagsAdded = false
                if !areTagsAdded {
                    do {
                        try TagSeeder(moc: provider.moc).seed()
                        areTagsAdded = true
                    } catch {
                        print(Self.self, #function, error)
                    }
                }
            }
            .environment(\.managedObjectContext, provider.moc)
        }
    }
}
