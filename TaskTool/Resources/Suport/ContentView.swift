//
//  ContentView.swift
//  TaskTool
//
//  Created by Davi Paiva on 10/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            List {
                ForEach(
                    users,
                    id: \.self
                ) { user in
                    CardView(
                        properties:
                                .init(
                                    name: user.name,
                                    email: user.email
                                )
                    )
                }
            }
        }
        .toolbar {
            ToolbarItem(
                placement: .topBarTrailing
            ){
                Image(systemName: "plus")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("Task Tool"))
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
    
    
}
fileprivate let users: [CardProperties] = [
    CardProperties(name: "Davi Paiva", email: "davi.paiva@email.com"),
    CardProperties(name: "Lívia Ferreira", email: "livia.ferreira@email.com"),
    CardProperties(name: "Caio Mendes", email: "caio.mendes@email.com"),
    CardProperties(name: "Isabela Rocha", email: "isabela.rocha@email.com"),
    CardProperties(name: "Renan Souza", email: "renan.souza@email.com"),
    CardProperties(name: "Ana Júlia", email: "ana.julia@email.com"),
    CardProperties(name: "Carlos Silva", email: "carlos.silva@email.com"),
    CardProperties(name: "Bianca Lima", email: "bianca.lima@email.com"),
    CardProperties(name: "Felipe Torres", email: "felipe.torres@email.com"),
    CardProperties(name: "Joana", email: "joana@email.com")
]
