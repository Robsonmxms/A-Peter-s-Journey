//
//  MazeModel.swift
//  APetersJourney
//
//  Created by Robson Lima Lopes on 11/04/23.
//

import SpriteKit

struct MazeModel {
    var brickWidth: CGFloat = 30

    var floor: [CGPoint]?
    var wallBricksAsNodes: [SKSpriteNode]?

    var boyAsSphereSKNode = SKNode()
    var momAsSphereSKNode = SKNode()
    var dollAsSphereSKNode = SKNode()

    var boyPosition: CGPoint?
    var boyPositionIndex: Int?
    var momPosition: CGPoint?
    var dollPosition: CGPoint?
}
