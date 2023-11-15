//
//  NetworkError.swift
//  ToDo
//
//  Created by Mauro Arantes on 15/11/2023.
//

import Foundation

enum NetworkError: Error {
    case tooManyRequests
    case parsingError
    case dataNotFound
    case responseError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self{
        case .tooManyRequests:
            return NSLocalizedString("Too Many Requests", comment: "tooManyRequests")
        case .parsingError:
            return NSLocalizedString("Parsing Error", comment: "parsingError")
        case .dataNotFound:
            return NSLocalizedString("Data Not Found", comment: "dataNotFound")
        case .responseError:
            return NSLocalizedString("Response Error", comment: "responseError")
        }
    }
}
