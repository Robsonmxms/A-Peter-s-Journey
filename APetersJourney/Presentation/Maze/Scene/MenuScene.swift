//
//  InitialScene.swift
//  APetersJourney
//
//  Created by Ana Raiany Guimarães Gomes on 2023-04-25.
//

import SpriteKit

class MenuScene: SKScene {

    private lazy var peterImage: SKSpriteNode = {
        let background = SKSpriteNode(imageNamed: "menuBackground")
        background.position = CGPoint(x: size.width/5, y: size.width/4)
        background.size = CGSize(width: frame.width/2, height: frame.width/2)
        background.zPosition = 0
        return background
    }()

    private lazy var title: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Noteworthy")
        label.text = "A Peter's Journey"
        label.position = CGPoint(x: size.width*0.6, y: size.height*0.7)
        label.fontColor = UIColor.white
        label.fontSize = size.width*0.1
        return label
    }()

    private lazy var button: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Apple-Chancery")
        label.text = "Play"
        label.position = CGPoint(x: size.width*0.65, y: size.height*0.2)
        label.fontColor = UIColor.white
        label.fontSize = size.width*0.1

        let pulseUp = SKAction.scale(to: 1.1, duration: 0.5)
        let pulseDown = SKAction.scale(to: 1.0, duration: 0.5)
        let pulse = SKAction.sequence([pulseUp, pulseDown])

        let repeatPulse = SKAction.repeatForever(pulse)
        label.run(repeatPulse)
        return label
    }()

    override func didMove(to view: SKView) {
        addChild(peterImage)
        addChild(title)
        addChild(button)
        self.backgroundColor = UIColor(named: "background")!
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            for node in nodes where node == button {
                let transition = SKTransition.fade(withDuration: 3)
                let nextScene = MazeScene(size: UIScreen.main.bounds.size)
                self.view!.presentScene(nextScene, transition: transition)
            }
        }
    }
}
