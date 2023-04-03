//
//  APetersJourneyTests.swift
//  APetersJourneyTests
//
//  Created by Marcelo De Araújo on 31/03/23.
//

import XCTest
import SpriteKit
@testable import APetersJourney

final class CircleNodeTest: XCTestCase {

    // given
    var sut: CircleNode!

    let radius: CGFloat = 20
    let position = CGPoint(x: 100, y: 100)
    let color = UIColor.red

    override func setUp() {

        // when
        super.setUp()
        sut = CircleNode(radius: radius, position: position, color: color)

    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInit() {

        // then
        XCTAssertEqual(sut.position, position)
        XCTAssertEqual(sut.fillColor, color)
        XCTAssertNotNil(sut.strokeColor)
        XCTAssertEqual(sut.physicsBody?.mass, 4.5)
        XCTAssertEqual(sut.physicsBody?.allowsRotation, false)
        XCTAssertEqual(sut.physicsBody?.isDynamic, true)
        XCTAssertEqual(sut.physicsBody?.affectedByGravity, false)
        XCTAssertEqual(sut.physicsBody?.categoryBitMask, 1)
        XCTAssertEqual(sut.physicsBody?.collisionBitMask, 1)
        XCTAssertEqual(sut.physicsBody?.contactTestBitMask, 1)
    }
}

