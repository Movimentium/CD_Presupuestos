//  CD_PresupuestosApp.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 26/3/25.
import SwiftUI

@main
struct CD_PresupuestosApp: App {
    let provider = CDProvider()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, provider.moc)
        }
    }
}
