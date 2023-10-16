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
            ScrollView{
                VStack {
                    LazyVGrid(columns: columns(for: geometry.size)) {
                        ForEach(setGame.dealtCards) { card in
                            CardView(card: card)
                                .onTapGesture {
                                    setGame.selectCard(card)
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
        }
        .onAppear {
            setGame.dealInitialCards()
        }
    }
    private struct Game {
        static let desiredCardWidth = 80.0
    }
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / Game.desiredCardWidth))
    }
}



#Preview {
    SetGameView(setGame: SetGameViewModel())
}
        
