//  CDPresupuesto_Extension.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 27/3/25.
import Foundation
import CoreData

extension CDPresupuesto {
    
    // REVISAR: no me convence esta manera. El modelo no debería tener lógica de negocio
    static func exist(moc: NSManagedObjectContext, title: String) -> Bool {
        let fr = CDPresupuesto.fetchRequest()
        fr.predicate = NSPredicate(format: "title == %@", title)
        do {
            let results = try moc.fetch(fr)
            return !results.isEmpty
        } catch {
            return false
        }
    }
}
