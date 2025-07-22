//
//  APIRequest.swift
//  TaskTool
//
//  Created by Davi Paiva on 14/07/25.
//

import Foundation

struct APIRequest {
    let url: String
    let method: HTTPMethod
    let headers: [String: String]?
    let parameters: Parameters?
    
    init(
        url: String,
        method: HTTPMethod = .get,
        headers: [String : String]? = nil,
        parameters: Parameters? = nil
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
}

struct EmptyResponse: Decodable {
    
}
