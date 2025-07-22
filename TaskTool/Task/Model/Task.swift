//
//  Task.swift
//  TaskTool
//
//  Created by Davi Paiva on 10/07/25.
//
import Foundation


import SwiftUI

enum TaskStatus: String, Codable {
    case done
    case todo
    case inProgress

    var description: String {
        switch self {
        case .done:
            return "Concluído"
        case .todo:
            return "Pendente"
        case .inProgress:
            return "Em progresso"
        }
    }
    var key: String {
        switch self {
        case .done:
            return "done"
        case .todo:
            return "todo"
        case .inProgress:
            return "in_progress"
        }
    }
    var color: Color {
        switch self {
        case .done:
            return .green
        case .todo:
            return .red
        case .inProgress:
            return .yellow
        }
    }
}

struct Task : Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var owner: String
    var description: String
    var status: String
    var updatedAt: String?
    var createdAt: String?
}


typealias Tasks = [Task]

extension Task {
    var taskStatus: TaskStatus {
        TaskStatus(rawValue: status) ?? .todo
    }
}
