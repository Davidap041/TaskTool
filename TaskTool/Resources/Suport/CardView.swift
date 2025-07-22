//
//  CardView.swift
//  TaskTool
//
//  Created by Davi Paiva on 10/07/25.
//

import SwiftUI
struct CardView: View {
    private let properties: CardProperties
    init(properties: CardProperties) {
        self.properties = properties
    }
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 75)
                .foregroundStyle(.blue)
                .overlay {
                    Text(properties.prefixName())
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            Spacer()
            VStack (
                alignment: .leading
            ){
                Text(properties.name)
                    .font(.headline)
                Text(properties.email)
                    .font(.subheadline)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.blue.opacity(0.2))
        .cornerRadius(16)
        
    }
}

#Preview {
    CardView(
        properties: .init(name: "Davi", email: "daviap87@gmail.com")
    )
        .padding()
}
