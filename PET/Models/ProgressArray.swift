//
//  ProgessArray.swift
//  PET
//
//  Created by liuyal on 10/27/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import UIKit
import Foundation

// Global constants for progress array
let TIER_SIZE = 6
let Q_PER_TIER = 10
let ARRAY_SIZE = TIER_SIZE * Q_PER_TIER

// Class: ProgressArray
// Members:
//          1. userID: String -> linking to user DB to store progress
//          2. ArraySize: int -> Size of progress array detected should = ARRAY_SIZE
//          3. percComp: Double -> array of doubles repressenting completion rate of each level
//          4. questionArray: QuestionClass() -> Array of question objects
// Description:
public class ProgressArray{
    
    // ----------------MEMBER VARIABLE---------------
    public var userID: String
    public var ArraySize: Int
    public var percComp = [Double]()
    var questionArray = [QuestionClass]()
    
    // Function: Defult Constructor create defult Progress array object
    // Pre-Req: N/A
    // Input: N/A
    // Ouput: N/A
    public init() {
        userID = ""
        ArraySize = 0;
        percComp = Array(repeating: 0.00, count: TIER_SIZE)
        
        for i in 0..<TIER_SIZE{
            for j in 0..<Q_PER_TIER{
                questionArray.append(QuestionClass(levelID: i, questionID: j, emotion: .happy, errCnt: 0, questionState: .initial, imageFileRef: "", picture: #imageLiteral(resourceName: "Snow-PNG-Transparent-Image-1"), urlIn: ""))
                self.ArraySize += 1
            }
        }
    }
    
    // Function: Pass in value to create object ProgressArray
    // Pre-Req: N/A
    // Input:
    //          1. useriD: String -> User UID
    //          2. emotionIn:[emotionID] -> Array of emotion enum that matches each question
    //          3. StateIn: [state] -> Array of question state enum that matches each question
    //          4. pictureIn:[[UIImage]] -> image in memory of quesiton
    //          5. urlIn: String -> Url of image stored on database
    // Ouput: N/A
    init(useriD: String, emotionIn: [[emotionID]], StateIn: [state], promptIn: [[String]], pictureIn:[[UIImage]], urlIn: [String]) {
        userID = useriD
        ArraySize = 0
        percComp = Array(repeating: 0.00, count: TIER_SIZE)
        
        for i in 0..<TIER_SIZE{
            for j in 0..<Q_PER_TIER{
                // Update emotion ID base on ID ARRAYbase
                questionArray.append(QuestionClass(levelID: i, questionID: j, emotion: emotionIn[i][j], errCnt: 0, questionState: StateIn[ArraySize], imageFileRef: promptIn[i][j], picture: pictureIn[i][j], urlIn: urlIn[ArraySize]))
                self.ArraySize += 1
            }
        }
    }
    
    // Function: Update percComp member variable for all tiers/levels
    // Pre-Req: N/A
    // Input: N/A
    // Ouput: N/A
    public func update_total_CompRate(){
        for ii in 0..<TIER_SIZE{
            update_tier_CompRate(tierID: ii)
        }
    }
    
    // Function: Update percComp member variable for input tiers/levels
    // Pre-Req: N/A
    // Input: tierID: Int -> Index of tier inputted
    // Ouput: N/A
    public func update_tier_CompRate(tierID: Int){
        
        var counter = 0
        
        for jj in (tierID*10)..<(Q_PER_TIER * (tierID + 1)){
            if self.questionArray[jj].questionState != .correct{   }
            else{counter += 1}
        }
        self.percComp[tierID] = Double(counter)/Double(Q_PER_TIER)
    }
    
    // Function: Print function for question objects in progress array ** Testing only **
    // Pre-Req: N/A
    // Input: N/A
    // Ouput: N/A
    public func printArray(){
        for i in 0..<self.ArraySize{
            print(self.questionArray[i].levelID,self.questionArray[i].questionID)
            print("Level ID: ", self.questionArray[i].levelID)
            print("Question ID: ", self.questionArray[i].questionID)
            print("emotion ID: ", self.questionArray[i].emotion)
            print("errCnt: ", self.questionArray[i].errCnt)
            print("questionState: ", self.questionArray[i].questionState)
            print("imageFileRef: ", self.questionArray[i].imageFileRef, "\n")
        }
    }
}

