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

    init(isSelected: Bool, isMatched: Bool?) {
        self.isSelected = isSelected
        self.isMatched = isMatched
    }
    
    var backgroundColor: Color {
        if (isMatched == true && isSelected == true) {
            Color.green.opacity(CardConstants.shadeOpacity)
        } else if (isMatched == false && isSelected == true) {
            Color.pink.opacity(CardConstants.shadeOpacity)
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
                        .animation(Animation.spring(duration: CardConstants.animationDuration).repeatForever(), value: isMatched)
                        
                }
            }
            .aspectRatio(CardConstants.aspectRatio, contentMode: .fit)
    }
    
    // MARK: - Drawing Constants
    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.08
    }
    
}

extension View {
    func cardify(isSelected: Bool, isMatched: Bool?) -> some View {
        modifier(Cardify(isSelected: isSelected, isMatched: isMatched))
    }
}
