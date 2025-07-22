//
//  TaskViewModel.swift
//  TaskTool
//
//  Created by Davi Paiva on 11/07/25.
//

import Foundation
class TaskViewModel : ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isLoading: Bool = false
    
    @Published public var errorMessage: String?
    private var repository: TaskRepository
    
    init(){
        repository = TaskInNetwork()
        self.fetchTask()
    }
    func deleteTask(_ task: Task){
        self.isLoading = true
        self.repository.deleteTask(task.id){ result in
            DispatchQueue.main.async {
                if case .failure(let error) = result {
                    self.errorMessage = error.localizedDescription
                }
                self.fetchTask()
                self.isLoading = false
            }
        }
    }
    func fetchTask(
    ){
        self.isLoading = true
        self.repository.getAllTasks
        { result in
            DispatchQueue.main.async
            {
                switch result {
                case .success(let tasks):
                    self.tasks = tasks
                    self.isLoading = false
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }
        }
    }
}
