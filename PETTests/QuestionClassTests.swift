//
//  PETTests.swift
//  PETTests
//
//  Created by Wolf on 2017-10-18.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import XCTest
import Firebase
@testable import PET

class QuestionClassTests: XCTestCase {
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    override func setUp() {
        super.setUp()
    }
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    override func tearDown() {
        super.tearDown()
    }
    
    // Test the default constructor initializes itself with default values
    func testDefaultConstructorInitialization() {
        let Q = QuestionClass()
        XCTAssertTrue(Q.levelID == 0)
        XCTAssertTrue(Q.questionID == 0)
        XCTAssertTrue(Q.emotion == .happy)
        XCTAssertTrue(Q.errCnt == 0)
        XCTAssertTrue(Q.questionState == .initial)
        XCTAssertTrue(Q.imageFileRef == "")
        
    }
    
    // Tests the constructor initializes itself with valid input
    func testConstructorAllValidArguments() {
        let Q = QuestionClass(levelID: 2, questionID: 1, emotion: .sad, errCnt: 1, questionState: .initial, imageFileRef: "Blank")
        XCTAssertTrue(Q.levelID == 2)
        XCTAssertTrue(Q.questionID == 1)
        XCTAssertTrue(Q.emotion == .sad)
        XCTAssertTrue(Q.errCnt == 1)
        XCTAssertTrue(Q.questionState == .initial)
        XCTAssertTrue(Q.imageFileRef == "Blank")
        
    }
    
    // Tests the constructor initializes itself with invalid input
    // A levelId less than 0 will be set to a zero
    func testConstructorInValidLevelIDArgument1() {
        let Q = QuestionClass(levelID: -1, questionID: 1, emotion: .sad, errCnt: 1, questionState: .initial, imageFileRef: "Blank")
        
        let Q_2 = QuestionClass(levelID: 0, questionID: 1, emotion: .sad, errCnt: 1, questionState: .initial, imageFileRef: "Blank")
        
        XCTAssertTrue(Q.levelID == 0)
        XCTAssertTrue(Q.questionID == 1)
        XCTAssertTrue(Q.emotion == .sad)
        XCTAssertTrue(Q.errCnt == 1)
        XCTAssertTrue(Q.questionState == .initial)
        XCTAssertTrue(Q.imageFileRef == "Blank")
        
        XCTAssertTrue(Q_2.levelID == 0)
        XCTAssertTrue(Q_2.questionID == 1)
        XCTAssertTrue(Q_2.emotion == .sad)
        XCTAssertTrue(Q_2.errCnt == 1)
        XCTAssertTrue(Q_2.questionState == .initial)
        XCTAssertTrue(Q_2.imageFileRef == "Blank")
        
    }
    
    // Tests the constructor initializes itself with invalid input
    // A levelId greater than TIER_SIZE will be set to TIER_SIZE
    func testConstructorInValidLevelIDArgument2() {
        let Q = QuestionClass(levelID: TIER_SIZE + 1, questionID: 1, emotion: .sad, errCnt: 1, questionState: .initial, imageFileRef: "Blank")
        
        let Q_2 = QuestionClass(levelID: TIER_SIZE, questionID: 1, emotion: .sad, errCnt: 1, questionState: .initial, imageFileRef: "Blank")
        
        XCTAssertTrue(Q.levelID == TIER_SIZE)
        XCTAssertTrue(Q.questionID == 1)
        XCTAssertTrue(Q.emotion == .sad)
        XCTAssertTrue(Q.errCnt == 1)
        XCTAssertTrue(Q.questionState == .initial)
        XCTAssertTrue(Q.imageFileRef == "Blank")
        
        XCTAssertTrue(Q_2.levelID == TIER_SIZE)
        XCTAssertTrue(Q_2.questionID == 1)
        XCTAssertTrue(Q_2.emotion == .sad)
        XCTAssertTrue(Q_2.errCnt == 1)
        XCTAssertTrue(Q_2.questionState == .initial)
        XCTAssertTrue(Q_2.imageFileRef == "Blank")
    }
    
    // Tests the constructor initializes itself with invalid input
    // A questionId less than 0 will be set to a zero
    func testConstructorInValidQuestionIDArgument1() {
        let Q = QuestionClass(levelID: 0, questionID: -1, emotion: .sad, errCnt: 1, questionState: .initial, imageFileRef: "Blank")
        
        let Q_2 = QuestionClass(levelID: 0, questionID: 0, emotion: .sad, errCnt: 1, questionState: .initial, imageFileRef: "Blank")
        
        XCTAssertTrue(Q.levelID == 0)
        XCTAssertTrue(Q.questionID == 0)
        XCTAssertTrue(Q.emotion == .sad)
        XCTAssertTrue(Q.errCnt == 1)
        XCTAssertTrue(Q.questionState == .initial)
        XCTAssertTrue(Q.imageFileRef == "Blank")
        
        XCTAssertTrue(Q_2.levelID == 0)
        XCTAssertTrue(Q_2.questionID == 0)
        XCTAssertTrue(Q_2.emotion == .sad)
        XCTAssertTrue(Q_2.errCnt == 1)
        XCTAssertTrue(Q_2.questionState == .initial)
        XCTAssertTrue(Q_2.imageFileRef == "Blank")
    }
    
    // Tests the constructor initializes itself with invalid input
    // A questionId greater than Q_PER_TIER will be set to Q_PER_TIER
    func testConstructorInValidQuestionIDArgument2() {
        let Q = QuestionClass(levelID: 0, questionID: Q_PER_TIER + 1, emotion: .sad, errCnt: 1, questionState: .initial, imageFileRef: "Blank")
        
        let Q_2 = QuestionClass(levelID: 0, questionID: Q_PER_TIER, emotion: .sad, errCnt: 1, questionState: .initial, imageFileRef: "Blank")
        
        XCTAssertTrue(Q.levelID == 0)
        XCTAssertTrue(Q.questionID == Q_PER_TIER)
        XCTAssertTrue(Q.emotion == .sad)
        XCTAssertTrue(Q.errCnt == 1)
        XCTAssertTrue(Q.questionState == .initial)
        XCTAssertTrue(Q.imageFileRef == "Blank")
        
        XCTAssertTrue(Q_2.levelID == 0)
        XCTAssertTrue(Q_2.questionID == Q_PER_TIER)
        XCTAssertTrue(Q_2.emotion == .sad)
        XCTAssertTrue(Q_2.errCnt == 1)
        XCTAssertTrue(Q_2.questionState == .initial)
        XCTAssertTrue(Q_2.imageFileRef == "Blank")
    }
    
    // Tests the constructor initializes itself with invalid input
    // A errCnt less than 0 will be set to a zero
    func testConstructorInValidErrCntArgument1() {
        let Q = QuestionClass(levelID: 0, questionID: 0, emotion: .sad, errCnt: -1, questionState: .initial, imageFileRef: "Blank")
        
        let Q_2 = QuestionClass(levelID: 0, questionID: 0, emotion: .sad, errCnt: 0, questionState: .initial, imageFileRef: "Blank")
        
        XCTAssertTrue(Q.levelID == 0)
        XCTAssertTrue(Q.questionID == 0)
        XCTAssertTrue(Q.emotion == .sad)
        XCTAssertTrue(Q.errCnt == 0)
        XCTAssertTrue(Q.questionState == .initial)
        XCTAssertTrue(Q.imageFileRef == "Blank")
        
        XCTAssertTrue(Q_2.levelID == 0)
        XCTAssertTrue(Q_2.questionID == 0)
        XCTAssertTrue(Q_2.emotion == .sad)
        XCTAssertTrue(Q_2.errCnt == 0)
        XCTAssertTrue(Q_2.questionState == .initial)
        XCTAssertTrue(Q_2.imageFileRef == "Blank")
    }
    
    // Tests that access to internal letiables is public.
    // Notice: These public letiables can be changed to invalid values after object creation
    func testMemberletiablesPublic() {
        let Q = QuestionClass()
        XCTAssertTrue(Q.levelID == 0)
        Q.levelID = 1
        XCTAssertTrue(Q.levelID == 1)
        
        XCTAssertTrue(Q.questionID == 0)
        Q.questionID = 1
        XCTAssertTrue(Q.questionID == 1)
        
        XCTAssertTrue(Q.emotion == .happy)
        Q.emotion = .angry
        XCTAssertTrue(Q.emotion == .angry)
        
        XCTAssertTrue(Q.errCnt == 0)
        Q.errCnt = 3
        XCTAssertTrue(Q.errCnt == 3)
        
        XCTAssertTrue(Q.questionState == .initial)
        Q.questionState = .correct
        XCTAssertTrue(Q.questionState == .correct)
        
        XCTAssertTrue(Q.imageFileRef == "")
        Q.imageFileRef = "Not Blank"
        XCTAssertTrue(Q.imageFileRef == "Not Blank")
    }
    
    func testPerformanceExample() {self.measure {}}
}







