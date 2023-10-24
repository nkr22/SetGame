//
//  Tranistion+Extensions.swift
//  SetGame
//
//  Created by Noelia Root on 10/18/23.
//

import SwiftUI

public extension AnyTransition {

    static func cardTransition(size: CGSize) -> AnyTransition {
        let insertion = AnyTransition.offset(flyFrom (for: size))
        let removal = AnyTransition.offset(flyTo (for: size))
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static func flyFrom(for size:CGSize) -> CGSize {
        CGSize(width: 0.0,
               height: 2 * size.height)
    }
    static func flyTo(for size:CGSize) -> CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let angle = Double.random(in: 0..<360)
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGSize(width: x, height: y)
    }
}
