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
    
    var dealingIsDisabled = false
    
    private var game = createGame()
    //create game
    
//    var score: Int {
//        return game.score
//    }
    static func createGame() -> SetGameModel {
        SetGameModel()
    }
    
    private func checkToDisableDealing () {
        let cardsLeft = game.cards.filter({!$0.isOnScreen})
        
        if cardsLeft.count == 0 {
            dealingIsDisabled = true
        }
    }
    
    private var isVisible = false
    //which cards are dealt right now
    var dealtCards: Array<SetGameModel.Card> {
        isVisible ? game.cards.filter {$0.isOnScreen} : []
    }
    
    func dealInitialCards() {
        
        for index in (0..<12) {
            game.cards[index].isOnScreen = true
        }
        isVisible = true
    }
    
    func dealThreeMoreCards() {
        if !dealingIsDisabled {
            let cardsToDeal = game.cards.filter { !$0.isOnScreen }.prefix(3)
            
            let updatedCards = game.cards.map { card in
                var updatedCard = card
                if cardsToDeal.contains(where: { $0.id == card.id }) {
                    updatedCard.isOnScreen = true
                }
                return updatedCard
            }
            
            game.cards = updatedCards
            checkToDisableDealing()
        }
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
    
    //computed property for disabling the deal three cards button

    //score to show to user on view
    
    //deal three more cards
        //replace three selected cards if they are a match
        //if selected cards are not a set, then fly in three new cards and do not deselect the current cards
    
    //clicking on a card
        //select a card
        
        //unselect a card
        
        //if there are already three non-matching, unselect the previous three and select the new one
    
    //deal all the cards
    
    //set up new game
    
    //when three cards are selected
        //red outline to card or green
    
    
    
    
    
    
    
}
