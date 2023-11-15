//
//  APIService.swift
//  ToDo
//
//  Created by Mauro Arantes on 15/11/2023.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func getList(url: URL) -> AnyPublisher<ToDoListModel, Error>
}

class APIService: APIServiceProtocol {
    
    func getList(url: URL) -> AnyPublisher<ToDoListModel, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .mapError{ error -> NetworkError in
                switch error{
                case is URLError:
                    return NetworkError.tooManyRequests
                case NetworkError.dataNotFound:
                    return NetworkError.dataNotFound
                case is DecodingError:
                    return NetworkError.parsingError
                default:
                    return NetworkError.dataNotFound
                }
            }
            .decode(type: ToDoListModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
