//
//  Home.swift
//  Notas
//
//  Created by masaki on 2022/12/29.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    
    // without predicate
//    @FetchRequest (entity: Notas.entity(), sortDescriptors:
//                    [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results : FetchedResults<Notas>
    
    // with predicate: show only notes before or equals current day
//    @FetchRequest (entity: Notas.entity(), sortDescriptors:[],
//                   predicate: NSPredicate(format: "fecha <= %@", Date() as CVarArg),
//                   animation: .spring()) var results : FetchedResults<Notas>
    
    // with predicate: show only notes that begin with the word IMPORTANTE.
    // if want to show the notes that contains the word IMPORTANT, change BEGINSWITH for CONTAINS[c]
    @FetchRequest (entity: Notas.entity(), sortDescriptors:[],
                   predicate: NSPredicate(format: "nota BEGINSWITH 'IMPORTANTE'"),
                   animation: .spring()) var results : FetchedResults<Notas>
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(results) { item in
                    VStack(alignment: .leading) {
                        Text(item.nota ?? "sin nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            model.sendData(item: item)
                        }){
                            Label(title: {
                                Text("Editar")
                            }, icon: {
                                Image(systemName: "pencil")
                            })
                        }
                        
                        Button(action: {
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title: {
                                Text("Eliminar")
                            }, icon: {
                                Image(systemName: "trash")
                            })
                        }
                        
                        
                    }))
                }
            }.navigationTitle("Notas")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            model.show.toggle()
                                        }){
                                            Image(systemName: "plus").font(.title).foregroundColor(.blue)
                                        }
                
                ).sheet(isPresented: $model.show, content: {
                    addView(model: model)
                })
        }
        
//        Button(action: {
//            model.show.toggle()
//        }){
//            Text("+")
//        }.sheet(isPresented: $model.show, content: {
//            addView(model: model)
//        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
