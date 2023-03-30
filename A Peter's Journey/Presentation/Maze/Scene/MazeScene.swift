//
//  MazeScene.swift
//  A Peter's Journey
//
//  Created by Robson Lima Lopes on 30/03/23.
//

import SpriteKit
import CoreMotion

class MazeScene: SKScene {

    private var manager: CMMotionManager? = CMMotionManager()
    private var timer: Timer?
    internal var seconds: Double?

    private let brickWidth: CGFloat = 30

    var floor: [CGPoint]?
    var wallBricksAsNodes: [SKSpriteNode]?

    private var boyAsCircle: SKShapeNode = SKShapeNode()
    private var momAsCircle: SKShapeNode = SKShapeNode()
    private var dollAsCircle: SKShapeNode = SKShapeNode()

    override func didMove(to view: SKView) {

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

    private func buildMazeInScene() {
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

    private func buildBallsInScene() {
        boyAsCircle = CircleNode(
            radius: brickWidth/2,
            position: floor!.randomElement()!,
            color: .blue
        ) as SKShapeNode

        addChild(boyAsCircle)

        momAsCircle = CircleNode(
            radius: brickWidth/2,
            position: floor!.randomElement()!,
            color: .red
        ) as SKShapeNode

        addChild(momAsCircle)

        dollAsCircle = CircleNode(
            radius: brickWidth/2,
            position: floor!.randomElement()!,
            color: .white
        ) as SKShapeNode

        addChild(dollAsCircle)
    }

    private func buildBackgroundScene() {
        let background = SKSpriteNode(imageNamed: "floor")
        background.position = CGPoint(x: size.width, y: size.height)
        background.zPosition = -1
        addChild(background)
    }

    override func update(_ currentTime: TimeInterval) {
        if let gravityX = manager?.deviceMotion?.gravity.y,
           let gravityY = manager?.deviceMotion?.gravity.x
           {
            boyAsCircle.physicsBody?.applyImpulse(CGVector(dx: CGFloat(-gravityX)*150, dy: CGFloat(gravityY)*150))
            momAsCircle.physicsBody?.applyImpulse(CGVector(dx: CGFloat(-gravityX)*150, dy: CGFloat(gravityY)*150))
            dollAsCircle.physicsBody?.applyImpulse(CGVector(dx: CGFloat(-gravityX)*150, dy: CGFloat(gravityY)*150))
        }

    }

    @objc func increaseTimer() {
        seconds = (seconds ?? 0.0) + 0.01
    }
}

