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
    
    var discardedCards: Array<SetGameModel.Card> {
        game.discardedCards
    }
    
    var numberOfSets: Int {
        game.numberOfSets
    }
    
    var transitionType: TransitionType = .newGame
    
    
    var score: Int {
        return game.score
    }
    

    //MARK: - User Intents
    func dealInitialCards() {
        for index in 0..<cardsDealt {
               withAnimation(Animation.easeInOut(duration: 0.5).delay(Double(index) * 0.1)) {
                   game.dealOneCard()
               }
           }
    }
    
    func dealThreeMoreCards() {
        game.resetSelection()

        if !dealingIsDisabled {
            let matchedCardIndices = dealtCards.indices.filter { dealtCards[$0].isMatched == true }
            
            if !matchedCardIndices.isEmpty {
                for (index, matchedIndex) in matchedCardIndices.enumerated() {
                    withAnimation(Animation.easeInOut(duration: 0.5).delay(0.1 * Double(index))) {
                        game.replaceOneCard(index: matchedIndex)
                    }
                }
            } else {
                for index in 0..<3 {
                    if deck.isEmpty {
                        break
                    }
                    withAnimation(Animation.easeInOut(duration: 0.5).delay(0.1 * Double(index))) {
                        game.dealOneCard()
                    }
                }
            }
            game.checkToDisableDealing()
        }
    }
    
    func newGame () {
        withAnimation(Animation.easeInOut(duration: 0.5)){
            game = SetGameViewModel.createGame()
        }
        for index in 0..<cardsDealt {
            withAnimation(Animation.easeInOut(duration: 0.5).delay(Double(index) * 0.1)) {
                game.dealOneCard()
            }
        }
    }
    
    func selectCard(_ card: SetGameModel.Card) {
        withAnimation(.easeIn(duration: Constants.animationDuration)){
            game.selectCard(card)
        }
    }

    //MARK: - Constants
    private struct Constants {
        static let animationDuration = 0.5
    }
    
    
}
