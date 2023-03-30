//
//  CircleNode.swift
//  A Peter's Journey
//
//  Created by Robson Lima Lopes on 30/03/23.
//

import SpriteKit

class CircleNode: SKShapeNode {

    init(radius: CGFloat, position: CGPoint, color: UIColor) {
        super.init()

        self.position = position

        let circle = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius*1.5, height: radius*1.5), transform: nil)

        self.path = circle
        self.fillColor = color
        self.strokeColor = .clear

        // Configuração da física do nó do círculo
        self.physicsBody = SKPhysicsBody(circleOfRadius: (radius*1.5)/2)
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
