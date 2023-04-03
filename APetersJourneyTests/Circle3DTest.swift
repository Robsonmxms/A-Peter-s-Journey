//
//  Circle3DTest.swift
//  APetersJourneyTests
//
//  Created by Marcelo De Araújo on 03/04/23.
//

import XCTest
import SceneKit
@testable import APetersJourney

final class Circle3DTest: XCTestCase {

    // given
    var sut: SphereSCNNode!
    let color = UIColor.blue

    override func setUp() {

        //when
        super.setUp()
        sut = SphereSCNNode(color: color)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInitWithValidColor() {

        // then
        XCTAssertEqual(sut.geometry?.materials.first?.diffuse.contents as? UIColor, color)
    }
}
