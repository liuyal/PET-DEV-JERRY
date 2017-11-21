//
//  QSelect_View.swift
//  PET
//
//  Created by liuyal on 10/29/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import PopupDialog
import FontAwesome_swift

// Class: QSelect_View
// Members:
//          1. text fields
//          2. Buttons linked to each level
// Description:
class QSelect_View: UIViewController {
    
    // Passed in data or object variables
    var user: User_Model?
    var tierNum: Int?
    var QuestNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Upon loading of page set title to selected level
        let titleN = QTitle.text as String?
        let StringNum = String(tierNum! + 1)
        let newTitle = titleN?.replacingOccurrences(of: "#", with: StringNum, options: .literal, range: nil)
        print(newTitle!)
        QTitle.text = newTitle!
     
        // **** animated progress bar *****
        var hashes: [UIButton] = [B1,B2,B3,B4,B5,B6,B7,B8,B9,B10]
        for i in 0..<Q_PER_TIER{
            hashes[i].layer.borderWidth = 5
            hashes[i].layer.borderColor = UIColor.white.cgColor
            if user?.progress.questionArray[i + tierNum!*10].questionState == .correct{
                hashes[i].backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
            }
        }
    
        B1.frame = CGRect(origin: CGPoint(x: 92,y :236), size: CGSize(width: 120, height: 120))
        B2.frame = CGRect(origin: CGPoint(x: 272,y :236), size: CGSize(width: 120, height: 120))
        B3.frame = CGRect(origin: CGPoint(x: 452,y :236), size: CGSize(width: 120, height: 120))
        B4.frame = CGRect(origin: CGPoint(x: 632,y :236), size: CGSize(width: 120, height: 120))
        B5.frame = CGRect(origin: CGPoint(x: 812,y :236), size: CGSize(width: 120, height: 120))
        
        B6.frame = CGRect(origin: CGPoint(x: 92,y :412), size: CGSize(width: 120, height: 120))
        B7.frame = CGRect(origin: CGPoint(x: 272,y :412), size: CGSize(width: 120, height: 120))
        B8.frame = CGRect(origin: CGPoint(x: 452,y :412), size: CGSize(width: 120, height: 120))
        B9.frame = CGRect(origin: CGPoint(x: 632,y :412), size: CGSize(width: 120, height: 120))
        B10.frame = CGRect(origin: CGPoint(x: 812,y :412), size: CGSize(width: 120, height: 120))
    }
    
    // UIButton Label
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var B2: UIButton!
    @IBOutlet weak var B3: UIButton!
    @IBOutlet weak var B4: UIButton!
    @IBOutlet weak var B5: UIButton!
    @IBOutlet weak var B6: UIButton!
    @IBOutlet weak var B7: UIButton!
    @IBOutlet weak var B8: UIButton!
    @IBOutlet weak var B9: UIButton!
    @IBOutlet weak var B10: UIButton!
    
    // Label for page title
    @IBOutlet weak var QTitle: UILabel!
    
    // UI Component: Question button
    // Activated: When Pressed
    // Action: Detect question selected and pass question number into gameplay page
    @IBAction func QButton(_ sender: UIButton) {
        QuestNum = sender.tag
        self.performSegue(withIdentifier: "segGameplay", sender: self)
    }
    
    // UI Component: Back to level select button
    // Activated: When Pressed
    // Action: Return to level select
    @IBAction func BackButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segQSelectBack", sender: self)
    }
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        let send_tier = tierNum
        let send_Qnum = QuestNum
        if let destinationViewController = segue.destination as? Gameplay_View {
            destinationViewController.user = send_user
            destinationViewController.tierNum = send_tier
            destinationViewController.Qnum = send_Qnum
        }
        else if let destinationViewController = segue.destination as? LevelSelect_View {
            destinationViewController.user = send_user
        }
    }
}
