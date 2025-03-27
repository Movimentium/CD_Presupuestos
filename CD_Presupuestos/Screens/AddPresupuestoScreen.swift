//  AddPresupuestoScreen.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 27/3/25.
import SwiftUI

struct AddPresupuestoScreen: View {
    @State private var title: String = ""
    @State private var limit: Double?
    
    var body: some View {
        Form {
            Text("Nuevo Presupuesto")
                .font(.headline)

            TextField("Título", text: $title)
            TextField("Límite", value: $limit, format: .number)
                .keyboardType(.numberPad)
            Button {
                // Action
            } label: {
                Text("Guardar")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
        }
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace && Double(limit ?? 0) > 0
    }
}

#Preview {
    AddPresupuestoScreen()
}
