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
        VStack {
            Text(presupuesto.cantidad, format: .currency(code: .currencyCode)).font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
        }
        
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
                List {
                    VStack() {
                        HStack() {
                            Spacer()
                            Text("Total gastado")
                            Text(total, format: .currency(code: .currencyCode))
                        }
                        HStack() {
                            Spacer()
                            Text("Restante")
                            Text(restante, format: .currency(code: .currencyCode))
                                .foregroundStyle(restante < 0 ? .red : .green)
                        }
                    }
                    
                    ForEach(gastos) { gasto in
                        GastoCellView(gasto: gasto)
                    }
                    .onDelete(perform: deleteGasto)
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
    
    private func deleteGasto(_ indexSet: IndexSet) {
        indexSet.forEach { idx in
            let gasto = gastos[idx]
            moc.delete(gasto)
        }
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
    
    private var total: Double {
        return gastos.reduce(0) { total, gasto in
            total + gasto.cantidad
        }
    }
    
    private var restante: Double {
        presupuesto.cantidad - total
    }
}




#Preview {
    NavigationStack {
        PresupuestoDetailScreen(presupuesto: CDProvider.presupuestoTestComida)
            .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
    }
}

