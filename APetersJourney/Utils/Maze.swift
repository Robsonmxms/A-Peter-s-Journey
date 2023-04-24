//
//  Maze.swift
//  A Peter's Journey
//
//  Created by Robson Lima Lopes on 30/03/23.
//

import SpriteKit

class Maze {
    private var walls: [CGPoint] = []
    private var floor: [CGPoint] = []
    private let brickWidth: CGFloat
    private let size: CGSize
    private let floorWallsProportion: Double
    private let bigBricksTextures: [SKTexture] = [
        SKTexture(imageNamed: "rock1"),
        SKTexture(imageNamed: "rock2"),
        SKTexture(imageNamed: "rock3"),
        SKTexture(imageNamed: "rock8"),
        SKTexture(imageNamed: "rock9")
    ]

    private let smallBrickstextures: [SKTexture] = [
        SKTexture(imageNamed: "rock4"),
        SKTexture(imageNamed: "rock5"),
        SKTexture(imageNamed: "rock6"),
        SKTexture(imageNamed: "rock7"),
        SKTexture(imageNamed: "rock10")
    ]

    init(
        size: CGSize,
        brickWidth: CGFloat,
        floorWallsProportion: Double
    ) {
        self.size = size
        self.brickWidth = brickWidth
        self.floorWallsProportion = floorWallsProportion
        buildGrid()
    }

    private func buildGrid() {
        for theColumn in stride(from: brickWidth/2, to: size.height, by: brickWidth) {
            for theRow in stride(from: brickWidth/2, to: size.width, by: brickWidth) {
                walls.append(CGPoint(x: theRow, y: theColumn))
            }
        }

        while Double(floor.count/walls.count)<floorWallsProportion {
            if floor.isEmpty {
                buildFloor(startPoint: walls.randomElement()!)
            } else {
                buildFloor(startPoint: floor.randomElement()!)
            }

        }
    }

    private func buildFloor(startPoint: CGPoint) {

        let topPoint = CGPoint(
            x: startPoint.x + brickWidth,
            y: startPoint.y
        )

        let leadingPoint = CGPoint(
            x: startPoint.x,
            y: startPoint.y - brickWidth
        )

        let trailingPoint = CGPoint(
            x: startPoint.x,
            y: startPoint.y + brickWidth
        )

        let bottomPoint = CGPoint(
            x: startPoint.x - brickWidth,
            y: startPoint.y
        )

        let availablePoints: [CGPoint] = getAvailablePoints(points: [
            topPoint, leadingPoint, trailingPoint, bottomPoint
        ])

        if !availablePoints.isEmpty {
            guard let point = availablePoints.randomElement() else {
                fatalError("point isn't available")
            }
            buildBrick(point: point)
        }
    }

    private func buildBrick(point: CGPoint) {
        walls.removeAll { $0 == point}
        floor.append(point)
        buildFloor(startPoint: point)
    }

    private func getAvailablePoints(points: [CGPoint]) -> [CGPoint] {
        var availablePoints: [CGPoint] = []

        for point in points where walls.contains(point) {
                availablePoints.append(point)
        }

        return availablePoints
    }

    func getFloor() -> [CGPoint] {
        return floor
    }

    func getWalls() -> [CGPoint] {
        return walls
    }

    func getWallsAsSKSpriteNode() -> [SKSpriteNode] {
        var spriteNodes: [SKSpriteNode] = []

        buildBigBrick(spriteNodes: &spriteNodes)
        buildSmallBrick(spriteNodes: &spriteNodes)

        return spriteNodes
    }

    private func buildBigBrick(spriteNodes: inout [SKSpriteNode]) {
        let totalBricksPositions = walls.count
        var randomBricksPositions = [CGPoint]()
        let howManyBigBricks = Int(walls.count/3)

        let startIndex = Int.random(
            in: 0...(totalBricksPositions - howManyBigBricks)
        )

        for index in startIndex..<(startIndex + howManyBigBricks) {
            randomBricksPositions.append(walls[index])
        }

        for point in randomBricksPositions {
            let topPoint: CGPoint = CGPoint(
                x: point.x+brickWidth,
                y: point.y
            )

            let trailingPoint: CGPoint = CGPoint(
                x: point.x,
                y: point.y+brickWidth
            )

            let topTrailingPoint: CGPoint = CGPoint(
                x: point.x+brickWidth,
                y: point.y+brickWidth
            )

            let haveTop: Bool = walls.contains(topPoint)
            let haveTrailing: Bool = walls.contains(trailingPoint)
            let haveTopTrailing: Bool = walls.contains(topTrailingPoint)
            let haveSelfPoint: Bool = walls.contains(point)

            let texture = bigBricksTextures.randomElement()!

            let wallBrick = SKSpriteNode(
                texture: texture
            )

            if haveTop && haveTrailing && haveTopTrailing && haveSelfPoint {
                walls.removeAll {$0 == topPoint}
                walls.removeAll {$0 == trailingPoint}
                walls.removeAll {$0 == topTrailingPoint}
                walls.removeAll {$0 == point}

                wallBrick.size = CGSize(width: brickWidth*2, height: brickWidth*2)
                wallBrick.position = CGPoint(
                    x: point.x + brickWidth/2,
                    y: point.y + brickWidth/2
                )
                wallBrick.physicsBody = SKPhysicsBody(texture: texture, size: wallBrick.size)
//                wallBrick.physicsBody = SKPhysicsBody(rectangleOf: wallBrick.size)
                wallBrick.physicsBody?.isDynamic = false
                wallBrick.physicsBody?.collisionBitMask = 1
                spriteNodes.append(wallBrick)
            }
        }
    }

    private func buildSmallBrick(spriteNodes: inout [SKSpriteNode]) {
        for point in walls {
            let wallBrick = SKSpriteNode(
                texture: smallBrickstextures.randomElement()!
            )

                wallBrick.size = CGSize(width: brickWidth, height: brickWidth)

                wallBrick.position = point

                wallBrick.physicsBody = SKPhysicsBody(rectangleOf: wallBrick.size)
                wallBrick.physicsBody?.isDynamic = false
                spriteNodes.append(wallBrick)
        }
    }

}
