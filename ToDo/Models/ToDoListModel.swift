//
//  ToDoListModel.swift
//  ToDo
//
//  Created by Mauro Arantes on 14/11/2023.
//

import Foundation

// MARK: - ToDoListModel
struct ToDoListModel: Codable {
    let code: Int
    let data: [ToDoItem]
}

struct CreateItemModel: Codable {
    let code: Int
    let data: ToDoItem
}

struct DeleteItemModel: Codable {
    let code: Int
    let message: String
}

// MARK: - Datum
struct ToDoItem: Codable, Identifiable {
    let id, todoName: String
    let isComplete: Bool?
    let createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case todoName, isComplete, createdAt, updatedAt
        case v = "__v"
    }
}
