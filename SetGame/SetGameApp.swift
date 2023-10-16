//
//  SetGameApp.swift
//  SetGame
//
//  Created by Noelia Root on 10/7/23.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(setGame: SetGameViewModel())
        }
    }
}
