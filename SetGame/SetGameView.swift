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
                                        setGame.selectCard(card)
                                    }
                                
                            }
                        }
                    }
                    
                    Spacer()
                    HStack {
                        Button {
                            setGame.newGame()
                        } label: {
                            Text("New Game")
                        }
                        Spacer()
                        Text("\(setGame.score)")
                        Spacer()
                        Button {
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
            if heightRequired <= size.height {
                break
            }
        }

        return Array(repeating: GridItem(.flexible()), count: columns)
    }
    
    private struct Card {
        static let aspectRatio: Double = 2.0/3.0
        static let paddingScaleFactor = 0.04
    }
}



#Preview {
    SetGameView(setGame: SetGameViewModel())
}
        

