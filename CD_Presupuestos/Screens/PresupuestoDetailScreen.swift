//  PresupuestoDetailScreen.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 28/3/25.
import SwiftUI

struct PresupuestoDetailScreen: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) private var gastos: FetchedResults<CDGasto>

    let presupuesto: CDPresupuesto
    @State private var concepto = ""
    @State private var cantidad: Double?
    
    init(presupuesto: CDPresupuesto) {
        self.presupuesto = presupuesto
        let predicate = NSPredicate(format: "presupuesto == %@", presupuesto)
        _gastos = FetchRequest(sortDescriptors: [], predicate: predicate)
    }
    
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
            
            Section("Gastos") {
                List(gastos) { gasto in
                    HStack {
                        Text(gasto.concepto ?? "")
                        Spacer()
                        Text(gasto.cantidad, format: .currency(code: .currencyCode))
                    }
                }
                // REVISAR: otro enfoque
//                List(presupuesto.gastos?.allObjects as? [CDGasto] ?? [] ) { gasto in
//                    Text(gasto.concepto ?? "")
//                }
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
        PresupuestoDetailScreen(presupuesto: CDProvider.presupuestoTestComida)
            .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
    }
}
