//
//  MenuSceneView.swift
//  APetersJourney
//
//  Created by Marcelo De Araújo on 26/04/23.
//

import SwiftUI
import SpriteKit

struct MenuViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.frame = UIScreen.main.bounds

        let scene = MenuScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill

        view.presentScene(scene)

        return view
    }

    func updateUIView(_ view: SKView, context: Context) {
    }
}

struct MenuView: View {
    var body: some View {
        MenuViewRepresentable().ignoresSafeArea()
    }
}
