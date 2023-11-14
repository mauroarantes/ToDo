//
//  ToDoListViewModel.swift
//  ToDo
//
//  Created by Mauro Arantes on 14/11/2023.
//

import Foundation
import Combine

class ToDoListViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    @Published var toDoList: [ToDoItem] = []
    @Published var showNewItemView = false
    @Published var showUpdateItemView = false
    
    init() {
        getList()
    }
    
    func getList() {
        
        guard let url = URL(string: "https://calm-plum-jaguar-tutu.cyclic.app/todos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ToDoListModel.self, decoder: JSONDecoder())
            .sink { completion in
                print("GET COMPLETION: \(completion)")
            } receiveValue: { [weak self] toDoList in
                self?.toDoList = toDoList.data
            }
            .store(in: &cancellables)

    }
    
    func createItem(parameters: [String: Any]) {
        
        guard let url = URL(string: "https://calm-plum-jaguar-tutu.cyclic.app/todos") else { return }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: CreateItemModel.self, decoder: JSONDecoder())
            .sink { completion in
                print("POST COMPLETION: \(completion)")
            } receiveValue: { [weak self] _ in
                self?.getList()
            }
            .store(in: &cancellables)

    }
    
    func updateItem(id: String, parameters: [String: Any]) {
        
        guard let url = URL(string: "https://calm-plum-jaguar-tutu.cyclic.app/todos/\(id)") else { return }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: CreateItemModel.self, decoder: JSONDecoder())
            .sink { completion in
                print("PUT COMPLETION: \(completion)")
            } receiveValue: { [weak self] _ in
                self?.getList()
            }
            .store(in: &cancellables)

    }
    
    func deleteItem(id: String) {
        
        guard let url = URL(string: "https://calm-plum-jaguar-tutu.cyclic.app/todos/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: DeleteItemModel.self, decoder: JSONDecoder())
            .sink { completion in
                print("DELETE COMPLETION: \(completion)")
            } receiveValue: { [weak self] _ in
                self?.getList()
            }
            .store(in: &cancellables)

    }

}