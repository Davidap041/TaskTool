//
//  TaskInMemory.swift
//  TaskTool
//
//  Created by Davi Paiva on 11/07/25.
//
import Foundation
actor TaskInMemory: @preconcurrency TaskRepository {
    func saveTask(_ task: Task, completion: @escaping (Result<Void, TaskError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            Mock.tasks.append(task)
            completion(.success(()))
        }
    }
    func updateTask(_ task: Task, completion: @escaping (Result<Void, TaskError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            if let index = Mock.tasks.firstIndex(where: { $0.id == task.id }) {
                Mock.tasks[index] = task
                completion(.success(()))
            } else {
                print("🔍 Buscando task com id: \(task.id)")
                print("🧱 Lista atual: \(Mock.tasks.map(\.id))")
                completion(.failure(.taskNotFound))
            }
        }
    }
    func getAllTasks(completion: @escaping (Result<[Task], TaskError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let tasks = Mock.tasks
            if tasks.isEmpty {
                completion(.failure(.taskNotFound))
            } else {
                completion(.success(tasks))
            }
        }
    }
    
    func deleteTask(_ id: String, completion: @escaping (Result<Void, TaskError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            Mock.tasks.removeAll { $0.id == id }
            completion(.success(()))
        }
    }
    
    func getTask(_ id: String, completion: @escaping (Result<Task?, TaskError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            if let task = Mock.tasks.first(where: { $0.id == id }) {
                completion(.success(task))
            } else {
                completion(.failure(.taskNotFound))
            }
        }
    }
    
    
}
