//
//  CardView.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import SwiftUI

struct CardView: View {
    let card: SetGameModel.Card
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                SymbolView(card: card, size: geometry.size)
        
            }
            .padding(geometry.size.width * Card.paddingScaleFactor)
            .cardify(isSelected: card.isSelected, isMatched: card.isMatched)
            
        }
        .aspectRatio(Card.aspectRatio, contentMode: .fit)
        
        
        
        
    }
    
    // MARK: - Drawing Constants
    private struct Card {
        static let aspectRatio: Double = 3.0/2.0
        static let paddingScaleFactor = 0.1
    }
    
}

#Preview {
    CardView(card: SetGameModel.Card(id: 0, color: .green, symbol: .diamond, number: .three, shading: .shaded))
}
