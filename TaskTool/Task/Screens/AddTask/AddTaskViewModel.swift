//
//  AddTaskViewModel.swift
//  TaskTool
//
//  Created by Davi Paiva on 11/07/25.
//
import SwiftUI
class AddTaskViewModel: ObservableObject {
    @Published public var taskId: String = ""
    @Published public var taskName: String = ""
    @Published public var taskOwner: String = ""
    @Published public var taskDescription: String = ""
    @Published public var taskStatus: TaskStatus = .todo
    @Published public var isEditing: Bool = false
    
    @Published public var errorMessage: String?
    @Published public var successMessage: String?
    
    private var taskRepository: TaskRepository
    
    init(task: Task? = nil){
        taskRepository = TaskInNetwork()
        if let task {
            self.taskId = task.id
            self.taskName = task.name
            self.taskOwner = task.owner
            self.taskStatus = task.taskStatus
            self.taskDescription = task.description
            self.isEditing = true
        }
    }
    
    func saveTask() {
        if (taskName.isEmpty || taskOwner.isEmpty){
            print("Task Name and Task Owner is required")
            self.errorMessage = "Nome e Proprietário da Tarefa são obrigatórios!"
            return
        }
        let task = Task(
            id: taskId.isEmpty ? UUID().uuidString : taskId,
            name: taskName,
            owner: taskOwner,
            description: taskDescription,
            status: taskStatus.key
        )
        if(isEditing){
            taskRepository.updateTask(task){ result in
                DispatchQueue.main.async {
                    switch result {
                    case .success():
                        self.successMessage = "Tarefa atualizada com sucesso!"
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
                
            }
        } else{
            taskRepository.saveTask(task){ result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.successMessage = "Tarefa salva com sucesso!"
                        self.clearFields()
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
        
    }
    
    private func clearFields() {
        taskName = ""
        taskOwner = ""
        taskDescription = ""
        taskStatus = .todo
    }
}
