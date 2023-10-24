//
//  ContentView.swift
//  Squiggle
//
//  Created by Noelia Root on
//  10/7/23
//

import SwiftUI

struct SetGameView: View {
    let setGame: SetGameViewModel
    var cardsAreMatched: Bool {
        setGame.dealtCards.filter({$0.isMatched == true}).count > 0
    }
    
    var body: some View {
        
        GeometryReader { geometry in
                VStack {
                    topMenu
                    ScrollView{
                        LazyVGrid(columns: columns(for: geometry.size)) {
                            ForEach(setGame.dealtCards) { card in
                                CardView(card: card)
                                    .onTapGesture {
                                        setGame.selectCard(card)
                                    }
                                    .transition(.cardTransition(size: geometry.size))
                            }
                        }
                    }
                    Spacer()
                    bottomMenu
                }
                
                .padding()
            
        }
        .onAppear {
            setGame.dealInitialCards()
        }
       
    }
    
    private func columns(for size: CGSize) -> [GridItem] {
        let minColumns = 2
        var columns = minColumns
        let visibleCardCount = setGame.dealtCards.count

        while true {
            columns += 1
            let spacingWidth = CGFloat(columns - 1) * CardConstants.paddingScaleFactor
            let proposedCardWidth = (size.width - spacingWidth) / CGFloat(columns)
            let rows = Int(ceil(Double(visibleCardCount) / Double(columns)))

            let heightRequired = CGFloat(rows) * (proposedCardWidth / CardConstants.aspectRatio) + CGFloat(rows - 1) * CardConstants.paddingScaleFactor
            if heightRequired <= size.height * 0.9 {
                break
            }
        }

        return Array(repeating: GridItem(.flexible()), count: columns)
    }
    
    var topMenu: some View {
        HStack{
            Text("SET!")
                .font(.largeTitle)
                .bold()
            Spacer()
            VStack(alignment: .trailing) {
                Text("Number of Sets: \(setGame.numberOfSets)")
                Text("Score: \(setGame.score)")
            }
            .font(.headline)
        }
    }
    
    var bottomMenu: some View {
        HStack {
            Button {
                setGame.newGame()
            } label: {
                Text("New Game")
            }
            Spacer()
            Text("Cards Left: \(setGame.deck.count)")
            Spacer()
            Button {
                setGame.dealThreeMoreCards()
            } label: {
                Text("Deal 3 More Cards")
            }
            .foregroundStyle(setGame.dealingIsDisabled ? .gray : .blue)
            
        }
    }


}


#Preview {
    SetGameView(setGame: SetGameViewModel())
}
        

