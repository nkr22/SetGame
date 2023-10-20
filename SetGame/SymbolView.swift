//
//  SymbolView.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import SwiftUI

struct SymbolView: View {
    let card: SetGameModel.Card
    var size: CGSize
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
    
    var shading: Color {
        switch card.shading {
            case .solid:
                 return color
            case .shaded:
                 return color.opacity(0.25)
            default:
                 return Color.clear
        }
    }
    
    var body: some View {
            HStack {
                ForEach(0..<card.number.rawValue, id: \.self) { _ in
                    ZStack {
                        Group{
                            symbol
                                .foregroundStyle(shading)
                            symbol.stroke(lineWidth: 3)
                                .foregroundStyle(color)
                        }
                    }
                    .aspectRatio(1/2, contentMode: .fit)
                    
                    
                
                }
            
            }
            .frame(height: size.width / 2)
            .rotationEffect(Angle(degrees: 180))

    }

}

#Preview {
    SymbolView(card: SetGameModel.Card(id: 0, color: .green, symbol: .diamond, number: .one, shading: .shaded), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
}
