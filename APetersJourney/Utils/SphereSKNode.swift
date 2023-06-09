//
//  SphereSKNode.swift
//  APetersJourney
//
//  Created by Marcelo De Araújo on 31/03/23.
//

import SpriteKit
import SceneKit

class SphereSKNode: SKNode {
    init(
        brickWidth: CGFloat,
        sphereSCNNode: SCNNode,
        position: CGPoint
    ) {
        super.init()

        let sphereSK3DNode = SK3DNode()
        let scene = SCNScene()
        scene.rootNode.addChildNode(sphereSCNNode)

        sphereSK3DNode.viewportSize = CGSize(
            width: brickWidth*0.8,
            height: brickWidth*0.8
        )

        sphereSK3DNode.scnScene = scene

        self.addChild(sphereSK3DNode)

        self.position = position

        self.physicsBody = SKPhysicsBody(
            circleOfRadius: (brickWidth/2)*0.6
        )
        self.physicsBody?.mass = 4.5
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.contactTestBitMask = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
