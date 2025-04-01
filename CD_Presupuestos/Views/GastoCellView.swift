//  GastoCellView.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 31/3/25
import SwiftUI

struct GastoCellView: View {
    let gasto: CDGasto

    var body: some View {
        VStack {
            HStack {
                Text(gasto.concepto ?? "")
                Spacer()
                Text(gasto.cantidad, format: .currency(code: .currencyCode))
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(gasto.tags as? Set<CDTag> ?? [])) { tag in
                        Text(tag.nombre ?? "")
                            .font(.caption)
                            .padding(6)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
        }
    }
}

#Preview {
    GastoCellView(gasto: CDProvider.gastoTestLeche)
}
