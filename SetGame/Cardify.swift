//
//  Cardify.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var isSelected: Bool
    var isMatched: Bool?
        
    var animatableData: Double {
        get { isSelected ? 1.1 : 1.0 }
        set { scale = newValue }
    }
    
    private var scale: Double

    init(isSelected: Bool, isMatched: Bool?) {
        self.isSelected = isSelected
        self.isMatched = isMatched
        self.scale = isSelected ? 1.1 : 1.0
    }
    
    var backgroundColor: Color {
        if (isMatched == true && isSelected == true) {
            Color.green.opacity(0.5)
        } else if (isMatched == false && isSelected == true) {
            Color.red.opacity(0.5)
        } else if (isMatched == nil && isSelected == true) {
            Color.yellow
        } else {
            Color.white
        }
    }
    
    func body(content: Content) -> some View {
            GeometryReader{geometry in
                ZStack{
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke()
                        .background {
                            backgroundColor
                        }
                    content
                        .scaleEffect(isSelected && isMatched == true ? 1.2 : 1.0)
                        .animation(Animation.spring(duration: 0.5).repeatForever(), value: isMatched)
                        
                }
                .padding(geometry.size.width * Card.paddingScaleFactor)
            }
            
            .aspectRatio(Card.aspectRatio, contentMode: .fit)
            
            
    }
    
    // MARK: - Drawing Constants
    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.08
    }
    
    private struct Card {
        static let aspectRatio: Double = 2.0/3.0
        static let paddingScaleFactor = 0.04
    }
    
}

extension View {
    func cardify(isSelected: Bool, isMatched: Bool?) -> some View {
        modifier(Cardify(isSelected: isSelected, isMatched: isMatched))
    }
}
