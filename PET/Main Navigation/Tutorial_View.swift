//
//  Tutorial_View.swift
//  PET
//
//  Created by Wolf on 2017-10-19.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import UIKit
import FirebaseAuth
import FirebaseDatabase

// Class: Tutorial_View
// Members:
//          1.
//          2.
//          3.
//          4.
// Description:
class Tutorial_View: UIViewController {
    
    //Reference to FireDataBase
    var ref: DatabaseReference!
    
    // User object for passing of object between views
    var user: User_Model?
    
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var currentText: UITextView!
    
    var Counter:Int = 0
    // Image array
    // Index 0: Level Selection
    //       1: Question Selection
    //       2: Question
    //       3: Question Updated (wrong)
    //       4: Next Question
    //       5: Question Updated (correct)
    //       5: Question Selection Updated
    let imageArray:[UIImage] = [#imageLiteral(resourceName: "Level_Select"), #imageLiteral(resourceName: "Question_Select"), #imageLiteral(resourceName: "Question_Intial"), #imageLiteral(resourceName: "Question_Updated"), #imageLiteral(resourceName: "Question_Correct"), #imageLiteral(resourceName: "Updated_Question_select"), #imageLiteral(resourceName: "Updated_Level_Progress"),#imageLiteral(resourceName: "QuestionManager_Init"), #imageLiteral(resourceName: "QuestionMaker_Init"), #imageLiteral(resourceName: "QuestionMaker_AddImage"), #imageLiteral(resourceName: "QuestionMaker_PickEmotion"), #imageLiteral(resourceName: "QuestionManager_Update"), #imageLiteral(resourceName: "QuestionBank_View"), #imageLiteral(resourceName: "NewQuestion")]
    
    // Text array
    let textArray:[String] = ["Welcome to Gameplay Tutorial! Here is Level Select, you can choose which level of questions you want to play. Click 'Next' to see what's in Level 1.", "These are the questions in Level 1, and you can select where you want to start. Once you have gotten a question right, it will be blacked out to indicate complete. Click 'Next' to play!", "Here is an example question, if you answer wrong the answer will be blacked out. Click 'Next' to see!", "Here is the question after you got the wrong answer, with the answer selected blacked out. Click 'Next' to see what happens when you get the right answer!", "Here is the message after you got a question right! Click 'Next' to see the updated Question Selection View!", "Here is the updated Question Selection View, now you see that you completed Question 1! Click 'Next' to see your progress in Level Select!", "Here you see that you completed 10% of Level 1. Click 'Next' to see the Custom Questions Tutorial, or click the return arrow in the top right corner to start playing!","Welcome to Custom Question Tutorial. From Main Menu, when you select 'Question Manager, this is the page you will get to. Right now there are no Custom Questions, click 'Next' to see what happens when press the '+' in the top right corner to add a Question!", "Here is the Question Maker. Click 'Next' to see what happens when you want to select a Custom Image!", "Here you can pick an image from either the camera or your photo gallery! Click 'Next' to continue!", "Once you have picked the image, you can select an Emotion from the drop down menu, then press 'Create' to create the question. Click 'Next' to go back to Question Manager!", "Here we see the updated Question Manager with the added question. Click 'Next' to go to Gameplay and see how you can play these Custom Questions!", "Here we see the Level Select screen, and when you scroll to the bottom you can see your custom Question Bank!", "Here we see question we just made, ready to be played! Click the return arrow at the top left to go back to main menu and try out these cool features for yourself!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the first image in
        currentImage.image = imageArray[Counter]
        currentText.text = textArray[Counter]
    }
    
    // UI Component: Next button
    // Activated: When Pressed
    // Action: Show next tutorial point
    @IBAction func clicked_bNext(_ sender: UIButton) {
        
        // Index the array up to load next image
        // Counter = Counter + 1
        // Check to see if the counter has passed the max size of the images
        if (Counter < imageArray.count-1) {
            // Load the image & text
            currentImage.image = imageArray[Counter + 1]
            currentText.text = textArray[Counter + 1]
            self.Counter += 1
        }
        else {
            // If its further than the max size of the imageArray, reduce the counter
            Counter = Counter - 1
        }
    }
    
    // UI Component: Back button
    // Activated: When Pressed
    // Action: Show previous tutorial point
    @IBAction func clicked_bBack(_ sender: UIButton) {
        
        if (Counter > 0) {
            currentImage.image = imageArray[Counter - 1]
            currentText.text = textArray[Counter - 1]
            self.Counter -= 1
        }
        else {
            Counter = 0
        }
    }
    
    // UI Component: Return to Main Menu BUTTON
    // Activated: When Pressed
    // Action: Perform segue  "segTutBack" to Main menu
    @IBAction func Main_menuButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segTutBack", sender: self)
    }
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        if let destinationViewController = segue.destination as? Main_menu {
            destinationViewController.user = send_user
        }
    }
}

