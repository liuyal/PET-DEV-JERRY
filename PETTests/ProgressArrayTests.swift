//
//  ProgressArrayTests.swift
//  PETTests
//
//  Created by liuyal on 10/31/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import XCTest
import Firebase
@testable import PET

class ProgressArrayTests: XCTestCase {
        
        var P1: ProgressArray!
        var P2: ProgressArray!
        var P3: ProgressArray!
        
        override func setUp() {
            super.setUp()
            
            // Put setup code here. This method is called before the invocation of each test method in the class.
            // use empty initializer
            P1 = ProgressArray()
            P2 = ProgressArray(useriD: "12345", emotionIn: [.happy, .sad, .angry, .scared,.happy, .sad, .angry, .scared, .happy, .sad, .angry, .scared,.happy, .sad, .angry, .scared,.happy, .sad, .angry, .scared], StateIn: [.initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial, .initial])
        }
        
        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
            P1 = nil
            P2 = nil
            super.tearDown()
        }
        
        func testDefaultConstructor()
        {
            var pos = 0
            
            for i in 0..<TIER_SIZE{
                for j in 0..<Q_PER_TIER{
                    pos = (i * Q_PER_TIER) + j
                    XCTAssertTrue(P1.questionArray[pos].levelID == i)
                    XCTAssertTrue(P1.questionArray[pos].questionID == j)
                    XCTAssertTrue(P1.questionArray[pos].errCnt == 0)
                    XCTAssertTrue(P1.questionArray[pos].questionState == .initial)
                }
            }
            
            XCTAssertTrue(P1.ArraySize == TIER_SIZE * Q_PER_TIER)
            
            for i in 0..<TIER_SIZE{
                XCTAssertTrue(P1.percComp[i] == 0.00)
            }
        }
        
        
        func testP1Init() {
            XCTAssert(P1.userID == "")
        }
        
        func testP2Init() {
            XCTAssert(P2.userID == "12345")
        }
}
