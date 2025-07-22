//
//  Mock.swift
//  TaskTool
//
//  Created by Davi Paiva on 11/07/25.
//

struct Mock {
    static var tasks: [Task] = [
        .init(
            name: "Desenvolver App",
            owner: "Davi Paiva",
            description: "Desenvolver esse app em swiftUI",
            status: TaskStatus.done.description
        )
    ]
}
