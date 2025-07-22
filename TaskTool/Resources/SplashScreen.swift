//
//  SplashCreen.swift
//  TaskTool
//
//  Created by Davi Paiva on 10/07/25.
//

import SwiftUI
struct SplashScreen: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(hex: "#EFF0FE"))
                .frame(width: 269)
            Circle()
                .fill(Color(hex: "#E0E2FD"))
                .frame(width: 220)
            Circle()
                .fill(Color(hex: "#8084B8"))
                .frame(width: 129.61)
            Image("Icon")
                .resizable()
                .frame(width: 72, height: 72)
        }
        
    }
}


#Preview {
    SplashScreen()
}
