//
//  CardProperties.swift
//  TaskTool
//
//  Created by Davi Paiva on 10/07/25.
//

import Foundation
struct CardProperties: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var email: String
    
    func prefixName() -> String {
        let components = name.components(separatedBy: " ").filter { !$0.isEmpty }

           guard let first = components.first else {
               return ""
           }

           if components.count == 1 {
               return String(first.prefix(1))
           }

           let last = components.last!
           let firstInitial = first.prefix(1)
           let lastInitial = last.prefix(1)

           return "\(firstInitial)\(lastInitial)"
    }
}
