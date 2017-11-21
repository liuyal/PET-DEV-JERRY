//
//  FacialFun_View.swift
//  PET
//
//  Created by liuyal on 10/29/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import UIKit
import FirebaseAuth
import FirebaseDatabase

// Class: FacialFun_View
// Members:
//          1.
//          2.
//          3.
//          4.
// Description:
class FacialFun_View: UIViewController {
    
    // Passed in data or object variables
    var user: User_Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // UI Component: Return to Level select button
    // Activated: When Pressed
    // Action: Return to level selection page
    @IBAction func BackButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segFFBack", sender: self)
    }
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        if let destinationViewController = segue.destination as? LevelSelect_View {
            destinationViewController.user = send_user
        }
    } 
}
