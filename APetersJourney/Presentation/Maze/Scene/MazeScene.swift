//
//  MazeScene.swift
//  APetersJourney
//
//  Created by Marcelo De Araújo on 31/03/23.
//

import SpriteKit
import CoreMotion
import SceneKit

class MazeScene: SKScene {

    var manager: CMMotionManager? = CMMotionManager()
    var timer: Timer?
    var seconds: Double?

    var mazeModel = MazeModel()

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
        self.backgroundColor = UIColor(named: "background")!

        buildSceneNodes()

    }

    private func buildSceneNodes() {
        buildMazeInScene()
        buildBallsInScene()
    }

    private func buildMazeInScene() {

        let maze: Maze = Maze(
            size: size,
            brickWidth: mazeModel.brickWidth,
            floorWallsProportion: 0.1
        )

        mazeModel.floor = maze.getFloor()

        mazeModel.wallBricksAsNodes = maze.getWallsAsSKSpriteNode()

        for wallBrick in mazeModel.wallBricksAsNodes! {
            addChild(wallBrick)
        }
    }

    private func buildBallsInScene() {
        buildBoyInScene()
        buildMomInScene()
        buildDollInScene()
    }

    private func buildBoyInScene() {

        let scene = SCNScene(named: "boy.scn")

        mazeModel.boyPosition = mazeModel.floor!.randomElement()!
        mazeModel.boyPositionIndex = mazeModel.floor!.firstIndex(of: mazeModel.boyPosition!)

        mazeModel.boyAsSphereSKNode = Object3dSKNode(
            brickWidth: mazeModel.brickWidth,
            sphereSCNScene: scene!,
            position: mazeModel.boyPosition!
        ) as SKNode

        addChild(mazeModel.boyAsSphereSKNode)
    }

    private func buildMomInScene() {

        let scene = SCNScene(named: "mother.scn")

        mazeModel.momPosition = getRandomProportionPosition(
            boyPositionIndex: mazeModel.boyPositionIndex!,
            proportion: 0.6
        )

        mazeModel.momAsSphereSKNode = Object3dSKNode(
            brickWidth: mazeModel.brickWidth,
            sphereSCNScene: scene!,
            position: mazeModel.momPosition!
        ) as SKNode

        addChild(mazeModel.momAsSphereSKNode)
    }

    private func buildDollInScene() {

        let scene = SCNScene(named: "doll.scn")

        mazeModel.dollPosition = getRandomProportionPosition(
            boyPositionIndex: mazeModel.boyPositionIndex!,
            proportion: 0.8)

        mazeModel.dollAsSphereSKNode = Object3dSKNode(
            brickWidth: mazeModel.brickWidth,
            sphereSCNScene: scene!,
            position: mazeModel.dollPosition!
        ) as SKNode

        addChild(mazeModel.dollAsSphereSKNode)
    }

    private func getRandomProportionPosition(
        boyPositionIndex: Int,
        proportion: Double
    ) -> CGPoint {
        let sublist: Array = {
            let proportionIndex = Int(Double(mazeModel.floor!.count)*proportion)

            let distBetweenBoyAndProportionIndex = mazeModel.floor!.distance(
                from: boyPositionIndex,
                to: proportionIndex
            )

            let distBetweenProportionIndexAndLastElem = mazeModel.floor!.distance(
                from: proportionIndex,
                to: mazeModel.floor!.count-1
            )

            if distBetweenProportionIndexAndLastElem <= distBetweenBoyAndProportionIndex {
                return Array(mazeModel.floor!.suffix(distBetweenProportionIndexAndLastElem))
            } else {
                return Array(mazeModel.floor!.prefix(distBetweenProportionIndexAndLastElem))
            }
        }()

        return sublist.randomElement()!
    }

    private func showWinner() {

        let alert = UIAlertController(
            title: "Vc pegou a boneca! 🥇",
            message: "Parabéns!",
            preferredStyle: .alert
        )
        let newGameAction = UIAlertAction(title: "Novo Jogo", style: .default) { _ in
            self.removeAllNodes()
            if self.mazeModel.brickWidth >= 25 {
                self.mazeModel.brickWidth -= 5
                self.buildSceneNodes()
            } else {
                let alert = UIAlertController(
                    title: "Parabéns!",
                    message: "Você Finalizou o jogo",
                    preferredStyle: .alert
                )
                let action = UIAlertAction(title: "OK", style: .default) {(_) in
                    self.goBack()
                }
                alert.addAction(action)
                self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                return
            }
        }
        alert.addAction(newGameAction)
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)

    }

    private func goBack() {
        let transition = SKTransition.fade(withDuration: 3)
        let nextScene = MenuScene(size: UIScreen.main.bounds.size)
        self.view!.presentScene(nextScene, transition: transition)
    }

    override func update(_ currentTime: TimeInterval) {
        if let gravityX = manager?.deviceMotion?.gravity.y,
           let gravityY = manager?.deviceMotion?.gravity.x {

            mazeModel.boyAsSphereSKNode.physicsBody?.applyImpulse(CGVector(
                dx: CGFloat(-gravityX)*100,
                dy: CGFloat(gravityY)*100)
            )
            mazeModel.momAsSphereSKNode.physicsBody?.applyImpulse(CGVector(
                dx: CGFloat(-gravityX)*100,
                dy: CGFloat(gravityY)*100)
            )
            mazeModel.dollAsSphereSKNode.physicsBody?.applyImpulse(CGVector(
                dx: CGFloat(-gravityX)*100,
                dy: CGFloat(gravityY)*100)
            )
        }
    }

    @objc func increaseTimer() {
        seconds = (seconds ?? 0.0) + 0.01
    }
}

extension MazeScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {


        let bodyA = contact.bodyA.node
        let bodyB = contact.bodyB.node

        let isBoyCatchingDoll = (bodyA == mazeModel.boyAsSphereSKNode &&
                                 bodyB == mazeModel.dollAsSphereSKNode)
        let isDollCatchingBoy = (bodyA == mazeModel.dollAsSphereSKNode &&
                                 bodyB == mazeModel.boyAsSphereSKNode)

        let isMomCatchingBoy = (bodyA == mazeModel.momAsSphereSKNode &&
                                bodyB == mazeModel.boyAsSphereSKNode)
        let isBoyCatchingMom = (bodyA == mazeModel.boyAsSphereSKNode &&
                                bodyB == mazeModel.momAsSphereSKNode)

        let isMomCatchingDoll = (bodyA == mazeModel.momAsSphereSKNode &&
                                 bodyB == mazeModel.dollAsSphereSKNode)
        let isDollCatchingMom = (bodyA == mazeModel.dollAsSphereSKNode &&
                                 bodyB == mazeModel.momAsSphereSKNode)

//         Verifique se a boy tocou na doll
        if isBoyCatchingDoll || isDollCatchingBoy {
            showWinner()
        }

//         Verifique se a mom tocou na boy
        if  isMomCatchingBoy || isBoyCatchingMom {
            let alert = UIAlertController(title: "Mamãe te pegou", message: "Perdeu", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) {(_) in
                self.goBack()
            }
            alert.addAction(action)
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }

//         Verifique se a mom tocou na doll
        if isMomCatchingDoll || isDollCatchingMom {
            showMomCatchDoll()
        }
    }

    private func reloadSpawnPoints() {
        mazeModel.boyAsSphereSKNode.position = mazeModel.boyPosition!
        mazeModel.momAsSphereSKNode.position = mazeModel.momPosition!
        mazeModel.dollAsSphereSKNode.position = mazeModel.dollPosition!
    }

    private func showMomCatchDoll() {

        let alert = UIAlertController(
            title: "Mamãe pegou a boneca 😅",
            message: "Tente novamente",
            preferredStyle: .alert
        )
        let newGameAction = UIAlertAction(title: "Reinicie a Fase", style: .default) { _ in
            self.reloadSpawnPoints()
        }
        alert.addAction(newGameAction)
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
