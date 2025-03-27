//  AddPresupuestoScreen.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 27/3/25.
import SwiftUI

struct AddPresupuestoScreen: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var title = ""
    @State private var cantidad: Double?
    @State private var errorMsg = ""
    
    var body: some View {
        Form {
            Text("Nuevo Presupuesto")
                .font(.headline)

            TextField("Título", text: $title)
            TextField("Límite", value: $cantidad, format: .number)
                .keyboardType(.numberPad)
            Button {
                if CDPresupuesto.exist(moc: moc, title: title) {
                    errorMsg = "Ya existe el presupuesto: \(title)"
                } else {
                    guardarPresupuesto()
                }
            } label: {
                Text("Guardar")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            
            Text(errorMsg)
                .foregroundStyle(.red)
        }
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace && Double(cantidad ?? 0) > 0
    }
    
    private func guardarPresupuesto() {
        let presupuesto = CDPresupuesto(context: moc)
        presupuesto.title = title
        presupuesto.cantidad = cantidad ?? 0
        presupuesto.fecha = Date.now
        do {
            try moc.save()
            errorMsg = ""
        } catch {
            errorMsg = "No se podido guardar el presupuesto"
        }
    }
}

#Preview {
    AddPresupuestoScreen()
        .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
}
