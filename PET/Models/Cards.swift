//
//  Cards.swift
//  Template
//
//  Created by liuyal on 11/14/17.
//  Copyright © 2017 J.L. All rights reserved.
//

import UIKit
import Foundation

// Global constants for Emotion Cards Deck (Answer buttons)
let DeckSize = 12

// Class: Cards
// Members:
//          1. emoPic: UIImage -> Image of card
//          2. emotion: emotionID -> emotion enum of card
//          3. tagNum: Int -> tag number for card
// Description:
class Cards{
    
    // Function: Defult Constructor create defult Cards object
    // Pre-Req: N/A
    // Input: N/A
    // Ouput: N/A
    init(){
        self.emoPic = #imageLiteral(resourceName: "happy")
        self.emotion = .happy
        self.tagNum = 0
    }
    
    // Function: Pass in value to create object Emotion Cards
    // Pre-Req: N/A
    // Input:
    //          1. picture: UIImage -> Image of card
    //          2. emot: emotionID -> emotion enum of card
    //          3. tagNumIn: Int -> tag of card
    // Ouput: N/A
    init(picture: UIImage, emot: emotionID, tagNumIn: Int){
        
        self.emoPic = picture
        self.emotion = emot
        self.tagNum = tagNumIn
    }
    
    // Member variables
    var emoPic: UIImage
    var emotion: emotionID
    var tagNum: Int
}
