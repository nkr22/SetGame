//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import SwiftUI

@Observable class SetGameViewModel {
    //MARK: - Properties
    var cardsDealt = 12
    
    private var game = createGame()
    
    var dealingIsDisabled: Bool {
        withAnimation{
            game.dealingIsDisabled
        }
    }
    
    var matchedCardIndices: [Int] {
        dealtCards.indices.filter { dealtCards[$0].isMatched == true }
    }
    
    static func createGame() -> SetGameModel {
        SetGameModel()
    }
    
    //MARK: - Model Access
    var deck: Array<SetGameModel.Card> {
        game.deck
    }
    
    var dealtCards: Array<SetGameModel.Card> {
        game.dealtCards
    }
    
    var numberOfSets: Int {
        game.numberOfSets
    }
    
    var score: Int {
        return game.score
    }
    

    //MARK: - User Intents
    func dealInitialCards() {
        for index in 0..<cardsDealt {
               withAnimation(Animation.easeInOut(duration: CardConstants.animationDuration).delay(Double(index) * 0.1)) {
                   game.dealOneCard()
               }
           }
    }
    
    func dealThreeMoreCards() {
        game.resetSelection()

        if !dealingIsDisabled {
            
            if !matchedCardIndices.isEmpty {
                replaceMatch()
            } else {
                for index in 0..<3 {
                    if deck.isEmpty {
                        break
                    }
                    withAnimation(Animation.easeInOut(duration: CardConstants.animationDuration).delay(0.1 * Double(index))) {
                        game.dealOneCard()
                    }
                }
            }
            game.checkToDisableDealing()
        }
    }
    
    func newGame () {
        withAnimation(Animation.easeInOut(duration: CardConstants.animationDuration)){
            game = SetGameViewModel.createGame()
        }
        for index in 0..<cardsDealt {
            withAnimation(Animation.easeInOut(duration: CardConstants.animationDuration).delay(Double(index) * 0.1)) {
                game.dealOneCard()
            }
        }
    }
    
    func replaceMatch() {
            if dealtCards.count <= 12 && !dealingIsDisabled {
                    for (index, matchedIndex) in matchedCardIndices.enumerated() {
                        withAnimation(Animation.easeInOut(duration: CardConstants.animationDuration).delay(0.1 * Double(index))) {
                            game.replaceOneCard(index: matchedIndex)
                        }
                    }
            } else {
                withAnimation(Animation.easeInOut(duration: CardConstants.animationDuration)){
                    game.dealtCards = game.dealtCards.filter({$0.isMatched != true})
                }
            }
            
            game.checkToDisableDealing()
    }
    
    func selectCard(_ card: SetGameModel.Card) {
        replaceMatch()
        withAnimation(.easeIn(duration: CardConstants.animationDuration)){
            game.selectCard(card)
        }
    }
    
}
