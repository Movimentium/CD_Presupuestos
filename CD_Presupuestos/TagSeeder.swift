//  TagSeeder.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 31/3/25.
import Foundation
import CoreData

class TagSeeder {
    
    private let moc: NSManagedObjectContext
    private let tags = ["Comida", "Cenas", "Viajes", "Entretenimiento", "Compras", "Salud", "Educación"]
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func seed() throws {
        for tag in tags {
            let newCDTag = CDTag(context: moc)
            newCDTag.nombre = tag
        }
        try moc.save()
    }
   

}
