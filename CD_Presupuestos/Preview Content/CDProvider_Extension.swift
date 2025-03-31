//  CDProvider_Extension.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 27/3/25.
import Foundation

extension CDProvider {
    static let previewInstance: CDProvider = {
        let provider = CDProvider(isForPreview: true)
        let moc = provider.moc
        
        // Presupuestos
        let entretenimiento = CDPresupuesto(context: moc)
        entretenimiento.title = "Entretenimiento"
        entretenimiento.cantidad = 500
        entretenimiento.fecha = Date.now
        
        let comida = CDPresupuesto(context: moc)
        comida.title = "Comida"
        comida.cantidad = 200
        comida.fecha = Date.now
        
        // Gastos
        let leche = CDGasto(context: moc)
        leche.concepto = "Leche"
        leche.cantidad = 5.45
        leche.fecha = Date.now
        comida.addToGastos(leche)
        
        let panMolde = CDGasto(context: moc)
        panMolde.concepto = "Pan de molde"
        panMolde.cantidad = 4.50
        panMolde.fecha = Date.now
        comida.addToGastos(panMolde)
        
        let cine = CDGasto(context: moc)
        cine.concepto = "Cine: Batman"
        cine.cantidad = 7.95
        cine.fecha = Date.now
        entretenimiento.addToGastos(cine)
        
        do {
            try TagSeeder(moc: moc).seed()
            try moc.save()
        } catch {
            print(#function, error)
        }
        // Alternative: try? provider.moc.safe

        return provider
    }()

    static var presupuestoTestComida: CDPresupuesto {
        let moc = CDProvider.previewInstance.moc
        let fr = CDPresupuesto.fetchRequest()
        fr.predicate = NSPredicate(format: "title == %@", "Comida")
        if let results = try? moc.fetch(fr), let firstResult = results.first {
            return firstResult
        } else {
            return Self.presupuestoTest // Vacaciones
        }
    }
    
    static let presupuestoTest: CDPresupuesto = {
        let moc = CDProvider.previewInstance.moc
        let p = CDPresupuesto(context: moc)
        p.title = "Vacaciones"
        p.cantidad = 3000
        p.fecha = Date.now
        return p
    }()
    
    static var gastoTestLeche: CDGasto {
        let moc = CDProvider.previewInstance.moc
        let fr = CDGasto.fetchRequest()
        fr.predicate = NSPredicate(format: "concepto == %@", "Leche")
        if let results = try? moc.fetch(fr), let firstResult = results.first {
            return firstResult
        } else {
            fatalError("\(Self.self) \(#function) error")
        }
    }

}
