//
//  SphereSKNodeTest.swift
//  APetersJourneyTests
//
//  Created by Marcelo De Araújo on 03/04/23.
//

import XCTest
import SceneKit
@testable import APetersJourney
import SpriteKit

final class SphereSKNodeTest: XCTestCase {

    // given
    var sut: SphereSKNode!
    let color = UIColor.blue
    let sphereSCNNode = SCNNode(geometry: SCNSphere(radius: 1))
    let brickWidth: CGFloat = 100
    let position = CGPoint(x: 50, y: 50)


    override func setUp() {
        super.setUp()
        sut = SphereSKNode(brickWidth: brickWidth, sphereSCNNode: sphereSCNNode, position: position)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSphereSKNode() {

        XCTAssertEqual(sut.position, CGPoint(x: 50, y: 50))
        XCTAssertNotNil(sut.physicsBody)
        XCTAssertEqual(sut.physicsBody?.categoryBitMask, 1)
        XCTAssertEqual(sut.physicsBody?.collisionBitMask, 1)
        XCTAssertEqual(sut.physicsBody?.contactTestBitMask, 1)
        XCTAssertEqual(sut.physicsBody?.allowsRotation, false)
        XCTAssertEqual(sut.physicsBody?.isDynamic, true)
        XCTAssertEqual(sut.physicsBody?.mass, 4.5)
        XCTAssertFalse(sut.physicsBody === SKPhysicsBody(circleOfRadius: (brickWidth/2)*0.6))
    }
}
