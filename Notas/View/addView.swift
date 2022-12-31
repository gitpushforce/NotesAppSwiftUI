//
//  addView.swift
//  Notas
//
//  Created by masaki on 2022/12/29.
//

import SwiftUI

struct addView: View {
    
    
    @ObservedObject var model : ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            Text(model.updateItem != nil ? "Editar nota" : "Agregar nota")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextEditor(text: $model.nota).background(.red).padding()
            Divider()
            DatePicker("Select date", selection: $model.fecha)
            Spacer()
            Button(action: {
                if model.updateItem != nil {
                    model.editData(context: context)
                } else {
                    model.saveData(context: context)
                }
            })
            {
                Label(
                title: {Text("Save").foregroundColor(.white).bold()},
                icon: {Image(systemName: "plus").foregroundColor(.white)})
            }.padding()
                .frame(width: UIScreen.main.bounds.width - 30) // 30 is the most used for the margin
                .background(model.nota == "" ? Color.gray : Color.blue)
                .cornerRadius(8)
                .disabled(model.nota == "" ? true : false)
            
        }.padding()
    }
}

