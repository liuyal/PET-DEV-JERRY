//
//  UserModelTests.swift
//  PETTests
//
//  Created by liuyal on 10/31/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import XCTest
import Firebase
@testable import PET

class UserModelTests: XCTestCase {
    
    var U1: User_Model!
    var U2: User_Model!
    var P: ProgressArray!
    
    override func setUp() {
        super.setUp()
        P = ProgressArray()
        U1 = User_Model()
        U2 = User_Model(ID: "1",name: "Peter",age: 2, gender: "Alien",email: "email",password: "password",progress: P)
    }
    
    func testDefaultConstructor()
    {
        XCTAssertTrue(U1.ID == "")
        XCTAssertTrue(U1.name == "")
        XCTAssertTrue(U1.age == 0)
        XCTAssertTrue(U1.gender == "")
        XCTAssertTrue(U1.email == "")
        XCTAssertTrue(U1.password == "")
    }
    
    func testConstructor()
    {
        XCTAssertTrue(U2.ID == "1")
        XCTAssertTrue(U2.name == "Peter")
        XCTAssertTrue(U2.age == 2)
        XCTAssertTrue(U2.gender == "Alien")
        XCTAssertTrue(U2.email == "email")
        XCTAssertTrue(U2.password == "password")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
