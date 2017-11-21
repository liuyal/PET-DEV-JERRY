//
//  User_Model.swift
//  PET
//
//  Created by liuyal on 10/27/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import Foundation

// Class: LevelSelect_View
// Members:
//          1. ID: String -> User UID
//          2. name: String -> Full name of user
//          3. age: Int -> Age of user
//          4. gender: String -> Gender of user
//          5. email: String -> email of account
//          6. password: String -> password of account
//          7. progress: ProgressArray -> Progress array object
// Description:
class User_Model {
    
    // Function: Defult Constructor create defult user object
    // Pre-Req: N/A
    // Input: N/A
    // Ouput: N/A
    public init(){
        self.ID = ""
        self.name = ""
        self.age = 0
        self.gender = ""
        self.email = ""
        self.password = ""
        self.progress = ProgressArray()
        self.CustomQArray = [QuestionClass]()
    }
    
    // Function: Create User object with input parameters
    // Pre-Req: N/A
    // Input:
    //          1. ID: String -> User UID
    //          2. name: String -> Full name of user
    //          3. age: Int -> Age of user
    //          4. gender: String -> Gender of user
    //          5. email: String -> email of account
    //          6. password: String -> password of account
    //          7. progress: ProgressArray -> Progress array object
    // Ouput: N/A
    public init(ID: String, name: String, age: Int, gender: String, email: String, password: String, progress: ProgressArray, cqarray: [QuestionClass]){
        self.ID = ID
        self.name = name
        self.age = age
        self.gender = gender
        self.email = email
        self.password = password
        self.progress = progress
        self.CustomQArray = cqarray
    }
    
    // ----------------MEMBER VARIABLE---------------
    var ID: String
    var name: String
    var age: Int
    var gender: String
    var email: String
    var password: String
    var progress: ProgressArray
    var CustomQArray: [QuestionClass]
    
    // ----------------PRINT MEMBERS-------------------
    public func print_user(){
        print("ID: ", self.ID);
        print("Name: ", self.name);
        print("Age: ", self.age);
        print("Gender: ", self.gender);
        print("Email: ", self.email);
        print("Password: ", self.password);
    }
}
