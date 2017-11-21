//
//  LevelSelect_View.swift
//  PET
//
//  Created by liuyal on 10/29/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import UICircularProgressRing
import PopupDialog
import FontAwesome_swift

// Class: LevelSelect_View
// Members:
//          1. text fields
//          2. text labels
//          3. back button
//          4. create account button
// Description:
class LevelSelect_View: UIViewController {
    
    // Reference to Database
    var ref: DatabaseReference!
    // User object for passing of object between views
    var user: User_Model?
    // Create a storage reference from our storage service
    let storage = Storage.storage()
    var storageRef: StorageReference!
 
    var Glist = [QuestionClass]()
    // Variable for tier detection
    var selected_Tier: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load Reference to Firebase Database
        ref = Database.database().reference()
        // Get a reference to the storage service using the default Firebase App
        storageRef = self.storage.reference()
        
        // UICircularProgressRing Initialize
        Load1.frame = CGRect(origin: CGPoint(x: 112,y :180), size: CGSize(width: 200, height: 200))
        Load1.setProgress(value: 0, animationDuration: 2.0)
        Load1.font = UIFont.systemFont(ofSize: 25)
        
        Load2.frame = CGRect(origin: CGPoint(x: 412,y :180), size: CGSize(width: 200, height: 200))
        Load2.setProgress(value: 0, animationDuration: 2.0)
        Load2.font = UIFont.systemFont(ofSize: 25)
        
        Load3.frame = CGRect(origin: CGPoint(x: 712,y :180), size: CGSize(width: 200, height: 200))
        Load3.setProgress(value: 0, animationDuration: 2.0)
        Load3.font = UIFont.systemFont(ofSize: 25)
        
        Load4.frame = CGRect(origin: CGPoint(x: 112,y :460), size: CGSize(width: 200, height: 200))
        Load4.setProgress(value: 0, animationDuration: 2.0)
        Load4.font = UIFont.systemFont(ofSize: 25)
        
        Load5.frame = CGRect(origin: CGPoint(x: 412,y :460), size: CGSize(width: 200, height: 200))
        Load5.setProgress(value: 0, animationDuration: 2.0)
        Load5.font = UIFont.systemFont(ofSize: 25)
        
        Load6.frame = CGRect(origin: CGPoint(x: 712,y :460), size: CGSize(width: 200, height: 200))
        Load6.setProgress(value: 0, animationDuration: 2.0)
        Load6.font = UIFont.systemFont(ofSize: 25)
        
        // UI element init()
        FFB.frame = CGRect(origin: CGPoint(x: 112,y :800), size: CGSize(width: 200, height: 200))
        QBB.frame = CGRect(origin: CGPoint(x: 412,y :800), size: CGSize(width: 200, height: 200))
        GPB.frame = CGRect(origin: CGPoint(x: 712,y :800), size: CGSize(width: 200, height: 200))
    
        downIcon.frame = CGRect(origin: CGPoint(x: 950,y :616), size: CGSize(width: 50, height: 50))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        user?.progress.update_total_CompRate()
        
        // Load progress array
        let perc1 = 100*(user?.progress.percComp[0])!;
        let perc2 = 100*(user?.progress.percComp[1])!;
        let perc3 = 100*(user?.progress.percComp[2])!;
        let perc4 = 100*(user?.progress.percComp[3])!;
        let perc5 = 100*(user?.progress.percComp[4])!;
        let perc6 = 100*(user?.progress.percComp[5])!;
        
        // Set value and play animation
        Load1.setProgress(value: CGFloat(perc1), animationDuration: 1)
        Load2.setProgress(value: CGFloat(perc2), animationDuration: 1)
        Load3.setProgress(value: CGFloat(perc3), animationDuration: 1)
        Load4.setProgress(value: CGFloat(perc4), animationDuration: 1)
        Load5.setProgress(value: CGFloat(perc5), animationDuration: 1)
        Load6.setProgress(value: CGFloat(perc6), animationDuration: 1)
    }

    // UIButton Label
    @IBOutlet weak var L1: UIButton!
    @IBOutlet weak var L2: UIButton!
    @IBOutlet weak var L3: UIButton!
    @IBOutlet weak var L4: UIButton!
    @IBOutlet weak var L5: UIButton!
    @IBOutlet weak var L6: UIButton!
    @IBOutlet weak var FFB: UIButton!
    @IBOutlet weak var QBB: UIButton!
    @IBOutlet weak var GPB: UIButton!
    @IBOutlet weak var BackB: UIButton!
    @IBOutlet weak var downIcon: UIImageView!
    
    // UICircularProgressRing Label
    @IBOutlet weak var Load1: UICircularProgressRingView!
    @IBOutlet weak var Load2: UICircularProgressRingView!
    @IBOutlet weak var Load3: UICircularProgressRingView!
    @IBOutlet weak var Load4: UICircularProgressRingView!
    @IBOutlet weak var Load5: UICircularProgressRingView!
    @IBOutlet weak var Load6: UICircularProgressRingView!
    
    // UI Component: Selection Button
    // Activated: When Pressed
    // Action: Will redirect to selected page when pressed
    @IBAction func LevelButton(_ sender: UIButton) {
        selected_Tier = sender.tag
        // CHECK FOR COMPLETE
        print(sender.tag)
        self.performSegue(withIdentifier: "segQSelect", sender: self)
    }
    @IBAction func FFButton(_ sender: UIButton) {
         self.performSegue(withIdentifier: "segFF", sender: self)
    }
    @IBAction func QBankButton(_ sender: UIButton) {
        
        if (user?.CustomQArray.count)! < 1{
            showPopupEND(animated: true, titleIn: "Empty Bank!", messageIn: "There are no questions in the Bank! Go Make Some!")
        }
        else{
            self.performSegue(withIdentifier: "segQBank", sender: self)
        }
    }
    @IBAction func Main_menuBack(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segPlayBack", sender: self)
    }
    @IBAction func PlayGlobal(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segGlobalPlay", sender: self)
    }

    // Function: Popup message function to display to screen
    // Input:
    //      1. animated: set to true
    //      2. titleIn: Title for popup message
    //      3. messageIn: message for popuop message
    // Ouput: N/A
    func showPopupEND(animated: Bool = true,titleIn: String, messageIn: String){
        // Create the dialog
        let popup = PopupDialog(title: titleIn, message: messageIn)
        
        // Create buttons
        let buttonThree = DefaultButton(title: "Okay"){}
        
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
        //let send_list = Glist
        if let destinationViewController = segue.destination as? Main_menu {
            destinationViewController.user = send_user
        }
        else if let destinationViewController = segue.destination as? QSelect_View {
            destinationViewController.user = send_user
             destinationViewController.tierNum = selected_Tier
        }
        else if let destinationViewController = segue.destination as? FacialFun_View {
            destinationViewController.user = send_user
        }
        else if let destinationViewController = segue.destination as? QBankGameplay_View {
            destinationViewController.user = send_user
        }
        else if let destinationViewController = segue.destination as? GlobalPlay_View {
            //destinationViewController.globalPlaylist = send_list
            destinationViewController.user = send_user
        }
    }
}
