//
//  MazeScene.swift
//  APetersJourney
//
//  Created by Marcelo De Araújo on 31/03/23.
//

import SpriteKit
import CoreMotion
import SceneKit

class MazeScene: SKScene, SKPhysicsContactDelegate {

    internal var manager: CMMotionManager? = CMMotionManager()
    internal var timer: Timer?
    internal var seconds: Double?

    internal let brickWidth: CGFloat = 30

    internal var floor: [CGPoint]?
    internal var wallBricksAsNodes: [SKSpriteNode]?

    internal lazy var boyAsSphereSKNode = SKNode()
    internal lazy var momAsSphereSKNode = SKNode()
    internal lazy var dollAsSphereSKNode = SKNode()

    override func didMove(to view: SKView) {

        physicsWorld.contactDelegate = self

        let frameAdjusted = CGRect(
            x: frame.origin.x,
            y: frame.origin.y,
            width: self.frame.width,
            height: self.frame.height
        )
        physicsBody = SKPhysicsBody(edgeLoopFrom: frameAdjusted)

        if let manager = manager, manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.01
            manager.startDeviceMotionUpdates()
        }

        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(increaseTimer),
            userInfo: nil,
            repeats: true
        )

        buildMazeInScene()
        buildBallsInScene()
        buildBackgroundScene()

    }

    internal func buildBallsInScene() {

        let boyAsSphereSCNNode = SphereSCNNode(color: .blue) as SCNNode

        let boyPosition = floor!.randomElement()!
        let boyPositionIndex = floor!.firstIndex(of: boyPosition)

        boyAsSphereSKNode = SphereSKNode(
            brickWidth: brickWidth,
            sphereSCNNode: boyAsSphereSCNNode,
            position: boyPosition
        ) as SKNode

        addChild(boyAsSphereSKNode)

        let momAsSphereSCNNode = SphereSCNNode(color: .red) as SCNNode

        let momPosition = getRandomProportionPosition(
            boyPositionIndex: boyPositionIndex!,
            proportion: 0.6
        )

        momAsSphereSKNode = SphereSKNode(
            brickWidth: brickWidth,
            sphereSCNNode: momAsSphereSCNNode,
            position: momPosition
        ) as SKNode

        addChild(momAsSphereSKNode)

        let dollAsSphereSCNNode = SphereSCNNode(color: .white) as SCNNode

        let dollPosition = getRandomProportionPosition(
            boyPositionIndex: boyPositionIndex!,
            proportion: 0.8)

        dollAsSphereSKNode = SphereSKNode(
            brickWidth: brickWidth,
            sphereSCNNode: dollAsSphereSCNNode,
            position: dollPosition
        ) as SKNode

        addChild(dollAsSphereSKNode)
    }

    internal func buildMazeInScene() {

        let maze: Maze = Maze(
            size: size,
            brickWidth: brickWidth,
            floorWallsProportion: 0.1
        )

        floor = maze.getFloor()

        wallBricksAsNodes = maze.getWallsAsSKSpriteNode()

        for wallBrick in wallBricksAsNodes! {
            addChild(wallBrick)
        }
    }

    internal func getRandomProportionPosition(
        boyPositionIndex: Int,
        proportion: Double
    ) -> CGPoint {
        let sublist: Array = {
            let proportionIndex = Int(Double(floor!.count)*proportion)

            let distBetweenBoyAndProportionIndex = floor!.distance(
                from: boyPositionIndex,
                to: proportionIndex
            )

            let distBetweenProportionIndexAndLastElem = floor!.distance(
                from: proportionIndex,
                to: floor!.count-1
            )

            if distBetweenProportionIndexAndLastElem <= distBetweenBoyAndProportionIndex {
                return Array(floor!.suffix(distBetweenProportionIndexAndLastElem))
            } else {
                return Array(floor!.prefix(distBetweenProportionIndexAndLastElem))
            }
        }()

        return sublist.randomElement()!
    }

    internal func buildBackgroundScene() {

        let background = SKSpriteNode(imageNamed: "floor")
        background.position = CGPoint(x: size.width, y: size.height)
        background.zPosition = -1
        addChild(background)
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node
        let bodyB = contact.bodyB.node

        let isBoyCatchingDoll = (bodyA == boyAsSphereSKNode && bodyB == dollAsSphereSKNode)
        let isDollCatchingBoy = (bodyA == dollAsSphereSKNode && bodyB == boyAsSphereSKNode)

        let isMomCatchingBoy = (bodyA == momAsSphereSKNode && bodyB == boyAsSphereSKNode)
        let isBoyCatchingMom = (bodyA == boyAsSphereSKNode && bodyB == momAsSphereSKNode)

        let isMomCatchingDoll = (bodyA == momAsSphereSKNode && bodyB == dollAsSphereSKNode)
        let isDollCatchingMom = (bodyA == dollAsSphereSKNode && bodyB == momAsSphereSKNode)

//         Verifique se a boy tocou na doll
        if isBoyCatchingDoll || isDollCatchingBoy {
            let alert = UIAlertController(
                title: "Vc pegou a boneca",
                message: "Parabéns!",
                preferredStyle: .alert
            )
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }

//         Verifique se a mom tocou na boy
        if  isMomCatchingBoy || isBoyCatchingMom {
            let alert = UIAlertController(title: "Mamãe te pegou", message: "Perdeu", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }

//         Verifique se a mom tocou na doll
        if isMomCatchingDoll || isDollCatchingMom {
            let alert = UIAlertController(
                title: "Mamãe pegou a boneca",
                message: "Vc voltará ao inicio",
                preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if let gravityX = manager?.deviceMotion?.gravity.y,
           let gravityY = manager?.deviceMotion?.gravity.x {

            boyAsSphereSKNode.physicsBody?.applyImpulse(CGVector(
                dx: CGFloat(-gravityX)*150,
                dy: CGFloat(gravityY)*150)
            )
            momAsSphereSKNode.physicsBody?.applyImpulse(CGVector(
                dx: CGFloat(-gravityX)*150,
                dy: CGFloat(gravityY)*150)
            )
            dollAsSphereSKNode.physicsBody?.applyImpulse(CGVector(
                dx: CGFloat(-gravityX)*150,
                dy: CGFloat(gravityY)*150)
            )
        }
    }

    @objc func increaseTimer() {
        seconds = (seconds ?? 0.0) + 0.01
    }
}
