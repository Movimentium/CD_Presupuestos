//  CDProvider_Extension.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 27/3/25.
import Foundation

extension CDProvider {
    static let previewInstance: CDProvider = {
        let provider = CDProvider(isForPreview: true)
        
        let entretenimiento = CDPresupuesto(context: provider.moc)
        entretenimiento.title = "entretenimiento"
        entretenimiento.cantidad = 500
        entretenimiento.fecha = Date.now
        
        do {
            try provider.moc.save()
        } catch {
            print(#function, error)
        }
        // Alternative: try? provider.moc.safe

        return provider
    }()
}
