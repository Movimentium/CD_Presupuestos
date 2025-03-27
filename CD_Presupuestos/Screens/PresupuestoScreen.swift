//  PresupuestoScreen.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 26/3/25.
import SwiftUI

struct PresupuestoScreen: View {
    @FetchRequest(sortDescriptors: []) private var presupuestos: FetchedResults<CDPresupuesto>
    @State private var isShowing = false
    
    var body: some View {
        VStack {
            List(presupuestos) { p in
                PresupuestoCellView(p: p)
            }
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
    .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
}
