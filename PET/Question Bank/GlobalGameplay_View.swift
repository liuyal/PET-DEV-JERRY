//
//  GlobalGameplay_View.swift
//  PET
//
//  Created by liuyal on 11/16/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import UIKit
import PopupDialog
import FontAwesome_swift

class GlobalGameplay_View: UIViewController {
    
    var playlist: [QuestionClass]!
    var user: User_Model?
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LOAD IMAGE base on index of progress array
        QuestionImage.frame = CGRect(origin: CGPoint(x: 206,y :105), size: CGSize(width: 613, height: 450))
        QuestionImage.image = self.playlist[index!].image
        QuestionImage.layer.borderWidth = 5
        QuestionImage.layer.borderColor = UIColor.white.cgColor
        
        titbar.frame = CGRect(origin: CGPoint(x: 20,y :20), size: CGSize(width: 975, height: 70))
        titbar.text = self.playlist[index!].imageFileRef
        backButton.frame = CGRect(origin: CGPoint(x: 20,y :20), size: CGSize(width: 70, height: 70))
        
        // Create empty Deck of Emotion Cards for dummy answers
        var cardsArray = [Cards]()
        // Create empty hand of Emotion Cards for dummy answers
        var buttonCards = [Cards]()
        
        // Populate Deck and hand (Hand has correct ans emot)
        for i in 1..<DeckSize+1{
            let cardObj = Cards(picture: Constants.cardImageArray[i-1], emot: Constants.emotionIDArray[i-1], tagNumIn: i)
            
            if cardObj.emotion == self.playlist[index!].emotion{
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
    
    @IBOutlet weak var QuestionImage: UIImageView!
    @IBOutlet weak var titbar: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    
    @IBOutlet weak var Im1: UIImageView!
    @IBOutlet weak var Im2: UIImageView!
    @IBOutlet weak var Im3: UIImageView!
    @IBOutlet weak var Im4: UIImageView!
    
    // UI Component: Return to Level select button
    // Activated: When Pressed
    // Action: Return to level selection page
    @IBAction func backbutton2(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Gplayback", sender: self)
    }
    
    // UI Component: Any selection button
    // Activated: When Pressed
    // Action: Detect the value of the button pressed and process selection
    @IBAction func Action2(_ sender: UIButton) {
        print(sender.tag)
        var selected: emotionID = .happy
        if sender.tag == 1 { selected = .happy}
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
        
        // if selection is correct
        if selected == self.playlist[index!].emotion {
            
            
            self.index! += 1
            
            if self.index! >= (self.playlist.count) {
                print ("All Level Complete")
                showPopupEND(animated: true, titleIn: "Congratulation!", messageIn: "All Question Bank Levels Complete!")
            }
            else{
                showPopupCorrect(animated: true,titleIn: "Correct!", messageIn: "Good Job!")
                self.updatePage(indexx: index!)
            }
        }
        else if selected != self.playlist[index!].emotion{
            
            // Black out incorrect selections
            let tempButton = self.view.viewWithTag(sender.tag) as? UIButton
            let tempimageView = self.view.viewWithTag(sender.tag)
            tempButton?.alpha = 0.25
            tempimageView?.alpha = 0.25
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
        {   self.performSegue(withIdentifier: "Gplayback", sender: self) }
        
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
    
    // Function: Update Gameplay page with the next question to be play
    // Pre-Req: N/A
    // Input: indexx -> index of page to be loaded 0-9
    // Ouput: N/A
    func updatePage(indexx: Int){
        
        QuestionImage.image = self.playlist[index!].image
        titbar.text = self.playlist[index!].imageFileRef
        
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
            
            if cardObj.emotion == self.playlist[indexx].emotion{
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        if let destinationViewController = segue.destination as? GlobalPlay_View {
            destinationViewController.user = send_user
        }
    }
}
