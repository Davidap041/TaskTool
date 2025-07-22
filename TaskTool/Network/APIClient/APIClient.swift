//
//  APIClient.swift
//  TaskTool
//
//  Created by Davi Paiva on 14/07/25.
//

import Foundation

class APIClient: HTTPClient {
    static let shared = APIClient()
    
    private var session: URLSession
    private var baseURL: String
    private var requestBuilder: RequestBuilder
    private var decoder: JSONDecoder
    private var timeout: TimeInterval
    
    init(
        session: URLSession = URLSession.shared,
        baseURL: String? = nil,
        requestBuilder: RequestBuilder = DefaultRequestBuilder(),
        decoder: JSONDecoder = JSONDecoder(),
        timeout: TimeInterval = 6
    ) {
        self.session = session
        self.requestBuilder = requestBuilder
        self.decoder = decoder
        self.timeout = timeout
        
        if let baseURL = baseURL {
            self.baseURL = baseURL
        } else if let baseURLProject = Bundle.main.infoDictionary?["BaseURL"] as? String {
            self.baseURL = baseURLProject
        } else {
            self.baseURL = ""
        }
    }
    
    func request<T>(
        request: APIRequest,
        decodeType: T.Type = EmptyResponse.self,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) where T : Decodable {
        
        // build request
        guard let request = requestBuilder.buildRequest(
            request: request,
            baseURL: baseURL,
            timeout: timeout
        ) else {
            let url = baseURL + request.url
            let error: NetworkError = .invalidURL(url: url)
            NetworkLogger.logError(error: error, url: url)
            completion(.failure(error))
            return
        }
        
        let task = session.dataTask(with: request){
            [weak self] data, response, error in
            
            DispatchQueue.main.async {
                NetworkLogger.log(
                    request: request,
                    response: response,
                    data: data, error: error
                )
                
                // get self instance
                guard let self else {
                    let error: NetworkError = .networkFailure(
                        NSError(
                            domain: "Api Client is out of memory",
                            code: -1
                        )
                    )
                    NetworkLogger.logError(
                        error: error,
                        url: request.url?.absoluteString ?? ""
                    )
                    completion(.failure(error))
                    return
                }
                
                // check error
                if let error {
                    let networkError: NetworkError = .networkFailure(error)
                    NetworkLogger.logError(error: networkError, url: request.url?.absoluteString ?? "")
                    completion(.failure(networkError))
                    return
                }
                
                // check response type
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                // check status code
                guard (200...299).contains(httpResponse.statusCode) else {
                    let error: NetworkError = .statusCode(code: httpResponse.statusCode)
                    NetworkLogger.logError(error: error, url: request.url?.absoluteString ?? "")
                    completion(.failure(error))
                    return
                }
                
                // check response content
                if decodeType == EmptyResponse.self {
                    if let emptyResponse = EmptyResponse() as? T {
                        completion(.success(emptyResponse))
                    } else {
                        let error: NetworkError = .decodingError(
                            NSError(domain: "Fail decoding EmptyResponse",
                                    code: -1)
                        )
                        NetworkLogger.logError(
                            error: error,
                            url: request.url?.absoluteString ?? ""
                        )
                        completion(.failure(error))
                    }
                    return
                }
                
                // check data
                guard let data else {
                    NetworkLogger.logError(
                        error: .noData,
                        url: request.url?.absoluteString ?? ""
                    )
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let object = try self.decoder.decode(
                        decodeType,
                        from: data
                    )
                    completion(.success(object))
                } catch {
                    let error: NetworkError = .decodingError(error)
                    NetworkLogger.logError(
                        error: error,
                        url: request.url?.absoluteString ?? ""
                    )
                    completion(.failure(error))
                }
            }
        }
        
        // start the task
        task.resume()
    }
}
