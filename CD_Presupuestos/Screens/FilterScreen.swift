//  FilterScreen.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 2/4/25.
import SwiftUI

struct FilterScreen: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) private var gastos: FetchedResults<CDGasto>
    @State private var gastosFiltrados: [CDGasto] = []
    @State private var tags: Set<CDTag> = []

    var body: some View {
        VStack(alignment: .leading) {
            Section("Filtrar por Tags") {
                TagsView(selectedTags: $tags)
                    .onChange(of: tags, filtrarTags)
            }
            List(gastosFiltrados) { gasto in
                GastoCellView(gasto: gasto)
            }
            Spacer()
            
            Button("Mostrar todos los gatos") {
                tags = []
                gastosFiltrados = Array(gastos)
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Filtrar Gastos")
    }
    
    private func filtrarTags() {
        if !tags.isEmpty {
            let tagsNombres = tags.map { $0.nombre }
            let fr = CDGasto.fetchRequest()
            fr.predicate = NSPredicate(format: "ANY tags.nombre IN %@", tagsNombres)
            do {
                gastosFiltrados = try moc.fetch(fr)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    NavigationStack {
        FilterScreen()
            .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
    }
}
