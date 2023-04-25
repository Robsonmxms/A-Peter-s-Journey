//
//  GameBoard.swift
//  APetersJourney
//
//  Created by Ana Raiany Guimarães Gomes on 2023-04-25.
//

import SwiftUI
import SpriteKit

struct GameBoard: View {
    var scene: SKScene {
        let scene = InitialScene()
        scene.scaleMode = .resizeFill
        return scene
    }

    var body: some View {
        GeometryReader { frame in
            SpriteView(scene: scene)
                .frame(width: frame.size.width, height: frame.size.height, alignment: .center)
        }
    }
}

struct GameBoard_Previews: PreviewProvider {
    static var previews: some View {
        GameBoard()
    }
}
