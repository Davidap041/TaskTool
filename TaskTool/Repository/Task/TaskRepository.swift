//
//  TaskRepository.swift
//  TaskTool
//
//  Created by Davi Paiva on 11/07/25.
//
import Foundation
enum TaskError: LocalizedError {
    case failedToSave
    case taskNotFound
    case unknown

    var errorDescription: String? {
        switch self {
        case .failedToSave:
            return "Não foi possível salvar a tarefa."
        case .taskNotFound:
            return "Tarefa não encontrada."
        case .unknown:
            return "Ocorreu um erro desconhecido."
        }
    }
}

protocol TaskRepository {
    func saveTask(_ task: Task, completion: @escaping (Result<Void, TaskError>) -> Void)
    func updateTask(_ task: Task, completion: @escaping (Result<Void, TaskError>) -> Void)
    func getAllTasks(completion: @escaping (Result<[Task], TaskError>) -> Void)
    func deleteTask(_ id: String, completion: @escaping (Result<Void, TaskError>) -> Void)
    func getTask(_ id: String, completion: @escaping (Result<Task?, TaskError>) -> Void)
}
