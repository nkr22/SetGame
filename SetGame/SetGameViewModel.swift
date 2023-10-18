//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import SwiftUI

@Observable class SetGameViewModel {
    //NEEDSWORK
    
    var cardsDealt = 12
    
    var dealingIsDisabled: Bool {
        game.dealingIsDisabled
    }
    
    private var game = createGame()
    //create game
    
    var score: Int {
        return game.score
    }
    
    static func createGame() -> SetGameModel {
        SetGameModel()
    }
    
    private var isVisible = false
    
    var dealtCards: Array<SetGameModel.Card> {
        game.dealtCards
    }
    
    var discardedCards: Array<SetGameModel.Card> = []
    
    
    func discardCards() {
        var i = 0
        for card in discardedCards {
            withAnimation(dealAnimation(order: i)) {
                discard(card)
                i+=1
            }
        }
    }
    
    func discard(_ card: SetGameModel.Card) {
        discardedCards.append(card)
    }
    
    func dealAnimation(order: Int) -> Animation {
        let delay = Double(order) * Constants.animationDuration
        return Animation.easeInOut(duration: Constants.animationDuration).delay(delay)
    }
    
    func dealInitialCards() {
        game.dealInitialCards()
    }
    
    func dealThreeMoreCards() {
        game.dealThreeMoreCards()
    }
    
    func newGame () {
        game = SetGameViewModel.createGame()
        dealInitialCards()
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
