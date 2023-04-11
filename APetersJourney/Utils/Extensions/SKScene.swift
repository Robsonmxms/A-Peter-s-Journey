//
//  SKScene.swift
//  APetersJourney
//
//  Created by Robson Lima Lopes on 11/04/23.
//

import SpriteKit

extension SKScene {
    func removeAllNodes() {
        for node in self.children {
            node.removeFromParent()
        }
    }
}
