//  GastoCellView.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 31/3/25
import SwiftUI

struct GastoCellView: View {
    let gasto: CDGasto

    var body: some View {
        HStack {
            Text(gasto.concepto ?? "")
            Spacer()
            Text(gasto.cantidad, format: .currency(code: .currencyCode))
        }
    }
}

#Preview {
    GastoCellView(gasto: CDProvider.gastoTestLeche)
}
