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
        ZStack{
            SymbolView(card: card)
        }
        .cardify(isSelected: card.isSelected)
        
    }
}

#Preview {
    CardView(card: SetGameModel.Card(id: 0, color: .green, symbol: .diamond, number: .three, shading: .shaded))
}
