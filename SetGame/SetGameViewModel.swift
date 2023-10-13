//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import SwiftUI

@Observable class SetGameViewModel {
    //NEEDSWORK
    
    private var game = createGame()
    //create game
    static func createGame() -> SetGameModel {
        SetGameModel()
    }
    
    private var isVisible = false
    //which cards are dealt right now
    var dealtCards: Array<SetGameModel.Card> {
        isVisible ? Array(game.cards.prefix(12)) : []
    }
    
    func dealCards() {
        isVisible = true
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
