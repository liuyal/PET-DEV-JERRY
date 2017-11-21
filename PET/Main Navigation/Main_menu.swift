//
//  Main_menu.swift
//  PET
//
//  Created by Wolf on 2017-10-18.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import UIKit
import FirebaseAuth
import FirebaseDatabase

// Class: Main_menu
// Members:
//          1. menu button
//          2. log out button
//          3. Question Manager
// Description:
class Main_menu: UIViewController {
   
    // Reference to Database
    var ref: DatabaseReference!
  
    // User object for passing of object between views
    var user: User_Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load Reference to Firebase Database
        ref = Database.database().reference()
        
        // Set X,Y and size for UI elements
        logo.frame = CGRect(origin: CGPoint(x: 364,y :40), size: CGSize(width: 300, height: 300))
       
        PlayButton.frame = CGRect(origin: CGPoint(x: 362,y :357), size: CGSize(width: 300, height: 60))
        PlayButton.layer.borderWidth = 3
        PlayButton.layer.borderColor = UIColor.white.cgColor
        
        TutButton.frame = CGRect(origin: CGPoint(x: 362,y :437), size: CGSize(width: 300, height: 60))
        TutButton.layer.borderWidth = 3
        TutButton.layer.borderColor = UIColor.white.cgColor
        
        SettingButton.frame = CGRect(origin: CGPoint(x: 362,y :517), size: CGSize(width: 300, height: 60))
        SettingButton.layer.borderWidth = 3
        SettingButton.layer.borderColor = UIColor.white.cgColor
        
        QManagerButton.frame = CGRect(origin: CGPoint(x: 362,y :597), size: CGSize(width: 300, height: 60))
        QManagerButton.layer.borderWidth = 3
        QManagerButton.layer.borderColor = UIColor.white.cgColor
        
        logoutButton.frame = CGRect(origin: CGPoint(x: 362,y :675), size: CGSize(width: 300, height: 36))
    }
    
    // Button Labels
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var TutButton: UIButton!
    @IBOutlet weak var SettingButton: UIButton!
    @IBOutlet weak var QManagerButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    // UI Component: LOGOUT BUTTON
    // Activated: When Pressed
    // Action: Perform Auth.auth().signOut signout of account  -> Redirect user to login view
    @IBAction func button_logout(_ sender: UIButton) {
        do{
            // Attempt to logout of account
            try Auth.auth().signOut()
            
            // If attempt successfull perform segue "segLogout" Redirect user to login view
            self.performSegue(withIdentifier: "segLogout", sender: self)
        }
        catch{print("Logout ERROR")}
    }
    
    // UI Component: Menu BUTTON
    // Activated: When Pressed
    // Action: Perform segue to appropriate view
    // Suggestion: *** Use Tags to shorten code ***
    @IBAction func PlayButton(_ sender: UIButton) {
        self.user?.progress.update_total_CompRate()
        //print(self.user?.progress.percComp[0] as Any,self.user?.progress.percComp[1] as Any)
        self.performSegue(withIdentifier: "segPlay", sender: self)
    }
    @IBAction func TutButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segTut", sender: self)
    }
    @IBAction func SettingButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segSetting", sender: self)
    }
    @IBAction func QManagerButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segQManager", sender: self)
    }
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Create variable for sending
        let send_user = user
        if let destinationViewController = segue.destination as? LevelSelect_View {
            destinationViewController.user = send_user }
        else if let destinationViewController = segue.destination as? Tutorial_View {
            destinationViewController.user = send_user }
        else if let destinationViewController = segue.destination as? Setting_View {
            destinationViewController.user = send_user }
        else if let destinationViewController = segue.destination as? QManager_View {
            destinationViewController.user = send_user }
    }
}

