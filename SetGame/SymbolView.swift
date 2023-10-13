//
//  SymbolView.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import SwiftUI

struct SymbolView: View {
    let card: SetGameModel.Card
    var color: Color {
        switch card.color {
            case .red:
                 Color.red
            case .green:
                 Color.green
            default:
                 Color.purple
        }

    }
    var symbol: some Shape { // Change the type to some View
        switch card.symbol {
            case .squiggle:
                return AnyShape(Squiggle())
            case .diamond:
                return AnyShape(Diamond())
            case .oval:
                return AnyShape(Oval())
        }
    }
    var size: CGSize
    
    var body: some View {
        HStack {
            ForEach(0..<card.number.rawValue) { card in
                ZStack {
                    symbol
                        .foregroundStyle(shadingToUse())
                    symbol.stroke(lineWidth: 8)
                        .foregroundStyle(color)
                }
                .padding()
                .aspectRatio(1/2, contentMode: .fit)
            }
            .rotationEffect(Angle(degrees: 180))
        }
        .rotationEffect(Angle(degrees: 90))
        
        .padding()
    }
    
    private func shadingToUse() -> Color {
           switch card.shading {
               case .solid:
                    return color
               case .shaded:
                    return color.opacity(0.25)
               default:
                    return Color.clear
           }
       }
}

#Preview {
    SymbolView(card: SetGameModel.Card(id: UUID(), color: .green, symbol: .diamond, number: .two, shading: .shaded), size: CGSize(width: 200, height: 200))
}
