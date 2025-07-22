//
//  TaskCard.swift
//  TaskTool
//
//  Created by Davi Paiva on 10/07/25.
//

import SwiftUI

struct TaskCard: View {
    @Environment(\.colorScheme) var colorScheme
    var properties: Task
    public var onEdit: (() -> Void)? = nil
    public var onDelete: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading){
            Text(properties.name)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(Color(hex: "#808080"))
            HStack {
                Text("Responsável: ")
                    .font(.callout)
                    .foregroundStyle(Color(hex: "#AEAEAE"))
                Text(properties.owner)
                    .font(.callout)
                    .foregroundStyle(
                        colorScheme == .dark
                        ? Color.white : Color.black
                    )
            }
            Text(properties.description)
                .foregroundStyle(Color(hex: "#898989"))
            
            HStack {
                Text(properties.taskStatus.description)
                    .foregroundStyle(properties.taskStatus.color)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {onEdit?()}){
                    Image(systemName: "pencil")
                        .foregroundStyle(.black)
                }
                .frame(width: 37,height: 37)
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Button(action: {onDelete?()}){
                    Image(systemName: "trash")
                        .foregroundStyle(.white)
                }
                .frame(width: 37,height: 37)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "#E0E0E0"), lineWidth: 1)
        }
    }
}

#Preview {
    TaskCard(
        properties: Task.init(
            name: "Lavar Louça",
            owner: "Davi Paiva",
            description: "Lavar e enxugar tudo na pia",
            status: TaskStatus.inProgress.description
        )
    )
    .padding()
}
