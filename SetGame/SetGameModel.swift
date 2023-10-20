//
//  SetGameModel.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import Foundation

struct SetGameModel {
    
    var cards : [Card]
    var deck: [Card]
    var dealtCards: [Card]
    var discardedCards: [Card]
    var numberOfSets: Int = 0
    
    var score = 0
    var dealingIsDisabled = false
    
    enum CardShading: CaseIterable {
        case solid, shaded, none
    }

    enum CardNumber: Int, CaseIterable {
        case three = 3, two = 2, one = 1
    }

    enum CardColor: CaseIterable {
        case red, green, purple
    }

    enum CardSymbol: CaseIterable {
        case squiggle, diamond, oval
    }
    
    private var selectedCardsIndices: [Int] {
        get { dealtCards.indices.filter({dealtCards[$0].isSelected && dealtCards[$0].isMatched != true}) }
    }
    
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

        self.cards = cards
        deck = cards.shuffled()
        dealtCards = []
        discardedCards = []
    }
    
    private func getScore() -> Int {
        let score = 3 * (30 / dealtCards.count)
        return score
    }
    
    mutating func selectCard(_ card: Card) {
        replaceThreeCards()
        if let selectedCard = dealtCards.firstIndex(where: {$0.id == card.id}) {
            if !dealtCards[selectedCard].isSelected {
                switch selectedCardsIndices.count {
                case 0...1:
                    dealtCards[selectedCard].isSelected = true
                case 2:
                    if cardsAreASet(index: selectedCard) {
                        for index in selectedCardsIndices {
                            dealtCards[index].isMatched = true
                        }
                        dealtCards[selectedCard].isSelected = true
                        dealtCards[selectedCard].isMatched = true
                        score += getScore()
                    } else {
                        for index in selectedCardsIndices {
                            dealtCards[index].isMatched = false
                        }
                        dealtCards[selectedCard].isSelected = true
                        dealtCards[selectedCard].isMatched = false
                    }
                    
                case 3:
                    resetSelection()
                    if dealtCards[selectedCard].isMatched == nil {
                        dealtCards[selectedCard].isSelected = true
                    }
                default:
                    return
                }
            } else if dealtCards[selectedCard].isSelected == true && dealtCards[selectedCard].isMatched == false && selectedCardsIndices.count < 3 {
                dealtCards[selectedCard].isSelected = false
            } else {
                switch selectedCardsIndices.count {
                case 1,2:
                    dealtCards[selectedCard].isSelected = false
                default:
                    return
                }
            }
        } else {
            return
        }
        
        
    }
    
    mutating func replaceSet() {
        for index in selectedCardsIndices {
            dealtCards[index].isOnScreen = false
            discardedCards.append(dealtCards[index])
            dealtCards[index] = deck.prefix(1)[0]
            dealtCards.remove(at: index)
        }
    }
    
    mutating func cardsAreASet(index: Int) -> Bool{
        let card1 = dealtCards[index]
        let card2 = dealtCards[selectedCardsIndices[0]]
        let card3 = dealtCards[selectedCardsIndices[1]]
        
        return isSetMatch(cards: [card1, card2, card3])
    }
    
    private mutating func checkToDisableDealing () {
        
        if deck.count < 3 {
            dealingIsDisabled = true
        }
    }
    
    mutating func dealInitialCards() {
        for index in 0..<12 {
            dealtCards.append(deck[index])
            dealtCards[index].isOnScreen = true
        }
        deck = Array(deck.dropFirst(12))
    }
    
    mutating func dealThreeMoreCards() {
        if !dealingIsDisabled {
            let cardsToDeal = deck.prefix(3)

            for index in cardsToDeal.indices {
                var card = cardsToDeal[index]
                card.isOnScreen = true
                dealtCards.append(card)
            }

            deck = Array(deck.dropFirst(3))
            checkToDisableDealing()
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
    
    private mutating func replaceThreeCards () {
        if dealtCards.count <= 12, !deck.isEmpty {
            dealtCards.indices.filter { dealtCards[$0].isMatched == true }.forEach { index in
                dealtCards[index] = deck.remove(at: 0)
            }
        } else {
            dealtCards = dealtCards.filter { $0.isMatched != true }
        }
    }
    
    private mutating func resetSelection() {
        dealtCards.indices.filter({dealtCards[$0].isOnScreen}).forEach() { index in
            if dealtCards[index].isMatched  == true {
                dealtCards[index].isSelected = false
            } else {
                dealtCards[index].isMatched = nil
                dealtCards[index].isSelected = false
            }

        }
    }

    
    struct Card: Identifiable, Equatable {
        let id: Int
        let color: CardColor
        let symbol: CardSymbol
        let number: CardNumber
        let shading: CardShading
        
        var isMatched: Bool?
        var isSelected = false
        var isOnScreen = false
        var score = 5
    }
}
