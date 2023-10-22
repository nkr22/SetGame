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
        CGSize(width:  CGFloat.random(in: -5*size.width...5*size.width),
               height: CGFloat.random(in: -3*size.height...(-size.height)))
    }
}
