//
//  SetGameModel.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import Foundation

struct SetGameModel {
    
    fileprivate var cards : [Card]
    var deck: [Card]
    var dealtCards: [Card]
    fileprivate(set) var numberOfSets: Int
    
    fileprivate(set) var score = 0
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

        self.cards = cards
        deck = cards.shuffled()
        dealtCards = []
        numberOfSets = 0
    }
    
    mutating func selectCard(_ card: Card) {
        checkToDisableDealing()
        resetUnmatched()
        if let selectedCard = dealtCards.firstIndex(where: {$0.id == card.id}) {
            if !dealtCards[selectedCard].isSelected && selectedCardsIndices.count <= Constants.cardsMatched {
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
                        numberOfSets += 1
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
    
    private mutating func cardsAreASet(index: Int) -> Bool{
        let card1 = dealtCards[index]
        let card2 = dealtCards[selectedCardsIndices[0]]
        let card3 = dealtCards[selectedCardsIndices[1]]
        
        return isSetMatch(cards: [card1, card2, card3])
    }
    
    mutating func checkToDisableDealing() {
        if deck.count < Constants.disablingDeckLimit {
            dealingIsDisabled = true
        }
    }
    
    mutating func dealOneCard() {
        guard !deck.isEmpty else { return }
        let card = deck.removeFirst()
        dealtCards.append(card)
    }
    
    private func getScore() -> Int {
        let score = Constants.cardsMatched * (Constants.pointValueConstant / dealtCards.count)
        return score
    }


    private mutating func isSetMatch(cards: [Card]) -> Bool {
        let colors = Set(cards.map { $0.color })
        let symbols = Set(cards.map { $0.symbol })
        let shadings = Set(cards.map { $0.shading })
        let numbers = Set(cards.map { $0.number })

        return (colors.count == 1 || colors.count == 3) &&
               (symbols.count == 1 || symbols.count == 3) &&
               (shadings.count == 1 || shadings.count == 3) &&
               (numbers.count == 1 || numbers.count == 3)
    }
    
    mutating func replaceOneCard(index: Int) {
        guard !deck.isEmpty else { return }
        let card = deck.removeFirst()
        dealtCards[index] = card
    }
    
    mutating func replaceSet() {
        for index in selectedCardsIndices {
            dealtCards[index] = deck.prefix(1)[0]
            dealtCards.remove(at: index)
        }
    }
    
    private mutating func replaceThreeCards () {
        if dealtCards.count <= Constants.defaultNumberOfCards, !deck.isEmpty {
            dealtCards.indices.filter { dealtCards[$0].isMatched == true }.forEach { index in
            dealtCards[index] = deck.remove(at: 0)
        }
        } else {
            dealtCards = dealtCards.filter { $0.isMatched != true }
        }

    }
    
    mutating func resetSelection() {
        dealtCards.indices.forEach() { index in
            if dealtCards[index].isMatched  == true {
                dealtCards[index].isSelected = false
            } else {
                dealtCards[index].isMatched = nil
                dealtCards[index].isSelected = false
            }

        }
    }
    
    private mutating func resetUnmatched() {
        dealtCards.indices.forEach() { index in
            if dealtCards[index].isMatched == false {
                dealtCards[index].isMatched = nil
                dealtCards[index].isSelected = false
            }
        }
    }
  
    struct Card: Identifiable, Equatable {
        let id: UUID
        let color: CardColor
        let symbol: CardSymbol
        let number: CardNumber
        let shading: CardShading
        
        var isMatched: Bool?
        var isSelected = false
    }
}

private struct Constants {
    static let defaultNumberOfCards = 12
    static let pointValueConstant = 50
    static let cardsMatched = 3
    static let disablingDeckLimit = 3
}
