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
        GeometryReader { geometry in
            SymbolView(card: card, size: geometry.size)
                .cardify(
                    isSelected: card.isSelected
                )
        }
    }
}

#Preview {
    CardView(card: SetGameModel.Card(id: UUID(), color: .green, symbol: .diamond, number: .two, shading: .shaded))
}
