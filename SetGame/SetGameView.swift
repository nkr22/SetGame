//
//  ContentView.swift
//  Squiggle
//
//  Created by Noelia Root on
//  10/7/23
//

import SwiftUI

enum TransitionType: CaseIterable {
    case threeCards, newGame, selectCard
}

struct SetGameView: View {
    let setGame: SetGameViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
                VStack {
                    Text("SET!")
                        .font(.largeTitle)
                        .bold()

                    
                    ScrollView{
                        LazyVGrid(columns: columns(for: geometry.size)) {
                            ForEach(setGame.dealtCards) { card in
                                CardView(card: card)
                                    .onTapGesture {
                                        setGame.transitionType = .selectCard
                                        setGame.selectCard(card)
                                    }
                                    .transition(.cardTransition(size: geometry.size))
                                    .animation(Animation.easeInOut(duration: 0.5)
                                        .delay(transitionDelay(card: card)))
      
                            }
                        }
                    }
                    
                    Spacer()
                    HStack {
                        Button {
                            setGame.transitionType = .newGame
                            withAnimation(Animation.easeInOut(duration: 0.2)) {
                                setGame.newGame()
                            }
                        } label: {
                            Text("New Game")
                        }
                        Spacer()
                        Text("\(setGame.score)")
                        Spacer()
                        Button {
                            setGame.transitionType = .threeCards
                            setGame.dealThreeMoreCards()
                        } label: {
                            Text("Deal 3 More Cards")
                        }
                        .foregroundStyle(setGame.dealingIsDisabled ? .gray : .blue)
                        
                    }
                }
                
                .padding()
            
        }
        .onAppear {
            setGame.transitionType = .newGame
            setGame.dealInitialCards()
        }
       
    }
          
    private struct Game {
        static let desiredCardWidth = 80.0
    }
    
    private func columns(for size: CGSize) -> [GridItem] {
        let minColumns = 2
        var columns = minColumns
        let visibleCardCount = setGame.dealtCards.count

        while true {
            columns += 1
            let spacingWidth = CGFloat(columns - 1) * Card.paddingScaleFactor
            let proposedCardWidth = (size.width - spacingWidth) / CGFloat(columns)
            let rows = Int(ceil(Double(visibleCardCount) / Double(columns)))

            let heightRequired = CGFloat(rows) * (proposedCardWidth / Card.aspectRatio) + CGFloat(rows - 1) * Card.paddingScaleFactor
            if heightRequired <= size.height * 0.9 {
                break
            }
        }

        return Array(repeating: GridItem(.flexible()), count: columns)
    }
    
    private struct Card {
        static let aspectRatio: Double = 3.0/2.0
        static let paddingScaleFactor = 0.5
    }
    
    private let cardTransitionDelay: Double = 0.2
    private func transitionDelay(card: SetGameModel.Card) -> Double {
        guard let index = setGame.dealtCards.firstIndex(where: { $0.id == card.id }) else {return 0}
        
        switch setGame.transitionType {
        case .threeCards:
            return Double(index-(setGame.dealtCards.count-1)) * cardTransitionDelay
        case .newGame:
            return Double(index) * cardTransitionDelay
        case .selectCard:
            return 0
        }

    }

}



#Preview {
    SetGameView(setGame: SetGameViewModel())
}
        

