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
        withAnimation{
            game.dealingIsDisabled
        }
    }
    
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
    
    private var game = createGame()
    //create game
    
    var score: Int {
        return game.score
    }
    
    static func createGame() -> SetGameModel {
        SetGameModel()
    }
    
    func dealInitialCards() {
        game.dealInitialCards()
    }
    
    func dealThreeMoreCards() {
        game.dealThreeMoreCards()
    }
    
    func newGame () {
        game = SetGameViewModel.createGame()
        withAnimation {
            dealInitialCards()
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
