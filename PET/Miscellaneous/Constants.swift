//
//  Constants.swift
//  PET
//
//  Created by liuyal on 10/29/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//
import UIKit
import Foundation

// NEED TO BE UPDATE TO FIT QUESTIONS
struct Constants {
    
    // Question Answers  *** Need to be set ***
    static let emoIDArray0: [emotionID] = [.happy, .sad, .angry, .scared, .excited, .inlove, .happy, .confused, .scared, .happy]
    static let emoIDArray1: [emotionID] = [.sad, .inlove, .happy, .scared, .excited, .angry, .shy, .sick, .confident, .confused]
    static let emoIDArray2: [emotionID] = [.sick, .angry, .inlove, .scared, .confident, .sad, .excited, .confused, .shy, .happy]
    static let emoIDArray3: [emotionID] = [.confident, .surprised, .shy, .sad, .angry, .confused, .inlove, .happy, .sick, .scared]
    static let emoIDArray4: [emotionID] = [.inlove, .embarrassed, .scared, .confident, .happy, .shy, .sad, .excited, .confused, .angry]
    static let emoIDArray5: [emotionID] = [.surprised, .shy, .confused, .excited, .sick, .scared, .angry, .embarrassed, .inlove, .confident]
    
    static let emoIDArray = [emoIDArray0,emoIDArray1,emoIDArray2,emoIDArray3,emoIDArray4,emoIDArray5]
    
    // Array for initialization
    static let stateIDArray: [state] = Array(repeating: .initial, count: TIER_SIZE*10)
    static let urlDArray: [String] = Array(repeating: "?", count: TIER_SIZE*10)
    
    // Question Prompt array  *** Need to be set ***
    static let QuestionString0: [String] = ["How does SpongBob feel?",
                                            "How does Blossom feel?",
                                            "How does patrick feel?",
                                            "How does Morty feel?",
                                            "How does Goofy feel?",
                                            "How does Donald and Daisy feel?",
                                            "How does Snoopy feel?",
                                            "How does John feel?",
                                            "How does Homer feel?",
                                            "How does the minions feel?"]

    static let QuestionString1: [String] = ["How does Ralph feel?",
                                            "How does Gina feel?",
                                            "How does Philip J. Fry feel?",
                                            "How does Samantha feel?",
                                            "How does Homer feel?",
                                            "How does Sarah and Daisy feel?",
                                            "How does Dumas feel?",
                                            "How does Lily feel?",
                                            "How does Sam feel?",
                                            "How does the Calvin feel?"]

    static let QuestionString2: [String] = ["How does Susie feel?",
                                             "How does Johny feel?",
                                             "How do Amy and Brad feel?",
                                             "How does Alex feel?",
                                             "How does Peter feel?",
                                             "How does Dexter feel?",
                                             "How does Jennifer feel?",
                                             "How does Patrick feel?",
                                             "How does Amanda feel?",
                                             "How does the Brennan feel?"]

    static let QuestionString3: [String] = ["How does George Clooney feel?",
                                            "How does Samantha feel?",
                                            "How does Patricia feel?",
                                            "How does Brenda feel?",
                                            "How does Ivan feel?",
                                            "How does Brody feel?",
                                            "How does the emoji feel?",
                                            "How does Liljiana feel?",
                                            "How does Bobby feel?",
                                            "How does the Travis feel?"]

    static let QuestionString4: [String] = ["How does Felicia feel?",
                                            "How does Alexis feel?",
                                            "How does Bobby feel?",
                                            "How does Jane feel?",
                                            "How does Snoop Dogg feel?",
                                            "How does Hillary feel?",
                                            "How does Little Teresa feel?",
                                            "How does ELF feel?",
                                            "How does Cam feel?",
                                            "How does the Susanna feel?"]

    static let QuestionString5: [String] = ["How does Joe feel?",
                                            "How does Barbara Palvin feel?",
                                            "How does Senator McCain feel?",
                                            "How does Margot feel?",
                                            "How does Derek feel?",
                                            "How does Petra feel?",
                                            "How does Tina feel?",
                                            "How does Alia feel?",
                                            "How do Gina and Terran feel?",
                                            "How does the Stephanie feel?"]
    
    static let QuestionStringArray = [QuestionString0,QuestionString1,QuestionString2,QuestionString3,QuestionString4,QuestionString5]
    
    // Image array *** Need to be set ***
    static let imageArray0: [UIImage] = [#imageLiteral(resourceName: "00_happy.png"),#imageLiteral(resourceName: "01_sad"),#imageLiteral(resourceName: "02_angry"),#imageLiteral(resourceName: "03_scared"),#imageLiteral(resourceName: "04_excited"),#imageLiteral(resourceName: "05_inlove"),#imageLiteral(resourceName: "06_happy"),#imageLiteral(resourceName: "07_confused"),#imageLiteral(resourceName: "08_scared"),#imageLiteral(resourceName: "09_happy")]
    static let imageArray1: [UIImage] = [#imageLiteral(resourceName: "10_sad"),#imageLiteral(resourceName: "11_inlove"),#imageLiteral(resourceName: "12_happy.png"),#imageLiteral(resourceName: "13_scared"),#imageLiteral(resourceName: "14_excited"),#imageLiteral(resourceName: "15_Angry"),#imageLiteral(resourceName: "16_shy"),#imageLiteral(resourceName: "17_sick"),#imageLiteral(resourceName: "18_confident"),#imageLiteral(resourceName: "19_confused")]
    static let imageArray2: [UIImage] = [#imageLiteral(resourceName: "20_sick"),#imageLiteral(resourceName: "21_angry"),#imageLiteral(resourceName: "22_inlove"),#imageLiteral(resourceName: "23_scared"),#imageLiteral(resourceName: "24_confident"),#imageLiteral(resourceName: "25_sad"),#imageLiteral(resourceName: "26_excited"),#imageLiteral(resourceName: "27_confused"),#imageLiteral(resourceName: "28_shy"),#imageLiteral(resourceName: "29_happy")]
    static let imageArray3: [UIImage] = [#imageLiteral(resourceName: "30_confident"),#imageLiteral(resourceName: "31_surprised"),#imageLiteral(resourceName: "32_shy"),#imageLiteral(resourceName: "33_sad"),#imageLiteral(resourceName: "34_angry"),#imageLiteral(resourceName: "35_confused"),#imageLiteral(resourceName: "36_inlove"),#imageLiteral(resourceName: "37_happy"),#imageLiteral(resourceName: "38_sick"),#imageLiteral(resourceName: "39_scared")]
    static let imageArray4: [UIImage] = [#imageLiteral(resourceName: "40_inlove"),#imageLiteral(resourceName: "41_embrassed"),#imageLiteral(resourceName: "42_scared"),#imageLiteral(resourceName: "43_confident"),#imageLiteral(resourceName: "44_happy"),#imageLiteral(resourceName: "45_shy"),#imageLiteral(resourceName: "46_sad"),#imageLiteral(resourceName: "47_excited"),#imageLiteral(resourceName: "48_confused"),#imageLiteral(resourceName: "49_angry")]
    static let imageArray5: [UIImage] = [#imageLiteral(resourceName: "50_surprised"),#imageLiteral(resourceName: "51_shy"),#imageLiteral(resourceName: "52_confused"),#imageLiteral(resourceName: "53_excited.png"),#imageLiteral(resourceName: "54_sick"),#imageLiteral(resourceName: "55_scared"),#imageLiteral(resourceName: "56_angry"),#imageLiteral(resourceName: "57_embarrassed"),#imageLiteral(resourceName: "58_inlove"),#imageLiteral(resourceName: "59_confident")]
    
    static let pictureArray = [imageArray0, imageArray1,imageArray2, imageArray3, imageArray4, imageArray5]
   
    static let cardImageArray = [#imageLiteral(resourceName: "happy"),#imageLiteral(resourceName: "sad"),#imageLiteral(resourceName: "scared"),#imageLiteral(resourceName: "angry"),#imageLiteral(resourceName: "surprised"),#imageLiteral(resourceName: "inlove"),#imageLiteral(resourceName: "confused"),#imageLiteral(resourceName: "shy"),#imageLiteral(resourceName: "excited"),#imageLiteral(resourceName: "sick"),#imageLiteral(resourceName: "confident"),#imageLiteral(resourceName: "embarrassed")]
    
    static let emotionIDArray: [emotionID] = [.happy, .sad, .scared, .angry, .surprised, .inlove, .confused, .shy, .excited, .sick, .confident, .embarrassed]
    
}
