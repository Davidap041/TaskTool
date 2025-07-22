//
//  NetworkError.swift
//  TaskTool
//
//  Created by Davi Paiva on 14/07/25.
//

import Foundation
enum NetworkError {
    case invalidURL(url: String)
    case invalidResponse
    case decodingError(Error)
    case networkFailure(Error)
    case statusCode(code: Int)
    case noData
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL(url: let url): "Invalid URL: \(url)"
        case .invalidResponse: "Invalid HTTP response"
        case .decodingError(let error): "Decoding error: \(error.localizedDescription)"
        case .networkFailure(let error): "Network failure: \(error.localizedDescription)"
        case .statusCode(code: let code): "Invalid status code: \(code)"
        case .noData: "No data returned"
        }
    }
}
