//  CDProvider.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 26/3/25.
import Foundation
import CoreData

class CDProvider {

    let pc = NSPersistentContainer(name: "CDModel")
    
    var moc: NSManagedObjectContext {
        pc.viewContext
    }
 
    init(isForPreview: Bool = false) {
        print(Self.self, #function)
        
        if isForPreview {
            pc.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        print("pc.persistentStoreDescriptions.first?.url?.absoluteString")
        print(pc.persistentStoreDescriptions.first?.url?.absoluteString ?? "nil")
        
        pc.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data store failed to initialize: \(error)")
            }
        }
    }
}
