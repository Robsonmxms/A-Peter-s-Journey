//
//  MazeTest.swift
//  APetersJourneyTests
//
//  Created by Marcelo De Araújo on 03/04/23.
//

import XCTest
@testable import APetersJourney

final class MazeTest: XCTestCase {


    // given
    var sut: Maze!

    let size = CGSize(width: 500, height: 500)
    let brickWidth: CGFloat = 20
    let floorWallsProportion: Double = 0.4

    override func setUp() {

        //when
        super.setUp()
        sut = Maze(size: size, brickWidth: brickWidth, floorWallsProportion: floorWallsProportion)
        

    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }


    func testFloorAndWallListSize() {

        // then
        // (width x height) / (brickWidthˆ2) = 625
        XCTAssertEqual((sut.getFloor().count + sut.getWalls().count), 625)
    }

    func testWallNodes() {

        //when
        let wallNodes = sut.getWallsAsSKSpriteNode()

        for wallNode in wallNodes {

            // then
            XCTAssertNotNil(wallNode.physicsBody)
        }
    }

    func testWallNodesPosition() {

        //when
        let wallNodes = sut.getWallsAsSKSpriteNode()
        let walls = sut.getWalls()

        for i in 0..<walls.count {

            // then
            XCTAssertEqual(wallNodes[i].position, walls[i])
        }
    }
}

