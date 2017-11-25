//
//  EditAccount_View.swift
//  PET
//
//  Created by liuyal on 11/21/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import UIKit
import PopupDialog
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FontAwesome_swift
import SkyFloatingLabelTextField

// Class: EditAccount_View
// Members:
//          1. Text labels
//          2. Text fields
//          3. login button
//          4. sign up button
// Description:
class EditAccount_View: UIViewController {

    // Reference to Database
    var ref: DatabaseReference!
    var storageRef: StorageReference!
    // User object for passing of object between views
    var user: User_Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load Reference to Firebase Database
        ref = Database.database().reference()
        // Get a reference to the storage service using the default Firebase App
        storageRef = Storage.storage().reference()
   
        // Set X,Y and size for UI elements
        let font = UIFont.systemFont(ofSize: 18)
        sege.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        self.sege.layer.cornerRadius = 0;
        self.sege.layer.borderWidth = 2;
        self.sege.layer.borderColor = UIColor.white.cgColor
        
        fullname_field.frame = CGRect(origin: CGPoint(x: 337,y :286), size: CGSize(width: 350, height: 60))
        fullname_field.lineColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        fullname_field.lineHeight = 2
        fullname_field.selectedLineHeight = 3
        fullname_field.iconFont = UIFont(name: "FontAwesome", size: 25)
        fullname_field.iconMarginBottom = 10
        fullname_field.iconText = "\u{f007}"
        
        age_field.frame = CGRect(origin: CGPoint(x: 337,y :356), size: CGSize(width: 350, height: 60))
        age_field.lineHeight = 2
        age_field.lineColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        age_field.selectedLineHeight = 3
        age_field.iconFont = UIFont(name: "FontAwesome", size: 25)
        age_field.iconMarginBottom = 10
        age_field.iconText = "\u{f1fd}"
        
        sege.frame = CGRect(origin: CGPoint(x: 337,y :433), size: CGSize(width: 350, height: 60))
        
        fullname_field.text = user?.name
        let temp = String(describing: user?.age)
        let result = temp.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890.").inverted)
        age_field.text = result
        
        if user?.gender == "Female"{
            sege.selectedSegmentIndex = 1
        }else{
            sege.selectedSegmentIndex = 0
        }
        
        saveB.frame = CGRect(origin: CGPoint(x: 337,y :510), size: CGSize(width: 350, height: 60))
        saveB.layer.borderWidth = 3
        saveB.layer.borderColor = UIColor.white.cgColor
    }

    //Input fields for user and account information
    @IBOutlet weak var fullname_field: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var age_field: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var sege: UISegmentedControl!

    @IBOutlet weak var saveB: UIButton!
    
    @IBAction func saveButt(_ sender: UIButton) {
      
        var Infocheck = false
        
        //INFOCHECK: Check input for 1st 3 parameters, name(STRING), Age(Int), Gender(Bool)
        if let fullname = fullname_field.text, let age = age_field.text {
            
            //Check for Empty fields or fields with only space, return, and/or tab characters
            if fullname.trimmingCharacters(in: .whitespaces).isEmpty || age.trimmingCharacters(in: .whitespaces).isEmpty {
                Infocheck = false

               showPopupError(animated: true,titleIn: "Empty Field", messageIn: "Please make sure all fields are entered")
                print("EMPTY NAME or Age")
            }
            else {
                // Check for age is integer between 0 to 99
                if let ageint = Int(age) {
                    if (ageint >= 1 && ageint <= 99) {Infocheck = true}
                    else{print("Invaild Age"); showPopupError(animated: true, titleIn: "Invaild Age", messageIn: "Please select vaild age");
                        Infocheck = false}}
                else {print("Invaild Age"); showPopupError(animated: true,titleIn: "Invaild Age", messageIn: "Please select vaild age");
                    Infocheck = false}
            }
        }
        
        if Infocheck == true{
            let ID = user?.ID
            user?.name = fullname_field.text!
            user?.age = Int(age_field.text!)!
            
            let name = fullname_field.text!
            let age = age_field.text!
            var Ingender = ""
            if self.sege.selectedSegmentIndex == 0 {  Ingender = "Male"}
            else {  Ingender = "Female"}
            
            user?.gender = Ingender
            
            self.ref.child("ROOT").child(ID!).child("Name").setValue(name)
            self.ref.child("ROOT").child(ID!).child("Age").setValue(age)
            self.ref.child("ROOT").child(ID!).child("Gender").setValue(Ingender)
            
            showPopup(animated: true,titleIn: "Complete", messageIn: "User Information Updated")
        }
    }

    // UI Component: Return to Main Menu BUTTON
    // Activated: When Pressed
    // Action: Perform segue  "segSettingBack" to Main menu
    @IBAction func SettingBack(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segEditAccback", sender: self)
    }
    
    func showPopup(animated: Bool = true,titleIn: String, messageIn: String){
        // Create the dialog
        let popup = PopupDialog(title: titleIn, message: messageIn)
        
        // Create buttons
        let buttonFour = DefaultButton(title: "Return"){
            self.performSegue(withIdentifier: "segEditAccback", sender: self)
        }
        // Edit appearance
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = UIFont.boldSystemFont(ofSize: 25)
        dialogAppearance.messageFont = UIFont.systemFont(ofSize: 18)

        buttonFour.titleFont = UIFont.systemFont(ofSize: 20)
        buttonFour.titleColor = UIColor.darkGray
        
        // Add buttons to dialog
        popup.addButton(buttonFour)
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    // Function: Popup handel function
    // Input:
    //      1. animated: Bool -> Force popup animation
    //      2. titleIn: String -> Title of popup message
    //      3. messageIn: String -> Message of popup
    // Ouput: N/A
    func showPopupError(animated: Bool = true,titleIn: String, messageIn: String){
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
    
    // UI Component: Gender Segement Selection
    // Activated: When Pressed
    // Action: Base of index print to consol (Debug purpose) -> ** DO NOT SET VALUE **
    @IBAction func segeValueChange(_ sender: UISegmentedControl) {
        if sege.selectedSegmentIndex == 0 {print("Male")}
        else if sege.selectedSegmentIndex == 1 {print("Female")}
    }
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        if let destinationViewController = segue.destination as? Setting_View {
            destinationViewController.user = send_user
        }
    }
}
