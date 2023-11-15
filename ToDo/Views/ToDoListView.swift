//
//  ToDoListView.swift
//  ToDo
//
//  Created by Mauro Arantes on 14/11/2023.
//

import SwiftUI

struct ToDoListView: View {
    
    @StateObject var viewModel = ToDoListViewModel(apiService: APIService())
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.toDoList) { item in
                    HStack {
                        Text(item.todoName)
                        Spacer()
                        Image(systemName: item.isComplete ?? false ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                let parameters: [String: Any] = ["isComplete": !(item.isComplete ?? false)]
                                viewModel.updateItem(id: item.id, parameters: parameters)
                            }
                    }
                    .swipeActions {
                        Button {
                            viewModel.deleteItem(id: item.id)
                        } label: {
                            Text("Delete")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    viewModel.showNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $viewModel.showNewItemView) {
                NewItemView()
                    .environmentObject(viewModel)
            }
            .alert(viewModel.customError?.localizedDescription ?? "", isPresented: $viewModel.showErrorAlert) {
                Button("OK", role: .cancel) {}            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
