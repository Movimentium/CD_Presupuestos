//  PresupuestoDetailScreen.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 28/3/25.
import SwiftUI

struct PresupuestoDetailScreen: View {
    @Environment(\.managedObjectContext) private var moc
    let presupuesto: CDPresupuesto
    @State private var concepto = ""
    @State private var cantidad: Double?
    
    var body: some View {
        Form {
            Section("Nuevo Gasto") {
                TextField("Concepto", text: $concepto)
                TextField("Cantidad", value: $cantidad, format: .number)
                    .keyboardType(.numberPad)
                Button {
                    addNewGasto()
                } label: {
                    Text("Guardar")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isFormValid)
                
            }
        }
        .navigationTitle(presupuesto.title ?? "")
    }
    
    private var isFormValid: Bool {
        !concepto.isEmptyOrWhiteSpace && Double(cantidad ?? 0) > 0
    }
    
    private func addNewGasto() {
        let gasto = CDGasto(context: moc)
        gasto.concepto = concepto
        gasto.cantidad = cantidad ?? 0
        gasto.fecha = Date.now
        presupuesto.addToGastos(gasto)
        
        do {
            try moc.save()
            concepto = ""
            cantidad = nil
        } catch {
            print(error)
        }
    }
}




#Preview {
    NavigationStack {
        PresupuestoDetailScreen(presupuesto: CDProvider.presupuestoTest)
            .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
    }
}
