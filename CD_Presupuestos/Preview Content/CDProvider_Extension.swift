//  CDProvider_Extension.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 27/3/25.
import Foundation

extension CDProvider {
    static let previewInstance: CDProvider = {
        let provider = CDProvider(isForPreview: true)
        
        let entretenimiento = CDPresupuesto(context: provider.moc)
        entretenimiento.title = "Entretenimiento"
        entretenimiento.cantidad = 500
        entretenimiento.fecha = Date.now
        
        let comida = CDPresupuesto(context: provider.moc)
        comida.title = "Comida"
        comida.cantidad = 200
        comida.fecha = Date.now
        
        
        do {
            try provider.moc.save()
        } catch {
            print(#function, error)
        }
        // Alternative: try? provider.moc.safe

        return provider
    }()
    
    static let presupuestoTest: CDPresupuesto = {
        let moc = CDProvider.previewInstance.moc
        let p = CDPresupuesto(context: moc)
        p.title = "Vacaciones"
        p.cantidad = 3000
        p.fecha = Date.now
        return p
    }()

}
