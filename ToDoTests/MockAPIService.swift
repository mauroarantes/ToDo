//
//  MockAPIService.swift
//  ToDoTests
//
//  Created by Mauro Arantes on 15/11/2023.
//

import Foundation
import Combine
@testable import ToDo

class MockAPIService: APIServiceProtocol {
    
    let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func getList(url: URL) -> AnyPublisher<ToDoListModel, Error> {
        if let path = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ToDoListModel.self, from: data)
                return Just(jsonData)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch {
                print("error:\(error)")
                return Fail(error: NetworkError.dataNotFound)
                    .eraseToAnyPublisher()
            }
        }
        return Fail(error: NSError())
            .eraseToAnyPublisher()
    }
}
