//
//  InitialScene.swift
//  APetersJourney
//
//  Created by Ana Raiany Guimarães Gomes on 2023-04-25.
//

import SpriteKit

class InitialScene: SKScene {

    private lazy var background: SKSpriteNode = {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = CGSize(width: frame.width, height: frame.height)
        background.zPosition = 0
        return background
    }()

    private lazy var peixe1: SKSpriteNode = {
        let peixe1 = SKSpriteNode(imageNamed: "peixe1")
        peixe1.position = CGPoint(x: size.width/2, y: size.height/2 + 300)
        peixe1.size = CGSize(width: 256, height: 256)
        peixe1.zPosition = 1
        return peixe1
    }()
    private lazy var label: SKLabelNode = {
        let label = SKLabelNode(text: "Pause")
        label.position = CGPoint(x: size.width/2, y: size.height/2 - 300)
        label.name = "PlayAndPause"
        label.fontColor = UIColor.black
        label.fontSize = 100
        return label
    }()

    override func didMove(to view: SKView) {
        addChild(background)
        addChild(peixe1)
        addChild(label)
    }

}
