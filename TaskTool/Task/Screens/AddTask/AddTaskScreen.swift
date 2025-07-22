//
//  AddTaskScreen.swift
//  TaskTool
//
//  Created by Davi Paiva on 10/07/25.
//

import SwiftUI
import SwiftUI

struct AddTaskScreen: View {
    @StateObject var viewModel: AddTaskViewModel
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, owner, description
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Nome da Tarefa")
                TextField("Digite o nome", text: $viewModel.taskName)
                    .focused($focusedField, equals: .name)
                    .padding(12)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(colorScheme == .dark ? Color.white.opacity(0.8) : Color.gray.opacity(0.6), lineWidth: 1)
                    )
                    .cornerRadius(8)
                
                Text("Responsável")
                TextField("Digite o Responsável", text: $viewModel.taskOwner)
                    .focused($focusedField, equals: .owner)
                    .padding(12)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(colorScheme == .dark ? Color.white.opacity(0.8) : Color.gray.opacity(0.6), lineWidth: 1)
                    )
                    .cornerRadius(8)
                
                Text("Descrição da Tarefa")
                TextEditor(text: $viewModel.taskDescription)
                    .focused($focusedField, equals: .description)
                    .frame(height: 150)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(colorScheme == .dark ? Color.white.opacity(0.6) : Color.gray.opacity(0.4), lineWidth: 1)
                    )
                
                Text("Status da Tarefa")
                Picker("Status", selection: $viewModel.taskStatus) {
                    ForEach([TaskStatus.todo, .inProgress, .done], id: \.self) {
                        Text($0.description).tag($0)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                
                Button(
                    viewModel.isEditing ?
                    "Atualizar" :
                        "Salvar"
                ) {
                    viewModel.saveTask()
                    focusedField = nil
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.green))
                .foregroundStyle(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(
            viewModel.isEditing ? "Editar Tarefa" :
                "Adicionar Tarefa"
        )
        .navigationBarTitleDisplayMode(.inline)
        .alert("Erro", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil })
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .alert("Sucesso", isPresented: Binding(
            get: { viewModel.successMessage != nil },
            set: { _ in viewModel.successMessage = nil })
        ) {
            Button("OK", role: .cancel) {
            }
        } message: {
            Text(viewModel.successMessage ?? "")
        }
    }
}

#Preview {
    NavigationStack{
        AddTaskScreen(
            viewModel: AddTaskViewModel()
        )
    }
}
