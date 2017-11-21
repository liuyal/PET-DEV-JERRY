//
//  Setting_View.swift
//  PET
//
//  Created by Wolf on 2017-10-19.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import UIKit
import FirebaseAuth
import FirebaseDatabase

// Class: Setting_View
// Members:
//          1. Reset Progress
//          2. REmove user (Need to be implemented)
// Description:
class Setting_View: UIViewController {
    
    //Reference to FireDataBase
    var ref: DatabaseReference!
    
    // User object for passing of object between views
    var user: User_Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Reference to Firebase Database
        ref = Database.database().reference()
        
        ResetButton.layer.borderWidth = 3
        ResetButton.layer.borderColor = UIColor.white.cgColor
    }
    
    // LABEL FOR UI ELEMENTS
    @IBOutlet weak var ResetButton: UIButton!
    @IBAction func ResetProgress(_ sender: UIButton) {
        
        // **** Add POP UP *****
        
        // Reset local use object
        let UID = user?.ID
        for i in 0..<TIER_SIZE{
            for j in 0..<Q_PER_TIER{
                let index = i * 10 + j
                self.user?.progress.questionArray[index].errCnt = 0
                self.user?.progress.questionArray[index].questionState = .initial
            }
        }
        updateDB(id: UID!, userobj: self.user!)
    }
    
    // Function: Reset progress of user in database
    // Input:
    //      1. ID: String -> user ID
    //      2. obj: User_Model -> User object
    // Ouput: N/A
    func updateDB (id: String, userobj: User_Model){
        for i in 0..<TIER_SIZE{
            for j in 0..<Q_PER_TIER{
                
                // Concat String of questions
                let A = String(i); let B = String(j)
                let Qname = A + B
                
                //Set State and errorcount of qusetion (Load from local user object, Store into DB)
                self.ref.child("ROOT").child(id).child("Progress").child(Qname).child("State").setValue(0)
                self.ref.child("ROOT").child(id).child("Progress").child(Qname).child("errCnt").setValue(0)
            }
        }
    }
    
    // UI Component: Return to Main Menu BUTTON
    // Activated: When Pressed
    // Action: Perform segue  "segSettingBack" to Main menu
    @IBAction func Main_menuBack(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segSettingBack", sender: self)
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
