//
//  HTTPClient.swift
//  TaskTool
//
//  Created by Davi Paiva on 14/07/25.
//

import Foundation

protocol HTTPClient {
    
    func request<T: Decodable>(
        request: APIRequest,
        decodeType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}
