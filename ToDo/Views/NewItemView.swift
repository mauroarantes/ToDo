//
//  NewItemView.swift
//  ToDo
//
//  Created by Mauro Arantes on 14/11/2023.
//

import SwiftUI

struct NewItemView: View {
    
    @StateObject var viewModel = NewItemViewModel()
    @EnvironmentObject var listViewModel: ToDoListViewModel
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding()
            Form {
                HStack {
                    TextField("Title", text: $viewModel.name)
                    Spacer()
                    Button {
                        viewModel.isComplete.toggle()
                    } label: {
                        Image(systemName: viewModel.isComplete ? "checkmark.circle.fill" : "circle")
                    }
                }
                
                Button {
                    let parameters: [String: Any] = ["todoName": viewModel.name, "isComplete": viewModel.isComplete]
                    listViewModel.createItem(parameters: parameters)
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }

            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView()
    }
}
