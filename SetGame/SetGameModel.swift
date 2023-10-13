//
//  SetGameModel.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import Foundation

struct SetGameModel {
    //NEEDSWORK
    
    var cards : [Card]
    
    //ENUM for shading
    enum CardShading: CaseIterable {
        case solid, shaded, none
    }
    //ENUM for number
    enum CardNumber: Int, CaseIterable {
        case three = 3, two = 2, one = 1
    }
    //ENUM for color
    enum CardColor: CaseIterable {
        case red, green, purple
    }
    //ENUM for symbol
    enum CardSymbol: CaseIterable {
        case squiggle, diamond, oval
    }
    
    //setting up the 81 cards possible (3^4)
    
    init() {
        var cards = [Card]()
        
        for color in CardColor.allCases {
            for shading in CardShading.allCases {
                for symbol in CardSymbol.allCases {
                    for number in CardNumber.allCases {
                        cards.append(
                            Card(
                                id: UUID(),
                                color: color,
                                symbol: symbol,
                                number: number,
                                shading: shading
                            )
                        )
                    }
                }
            }
        }
        //shuffling the cards
        self.cards = cards.shuffled()
    }
 
    
    //dealing the first twelve
    //dealing three more
    
    
    //Card that has attributes of
        //shading, number, color, symbol, isMatched, isSelected
        //score based on how many cards are currently out
    
    struct Card: Identifiable {
        let id: UUID
        let color: CardColor
        let symbol: CardSymbol
        let number: CardNumber
        let shading: CardShading
        
        var isMatched = false
        var isSelected = false
    }
}
