//
//  Diamond.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import SwiftUI

struct DiamondView: View {
    var body: some View {
        HStack {
            ForEach(0..<3) { _ in
                ZStack {
                    Diamond()
                        .opacity(0.25)
                    Diamond().stroke(lineWidth: 8)
                }
                .padding()
                .aspectRatio(1/2, contentMode: .fit)
            }
        }
        .rotationEffect(Angle(degrees: 90))
        .foregroundStyle(.purple)
        .padding()
    }
}


struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: width * 0.5, y: 0)) // Top point
                path.addLine(to: CGPoint(x: width, y: height * 0.5)) // Right point
                path.addLine(to: CGPoint(x: width * 0.5, y: height)) // Bottom point
                path.addLine(to: CGPoint(x: 0, y: height * 0.5)) // Left point
                path.closeSubpath()
        
        return path
    }
}

#Preview {
    DiamondView()
}
