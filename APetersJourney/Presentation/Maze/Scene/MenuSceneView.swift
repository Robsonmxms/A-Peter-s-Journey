//
//  MenuSceneView.swift
//  APetersJourney
//
//  Created by Marcelo De Araújo on 26/04/23.
//

import SwiftUI
import SpriteKit

struct MenuSceneView: View {

    var body: some View {
        SpriteView(scene: MenuScene())
            .ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}
