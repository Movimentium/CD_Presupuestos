//  PresupuestoScreen.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 26/3/25.
import SwiftUI

struct PresupuestoScreen: View {
    @State private var isShowing = false
    
    var body: some View {
        VStack {
            Text("Aquí se mostrarán los presupuestos")
        }
        .navigationTitle("App Presupuestos")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Añadir Presupuesto") {
                    isShowing = true
                }
            }
        }
        .sheet(isPresented: $isShowing) {  
            AddPresupuestoScreen()
        }
    }
}

#Preview {
    NavigationStack {
        PresupuestoScreen()
    }
}
