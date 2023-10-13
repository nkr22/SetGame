//
//  Cardify.swift
//  SetGame
//
//  Created by Noelia Root on 10/12/23.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var isSelected: Bool
        
    var animatableData: Double {
        get { isSelected ? 1.1 : 1.0 }
        set { scale = newValue }
    }
    
    private var scale: Double

    init(isSelected: Bool) {
        self.isSelected = isSelected
        self.scale = isSelected ? 1.1 : 1.0
    }
    
    func body(content: Content) -> some View {
        
        GeometryReader {geometry in
            ZStack{
                RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke()
                content
            }
            .padding(geometry.size.width * Card.paddingScaleFactor)
            .aspectRatio(Card.aspectRatio, contentMode: .fit)
        }
        .scaleEffect(isSelected ? 1.1 : 1.0)
    }
    
    // MARK: - Drawing Constants
    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.08
    }
    
    private struct Card {
        static let aspectRatio: Double = 5.0/7.0
        static let fontScaleFactor = 0.75
        static let paddingScaleFactor = 0.04
    }
    
}

extension View {
    func cardify(isSelected: Bool) -> some View {
        modifier(Cardify(isSelected: isSelected))
    }
}
