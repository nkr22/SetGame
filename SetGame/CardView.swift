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
            .padding(geometry.size.width * CardConstants.paddingScaleFactor)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .cardify(isSelected: card.isSelected, isMatched: card.isMatched)
            
        }
        .aspectRatio(CardConstants.aspectRatio, contentMode: .fit)     
    }
}

#Preview {
    CardView(card: SetGameModel.Card(id: UUID(), color: .green, symbol: .diamond, number: .three, shading: .shaded))
}
