//
//  TaskInNetwork.swift
//  TaskTool
//
//  Created by Davi Paiva on 14/07/25.
//

import Foundation
actor TaskInNetwork: @preconcurrency TaskRepository {
    func saveTask(
        _ task: Task,
        completion: @escaping (Result<Void, TaskError>
        ) -> Void
    ) {
        
        let request = APIRequest(
            url: "/tasks",
            method: .post,
            headers: ["Content-Type": "application/json"],
            parameters: .encodable(task)
        )
        
        APIClient.shared.request(
            request: request
        ) {
            result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                print(error.errorDescription ?? "")
                completion(.failure(.failedToSave))
            }
        }
    }
    
    func updateTask(
        _ task: Task,
        completion: @escaping (Result<Void, TaskError>
        ) -> Void
    ) {
        let request = APIRequest(
            url: "/tasks/\(task.id)",
            method: .put,
            headers: ["Content-Type": "application/json"],
            parameters: Parameters.encodable(task)
        )
        
        APIClient.shared.request(request: request) {
            result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                print(error.errorDescription ?? "")
                completion(.failure(.unknown))
            }
            
        }
        
    }
    
    func getAllTasks(completion: @escaping (Result<[Task], TaskError>) -> Void) {
        let request = APIRequest(url: "/tasks")
        APIClient.shared.request(
            request: request,
            decodeType: Tasks.self
        ) {
            result in switch result {
            case .success(let tasks):
                completion(.success(tasks))
                
            case .failure(let error):
                print(error.errorDescription ?? "")
                completion(.failure(.taskNotFound))
            }
        }
    }
    
    func deleteTask(_ id: String, completion: @escaping (Result<Void, TaskError>) -> Void) {
        let request = APIRequest(
            url: "/tasks/\(id)",
            method: .delete
        )
        
        APIClient.shared.request(request: request) {
            result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                print(error.errorDescription ?? "")
                completion(.failure(.unknown))
                
            }
        }
    }
    
    func getTask(
        _ id: String,
        completion: @escaping (Result<Task?, TaskError>)
        -> Void
    ) {
        let request = APIRequest(url: "/tasks/\(id)")
        APIClient.shared.request(
            request: request,
            decodeType: Task.self
        ){
            result in switch result {
            case .success(let task):
                completion(.success(task))
            case .failure(let error):
                print(error.errorDescription ?? "")
                completion(.failure(.taskNotFound))
            }
        }
    }
    
}
