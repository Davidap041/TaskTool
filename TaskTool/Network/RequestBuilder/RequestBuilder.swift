//
//  RequestBuilder.swift
//  TaskTool
//
//  Created by Davi Paiva on 14/07/25.
//
import Foundation

protocol RequestBuilder {
    func buildRequest(
        request: APIRequest,
        baseURL: String,
        timeout: TimeInterval
    ) -> URLRequest?
}

struct DefaultRequestBuilder: RequestBuilder {
    func buildRequest(
        request: APIRequest,
        baseURL: String,
        timeout: TimeInterval
    ) -> URLRequest? {
        let completeURLString: String = baseURL + request.url
        
        guard let url = URL(string: completeURLString) else {
            //return .invalidURL(url: completeURLString)
            return nil
        }
        
        var completeRequest = URLRequest(url: url)
        completeRequest.httpMethod = request.method.rawValue
        completeRequest.allHTTPHeaderFields = request.headers
        completeRequest.timeoutInterval = timeout
        
        
        if let parameters = request.parameters {
            switch parameters {
            case .dictionary(let dictionary):
                completeRequest.httpBody = try? JSONSerialization.data(withJSONObject: dictionary)
            
            case .encodable(let encodable):
                completeRequest.httpBody = try? JSONEncoder().encode(encodable)
            }
        }
        
        return completeRequest
    }
}
