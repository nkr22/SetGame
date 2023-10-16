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
        var count = 1
        var cards = [Card]()
        
        for color in CardColor.allCases {
            for shading in CardShading.allCases {
                for symbol in CardSymbol.allCases {
                    for number in CardNumber.allCases {
                        cards.append(
                            Card(
                                id: count,
                                color: color,
                                symbol: symbol,
                                number: number,
                                shading: shading
                            )
                        )
                        
                        count += 1
                    }
                }
            }
        }
        //shuffling the cards
        self.cards = cards.shuffled()
    }
    
    mutating func selectCard(_ card: Card) {
        for index in cards.indices {
            if cards[index].id == card.id {
                cards[index].isSelected.toggle()
            }
        }
    }
    
    mutating func isSetMatch(cards: [Card]) -> Bool {
        let colors = Set(cards.map { $0.color })
        let symbols = Set(cards.map { $0.symbol })
        let shadings = Set(cards.map { $0.shading })
        let numbers = Set(cards.map { $0.number })

        return (colors.count == 1 || colors.count == 3) &&
               (symbols.count == 1 || symbols.count == 3) &&
               (shadings.count == 1 || shadings.count == 3) &&
               (numbers.count == 1 || numbers.count == 3)
    }

 
    
    //dealing the first twelve
    //dealing three more
    
    
    //Card that has attributes of
        //shading, number, color, symbol, isMatched, isSelected
        //score based on how many cards are currently out
    
    struct Card: Identifiable {
        let id: Int
        let color: CardColor
        let symbol: CardSymbol
        let number: CardNumber
        let shading: CardShading
        
        var isMatched = false
        var isSelected = false
        var isOnScreen = false
    }
}
