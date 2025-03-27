//  String_Extension.swift
//  CD_Presupuestos
//  Created by Miguel Gallego on 27/3/25.
import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
