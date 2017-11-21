//
//  Gameplay_View.swift
//  PET
//
//  Created by liuyal on 10/29/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import UIKit
import FirebaseAuth
import FirebaseDatabase
import PopupDialog
import FontAwesome_swift

// Class: Gameplay_View
// Members:
//          1.
//          2.
//          3.
//          4.
// Description:
class Gameplay_View: UIViewController {
    
    // Passed in data or object variables
    var ref: DatabaseReference!
    var user: User_Model?
    
    // Indexing variables
    var tierNum: Int?
    var Qnum: Int? // 0-9
    var index: Int? // 0-19
    
    // Array on image Literals
    let starInid: [UIImage]  = [#imageLiteral(resourceName: "Snow-PNG-Transparent-Image-1"),#imageLiteral(resourceName: "10-512")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reference to database
        ref = Database.database().reference()
        
        //load index of quesiton within the progress array
        index = tierNum! * 10 + Qnum!
        
        // Load if only state is correct
        StateStar.frame = CGRect(origin: CGPoint(x: 206,y :105), size: CGSize(width: 50, height: 50))
        if user?.progress.questionArray[index!].questionState == .correct{
            StateStar.backgroundColor = UIColor.white
            StateStar.layer.cornerRadius = 2
            StateStar.image = starInid[1]
        }
        else { StateStar.image = starInid[0]}
        
        // LOAD IMAGE base on index of progress array
        QuestionImage.frame = CGRect(origin: CGPoint(x: 206,y :105), size: CGSize(width: 613, height: 450))
        QuestionImage.image = user?.progress.questionArray[index!].image
        QuestionImage.layer.borderWidth = 5
        QuestionImage.layer.borderColor = UIColor.white.cgColor
        
        // UI element Init()
        skipButton.frame = CGRect(origin: CGPoint(x: 895,y :20), size: CGSize(width: 100, height: 70))
        titbar.frame = CGRect(origin: CGPoint(x: 20,y :20), size: CGSize(width: 975, height: 70))
        titbar.text = user?.progress.questionArray[index!].imageFileRef
        backButton.frame = CGRect(origin: CGPoint(x: 20,y :20), size: CGSize(width: 70, height: 70))
        
        // Create empty Deck of Emotion Cards for dummy answers
        var cardsArray = [Cards]()
        // Create empty hand of Emotion Cards for dummy answers
        var buttonCards = [Cards]()
        
        // Populate Deck and hand (Hand has correct ans emot)
        for i in 1..<DeckSize+1{
            let cardObj = Cards(picture: Constants.cardImageArray[i-1], emot: Constants.emotionIDArray[i-1], tagNumIn: i)
            
            if cardObj.emotion == self.user?.progress.questionArray[self.index!].emotion{
                buttonCards.append(cardObj)
            }
            else{
                cardsArray.append(cardObj)
            }
        }
        
        // Shuffle array for randomness
        cardsArray.shuffle()
        buttonCards.append(cardsArray[0])
        buttonCards.append(cardsArray[1])
        buttonCards.append(cardsArray[2])
        buttonCards.shuffle()
        
        // Set label, image, tag for each button and underlying UIImageView
        b1.frame = CGRect(origin: CGPoint(x: 206,y :578), size: CGSize(width: 112, height: 170))
        b1.tag = buttonCards[0].tagNum
        b1.layer.borderColor = UIColor.white.cgColor
        b1.layer.borderWidth = 5
        b1.layer.cornerRadius = 10
        Im1.frame = CGRect(origin: CGPoint(x: 206,y :578), size: CGSize(width: 112, height: 170))
        Im1.layer.cornerRadius = 10
        Im1.tag = buttonCards[0].tagNum
        Im1.image = buttonCards[0].emoPic
        
        b2.frame = CGRect(origin: CGPoint(x: 373,y :578), size: CGSize(width: 112, height: 170))
        b2.tag = buttonCards[1].tagNum
        b2.layer.borderColor = UIColor.white.cgColor
        b2.layer.borderWidth = 5
        b2.layer.cornerRadius = 10
        Im2.frame = CGRect(origin: CGPoint(x: 373,y :578), size: CGSize(width: 112, height: 170))
        Im2.layer.cornerRadius = 10
        Im2.tag = buttonCards[1].tagNum
        Im2.image = buttonCards[1].emoPic
        
        b3.frame = CGRect(origin: CGPoint(x: 540,y :578), size: CGSize(width: 112, height: 170))
        b3.tag = buttonCards[2].tagNum
        b3.layer.borderColor = UIColor.white.cgColor
        b3.layer.borderWidth = 5
        b3.layer.cornerRadius = 10
        Im3.frame = CGRect(origin: CGPoint(x: 540,y :578), size: CGSize(width: 112, height: 170))
        Im3.layer.cornerRadius = 10
        Im3.tag = buttonCards[2].tagNum
        Im3.image = buttonCards[2].emoPic
        
        b4.frame = CGRect(origin: CGPoint(x: 707,y :578), size: CGSize(width: 112, height: 170))
        b4.tag = buttonCards[3].tagNum
        b4.layer.borderColor = UIColor.white.cgColor
        b4.layer.borderWidth = 5
        b4.layer.cornerRadius = 10
        Im4.frame = CGRect(origin: CGPoint(x: 707,y :578), size: CGSize(width: 112, height: 170))
        Im4.layer.cornerRadius = 10
        Im4.tag = buttonCards[3].tagNum
        Im4.image = buttonCards[3].emoPic
    }
    
    // Lables to UIImageView and text Labels
    @IBOutlet weak var StateStar: UIImageView!
    @IBOutlet weak var QuestionImage: UIImageView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var titbar: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // UIButton Answer Label
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    
    // UIImageView Answer Label
    @IBOutlet weak var Im1: UIImageView!
    @IBOutlet weak var Im2: UIImageView!
    @IBOutlet weak var Im3: UIImageView!
    @IBOutlet weak var Im4: UIImageView!
    
    // UI Component: Any selection button
    // Activated: When Pressed
    // Action: Detect the value of the button pressed and process selection
    @IBAction func Action(_ sender: UIButton) {
        
        print(sender.tag)
        var selected: emotionID = .happy
        
        if sender.tag ==  1{ selected = .happy}
        else if sender.tag == 2{ selected = .sad}
        else if sender.tag == 3{ selected = .scared}
        else if sender.tag == 4{ selected = .angry}
            
        else if sender.tag == 5{ selected = .surprised}
        else if sender.tag == 6{ selected = .inlove}
        else if sender.tag == 7{ selected = .confused}
        else if sender.tag == 8{ selected = .shy}
            
        else if sender.tag == 9{ selected = .excited}
        else if sender.tag == 10{ selected = .sick}
        else if sender.tag == 11{ selected = .confident}
        else if sender.tag == 12{ selected = .embarrassed}
            
        else if sender.tag == 13{
            
            // If skipped is selected
            if user?.progress.questionArray[index!].questionState != .correct{
                var nextIndex = Qnum!
                //Look for next question which the state is anything but correct and load page accordingly
                for _ in 0..<Q_PER_TIER{
                    nextIndex += 1
                    if nextIndex >= Q_PER_TIER{ nextIndex = 0 }
                    if user?.progress.questionArray[tierNum! * 10 + nextIndex].questionState != .correct{
                        user?.progress.questionArray[index!].questionState = .skipped
                        self.updateProgressDB()
                        // REload images and texts
                        self.updatePage(indexx: nextIndex)
                        return
                    }
                    if tierNum! * 10 + nextIndex == index {
                        print ("All Level Complete")
                        // POP up
                        self.performSegue(withIdentifier: "segGameplayBack", sender: self)}
                }
            }
            else {
                // Skip to next question if question is completed
                //self.updateProgressDB()
                var nextIndex = Qnum! + 1
                if nextIndex >= Q_PER_TIER{nextIndex = 0}
                self.updatePage(indexx: nextIndex)
                return
            }
        }
        
        // if selection is correct
        if selected == user?.progress.questionArray[index!].emotion {
            // Change question state to correct
            user?.progress.questionArray[index!].questionState = .correct;
            // Update database for progression
            self.updateProgressDB()
            var counter = self.Qnum!
            
            //Look for next question which the state is anything but correct and load page accordingly
            for _ in 0..<Q_PER_TIER{
                counter += 1;  print(counter)
                if counter >= Q_PER_TIER{ counter = 0 }
                if user?.progress.questionArray[tierNum! * 10 + counter].questionState != .correct{
                    self.updateProgressDB()
                    // REload images and texts
                    showPopupCorrect(animated: true,titleIn: "Correct!", messageIn: "Good Job!")
                    self.updatePage(indexx: counter)
                    break
                }
                // All levels completed return to question select
                if tierNum! * 10 + counter == index {
                    print ("All Level Complete")
                    showPopupEND(animated: true,titleIn: "Good Job!", messageIn: "All quesitons in level " + String(tierNum!+1) + " Complete!")
                }
            }
        }
        else if selected != user?.progress.questionArray[index!].emotion && user?.progress.questionArray[index!].questionState != .correct{
            
            // Black out incorrect selections
            let tempButton = self.view.viewWithTag(sender.tag) as? UIButton
            let tempimageView = self.view.viewWithTag(sender.tag)
            tempButton?.alpha = 0.25
            tempimageView?.alpha = 0.25
            
            // update user obj and database
            user?.progress.questionArray[index!].questionState = .incorrect
            user?.progress.questionArray[index!].errCnt += 1
            self.updateProgressDB()
            print("ERROR")
        }
        else {
            // Black out incorrect selections
            let tempButton = self.view.viewWithTag(sender.tag) as? UIButton
            let tempimageView = self.view.viewWithTag(sender.tag)
            tempButton?.alpha = 0.25
            tempimageView?.alpha = 0.25
        }
    }
    
    // UI Component: Return to Level select button
    // Activated: When Pressed
    // Action: Return to level selection page
    @IBAction func backbutton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segGameplayBack", sender: self)
    }
    
    // Function: Update User progression table for errcnt and state in Firebase database under ROOT
    // Pre-Req: Internet connection must be vaild *** CHECKING NEED TO BE IMPLEMENTED ***
    // Input: N/A
    // Ouput: N/A
    func updateProgressDB() {
        self.user?.progress.update_total_CompRate()
        let id = self.user?.ID
        var Instate: Int
        let err = self.user?.progress.questionArray[self.index!].errCnt
        let A = String(tierNum!)
        let B = String(Qnum!)
        let Qname = A + B
        
        if self.user?.progress.questionArray[self.index!].questionState == .skipped {  Instate = 3 }
        else if self.user?.progress.questionArray[self.index!].questionState == .incorrect {  Instate = 2 }
        else if self.user?.progress.questionArray[self.index!].questionState == .correct { Instate = 1}
        else { Instate = 0}
        
        self.ref.child("ROOT").child(id!).child("Progress").child(Qname).child("State").setValue(Instate)
        self.ref.child("ROOT").child(id!).child("Progress").child(Qname).child("errCnt").setValue(err)
        // print( user?.progress.questionArray[index!].levelID,user?.progress.questionArray[index!].questionID as any)
    }
    
    // Function: Update Gameplay page with the next question to be play
    // Pre-Req: N/A
    // Input: indexx -> index of page to be loaded 0-9
    // Ouput: N/A
    func updatePage(indexx: Int){
        print ("correct")
        
        //LOAD STAR
        if self.user?.progress.questionArray[indexx + (tierNum!*10)].questionState == .correct
        { self.StateStar.image = starInid[1]}
        else { self.StateStar.image = starInid[0]}
        
        QuestionImage.image = user?.progress.questionArray[tierNum! * 10 + indexx].image
        
        titbar.text = user?.progress.questionArray[tierNum! * 10 + indexx].imageFileRef
        
        // Reset button and image
        let tempButton0 = self.view.viewWithTag(b1.tag) as? UIButton
        let tempButton1 = self.view.viewWithTag(b2.tag) as? UIButton
        let tempButton2 = self.view.viewWithTag(b3.tag) as? UIButton
        let tempButton3 = self.view.viewWithTag(b4.tag) as? UIButton
        let tempimageView0 = self.view.viewWithTag(Im1.tag)
        let tempimageView1 = self.view.viewWithTag(Im2.tag)
        let tempimageView2 = self.view.viewWithTag(Im3.tag)
        let tempimageView3 = self.view.viewWithTag(Im4.tag)
        
        tempButton0?.alpha = 1.0
        tempButton1?.alpha = 1.0
        tempButton2?.alpha = 1.0
        tempButton3?.alpha = 1.0
        tempimageView0?.alpha = 1.0
        tempimageView1?.alpha = 1.0
        tempimageView2?.alpha = 1.0
        tempimageView3?.alpha = 1.0
        
        // Create empty Deck of Emotion Cards for dummy answers
        var cardsArray = [Cards]()
        // Create empty hand of Emotion Cards for dummy answers
        var buttonCards = [Cards]()
        
        // Populate Deck and hand (Hand has correct ans emot)
        for i in 1..<DeckSize+1{
            let cardObj = Cards(picture: Constants.cardImageArray[i-1], emot: Constants.emotionIDArray[i-1], tagNumIn: i)
            
            if cardObj.emotion == self.user?.progress.questionArray[tierNum! * 10 + indexx].emotion{
                buttonCards.append(cardObj)
            }
            else{
                cardsArray.append(cardObj)
            }
        }
        
        // Shuffle array for randomness
        cardsArray.shuffle()
        buttonCards.append(cardsArray[0])
        buttonCards.append(cardsArray[1])
        buttonCards.append(cardsArray[2])
        buttonCards.shuffle()
        
        // Set label, image, tag for each button and underlying UIImageView
        b1.tag = buttonCards[0].tagNum
        Im1.tag = buttonCards[0].tagNum
        Im1.image = buttonCards[0].emoPic
        
        b2.tag = buttonCards[1].tagNum
        Im2.tag = buttonCards[1].tagNum
        Im2.image = buttonCards[1].emoPic
        
        b3.tag = buttonCards[2].tagNum
        Im3.tag = buttonCards[2].tagNum
        Im3.image = buttonCards[2].emoPic
        
        b4.tag = buttonCards[3].tagNum
        Im4.tag = buttonCards[3].tagNum
        Im4.image = buttonCards[3].emoPic
        
        // Update local index
        self.Qnum! = indexx
        self.index! = indexx + (tierNum!*10)
    }
    
    // Function: Popup handel function for end of game
    // Input:
    //      1. animated: Bool -> Force popup animation
    //      2. titleIn: String -> Title of popup message
    //      3. messageIn: String -> Message of popup
    // Ouput: N/A
    func showPopupEND(animated: Bool = true,titleIn: String, messageIn: String){
        // Create the dialog
        let popup = PopupDialog(title: titleIn, message: messageIn)
        
        // Create buttons
        let buttonThree = DefaultButton(title: "Okay")
        { self.performSegue(withIdentifier: "segGameplayToLevel", sender: self)}
        
        // Edit appearance
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = UIFont.boldSystemFont(ofSize: 25)
        dialogAppearance.messageFont = UIFont.systemFont(ofSize: 18)
        
        buttonThree.titleFont = UIFont.systemFont(ofSize: 20)
        buttonThree.titleColor = UIColor.darkGray
        
        // Add buttons to dialog
        popup.addButton(buttonThree)
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    // Function: Popup handel function for Correct Answer
    // Input:
    //      1. animated: Bool -> Force popup animation
    //      2. titleIn: String -> Title of popup message
    //      3. messageIn: String -> Message of popup
    // Ouput: N/A
    func showPopupCorrect(animated: Bool = true,titleIn: String, messageIn: String){
        // Create the dialog
        let popup = PopupDialog(title: titleIn, message: messageIn)
        
        // Create buttons
        let buttonThree = DefaultButton(title: "Next Question")
        {  }
        
        // Edit appearance
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = UIFont.boldSystemFont(ofSize: 25)
        dialogAppearance.messageFont = UIFont.systemFont(ofSize: 18)
        
        buttonThree.titleFont = UIFont.systemFont(ofSize: 20)
        buttonThree.titleColor = UIColor.darkGray
        
        // Add buttons to dialog
        popup.addButton(buttonThree)
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        let send_tier = tierNum
        if let destinationViewController = segue.destination as? QSelect_View {
            destinationViewController.user = send_user
            destinationViewController.tierNum = send_tier
        }
        else if let destinationViewController = segue.destination as? LevelSelect_View {
            destinationViewController.user = send_user
        }
    }
}

