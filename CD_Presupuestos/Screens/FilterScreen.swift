//  FilterScreen.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 2/4/25.
import SwiftUI
import CoreData

struct FilterScreen: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) private var gastos: FetchedResults<CDGasto>
    @State private var gastosFiltrados: [CDGasto] = []
    @State private var tags: Set<CDTag> = []
    @State private var minPrice: Double?
    @State private var maxPrice: Double?
    @State private var concepto = ""
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Section("Filtrar por tags") {
                TagsView(selectedTags: $tags)
                    .padding(.bottom)
                    .onChange(of: tags, filtrarPorTags)
            }
            
            Section("Filtrar por precio") {
                TextField("Min", value: $minPrice, format: .number)
                TextField("Max", value: $maxPrice, format: .number)
                Button("Filtrar") {
                    filtrarPorPrecio()
                }
                .padding(.bottom)
            }
            
            Section("Filtrar por concepto") {
                TextField("Concepto", text: $concepto)
                Button("Filtrar") {
                    filtrarPorConcepto()
                }
            }
            
            List(gastosFiltrados) { gasto in
                GastoCellView(gasto: gasto)
            }
            Spacer()
            
            Button("Mostrar todos los gatos") {
                tags = []
                gastosFiltrados = Array(gastos)
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .navigationTitle("Filtrar Gastos")
    }
    
    private func filtrarPorTags() {
        if !tags.isEmpty {
            let tagsNombres = tags.map { $0.nombre }
            let fr = CDGasto.fetchRequest()
            fr.predicate = NSPredicate(format: "ANY tags.nombre IN %@", tagsNombres)
            filtrar(conFetchRequest: fr)
        }
    }
    
    private func filtrarPorPrecio() {
        guard let minPrice, let maxPrice else { return }
        let min = NSNumber(value: minPrice)
        let max = NSNumber(value: maxPrice)
        let fr = CDGasto.fetchRequest()
        fr.predicate = NSPredicate(format: "cantidad >= %@ AND cantidad <= %@", min, max)
        filtrar(conFetchRequest: fr)
    }
    
    private func filtrarPorConcepto() {
        let fr = CDGasto.fetchRequest()
        fr.predicate = NSPredicate(format: "concepto BEGINSWITH %@", concepto)
        filtrar(conFetchRequest: fr)
    }
    
    private func filtrar(conFetchRequest fr: NSFetchRequest<CDGasto>) {
        do {
            gastosFiltrados = try moc.fetch(fr)
        } catch {
            print(error)
        }
    }
}

#Preview {
    NavigationStack {
        FilterScreen()
            .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
    }
}
