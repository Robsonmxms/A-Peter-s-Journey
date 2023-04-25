//
//  MazeView.swift
//  A Peter's Journey
//
//  Created by Robson Lima Lopes on 30/03/23.
//

import SwiftUI
import SpriteKit

struct MazeViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.frame = UIScreen.main.bounds

        let scene = InitialScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill

        view.presentScene(scene)

        return view
    }

    func updateUIView(_ view: SKView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let transition = SKTransition.fade(withDuration: 3)
            view.frame = UIScreen.main.bounds
            let nextScene = MazeScene(size: view.bounds.size)
            view.presentScene(nextScene, transition: transition)
        }
    }
}

struct MazeView: View {
    var body: some View {
        MazeViewRepresentable().ignoresSafeArea()
    }
}
