//
//  ViewModel.swift
//  Notas
//
//  Created by masaki on 2022/12/29.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel : ObservableObject {
    
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!
    
    // CodeData
    func saveData(context: NSManagedObjectContext) {
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha
        
        do {
            try context.save()
            print("saved.")
            show.toggle()
        } catch let error as NSError {
            print("not saved.", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notas, context: NSManagedObjectContext) {
        context.delete(item)
        do {
            try context.save()
            print("item eliminado")
            show.toggle()
        } catch let error as NSError {
            print("item no Eliminado", error.localizedDescription)
        }
    }
    
    func sendData(item: Notas) {
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    func editData(context: NSManagedObjectContext) {
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("editado")
            show.toggle()
        } catch let error as NSError {
            print("no se pudo editar", error.localizedDescription)
        }
    }
}
