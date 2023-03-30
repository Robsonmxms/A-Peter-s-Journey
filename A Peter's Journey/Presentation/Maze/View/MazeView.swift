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

        let scene = MazeScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill

        view.presentScene(scene)

        return view
    }

    func updateUIView(_ view: SKView, context: Context) {
        // Empty
    }

}

struct MazeView: View {
    var body: some View {
        VStack {
            MazeViewRepresentable().ignoresSafeArea()
        }

    }
}
