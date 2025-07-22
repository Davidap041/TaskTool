//
//  Task.swift
//  TaskTool
//
//  Created by Davi Paiva on 10/07/25.
//

import SwiftUI

struct TaskScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowingAddTaskScreen = false
    @State private var isShowingDeleteTaskScreen = false
    @State private var searchText: String = ""
    @State private var taskChoiced: Task? = nil
    
    @StateObject var viewModel = TaskViewModel()
    
    var body: some View {
        
        VStack {
            // Text Field and Button
            HStack{
                TextField(
                    "Pesquisar Tarefas",
                    text: $searchText
                )
                .padding(12)
                .background(
                    colorScheme == .dark
                    ? Color.black
                    : Color.white
                )
                
                .overlay{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            colorScheme == .dark
                            ? Color.white.opacity(0.8)
                            : Color.gray.opacity(0.6),
                            lineWidth: 1
                        )
                }
                .padding(.horizontal)
                Spacer()
                Button(action:{
                    taskChoiced = nil
                    isShowingAddTaskScreen = true
                }) {
                    Image(systemName: "plus")
                }
                .frame(width: 45, height: 45)
                .foregroundStyle(.white)
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Spacer()
            }
            
            // State Buttons
            HStack(spacing: 8) {
                ForEach([
                    TaskStatus.done,
                    TaskStatus.inProgress,
                    TaskStatus.todo
                ],      id: \.hashValue
                ) { item in
                    Button(action: {}) {
                        HStack {
                            Circle()
                                .fill(item.color)
                                .frame(width: 16)
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                    )
                }
            }
            
            // List of Cards
            if viewModel.isLoading {
                ProgressView("Carregando...")
            } else {
                List{
                    ForEach(
                        viewModel.tasks, id: \.id) { task in
                            TaskCard(
                                properties: task,
                                onEdit:{
                                    taskChoiced = task
                                    isShowingAddTaskScreen = true
                                },onDelete:{
                                    taskChoiced = task
                                    isShowingDeleteTaskScreen = true
                                })
                            .buttonStyle(PlainButtonStyle())
                            .listRowSeparator(.hidden)
                        }
                }
                .listStyle(PlainListStyle())
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .onAppear {viewModel.fetchTask()}
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Lista de Tarefas")
        .navigationDestination(isPresented: $isShowingAddTaskScreen) {
            AddTaskScreen(
                viewModel: AddTaskViewModel(task: taskChoiced)
            )
            .onDisappear {
                taskChoiced = nil
            }
        }
        .alert("Erro", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil })
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .alert("Excluir Atividade?", isPresented: $isShowingDeleteTaskScreen) {
            Button("Excluir", role: .destructive) {
                if let taskChoiced {
                    viewModel.deleteTask(taskChoiced)
                }
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            VStack(alignment: .leading) {
                Text("Deseja realmente excluir a atividade?")
                if let task = taskChoiced {
                    Text("• \(task.name)")
                        .bold()
                        .padding(.top, 4)
                }
            }
        }
    }
}
#Preview {
    NavigationStack{
        TaskScreen()
    }
}
