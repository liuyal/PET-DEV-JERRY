//
//  QuestionClass.swift
//  PET
//
//  Created by liuyal on 10/27/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import UIKit
import Foundation

// Enum for QuestionClass -> emotion
enum emotionID{
    
    case happy      //10
    case sad        //2
    case angry      //3
    case scared     //4
    
    case surprised  //5
    case inlove     //6
    case confused   //7
    case shy        //8
    
    case excited    //9
    case sick       //11
    case confident  //12
    case embarrassed//13
}

// Enum for QuestionClass -> questionState
enum state{
    case initial // 0
    case correct // 1
    case incorrect // 2
    case skipped // 3
}

// Class: QuestionClass
// Members:
//          1. userID: String -> linking to user DB to store progress
//          2. ArraySize: int -> Size of progress array detected should = ARRAY_SIZE
//          3. percComp: Double -> array of doubles repressenting completion rate of each level
//          4. questionArray: QuestionClass() -> Array of question objects
// Description:
class QuestionClass {
    
    // Function: Defult Constructor create defult QuestionClass object
    // Pre-Req: N/A
    // Input: N/A
    // Ouput: N/A
    public init(){
        self.questionID = 0
        self.levelID = 0
        self.emotion = .happy
        self.errCnt = 0
        self.questionState = .initial
        self.imageFileRef = ""
        self.image = #imageLiteral(resourceName: "Snow-PNG-Transparent-Image-1")
        self.url = ""
    }
    
    // Function: Pass in value to create object QuestionClass
    // Pre-Req: N/A
    // Input:
    //          1. levelID: Int -> User UID
    //          2. questionID: Int -> emotion enum that matches question
    //          3. emotion: emotionID ->  question state enum that matches question
    //          4. errCnt: Int -> Counter or error selection
    //          5. questionState: state -> state of question
    //          6. imageFileRef: String -> reference to question prompt
    //          7. picture: UIImage -> image in memory of quesiton
    //          8. urlIn: String -> Url of image stored on database
    // Ouput: N/A
    init(levelID: Int, questionID: Int, emotion: emotionID, errCnt: Int, questionState: state, imageFileRef: String, picture: UIImage , urlIn: String){
       
        if levelID < 0{ self.levelID = 0 }
        else if levelID >= TIER_SIZE { self.levelID = TIER_SIZE }
        else { self.levelID = levelID}
        
        if questionID < 0{ self.questionID = 0 }
        else { self.questionID = questionID }
      
        self.emotion = emotion
        
        if errCnt < 0{ self.errCnt = 0 }
        else { self.errCnt = errCnt}
        
        self.questionState = questionState
        self.imageFileRef = imageFileRef
        
        self.image = picture
        
        self.url = urlIn
    }
    
     // ----------------MEMBER VARIABLE---------------
    var levelID: Int
    var questionID: Int
    var emotion: emotionID
    var errCnt: Int
    var questionState: state
    var imageFileRef: String
    var image: UIImage
    var url: String
}
