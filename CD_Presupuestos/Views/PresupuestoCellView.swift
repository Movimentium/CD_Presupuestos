//  PresupuestoCellView.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 27/3/25.
import SwiftUI

struct PresupuestoCellView: View {
    let p: CDPresupuesto
    private let currencyCode = Locale.current.currency?.identifier ?? ""

    var body: some View {
        HStack {
            Text(p.title ?? "")
            Spacer()
            Text(p.cantidad, format: .currency(code: currencyCode))
        }
    }
}

#Preview {
    PresupuestoCellView(p: CDProvider.presupuestoTest)
}
