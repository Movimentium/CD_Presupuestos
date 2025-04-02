//  FilterScreen.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 2/4/25.
import SwiftUI

struct FilterScreen: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var tags: Set<CDTag> = []
    @State private var gastosFiltrados: [CDGasto] = []
    
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
        }
        .padding()
        .navigationTitle("Filtrar")
    }
    
    private func filtrarTags() {
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

#Preview {
    NavigationStack {
        FilterScreen()
            .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
    }
}
