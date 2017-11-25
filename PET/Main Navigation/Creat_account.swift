//
//  Creat_account.swift
//  PET
//
//  Created by Wolf on 2017-10-18.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import Hero
import UIKit
import FirebaseAuth
import FirebaseDatabase
import SkyFloatingLabelTextField
import FontAwesome_swift
import PopupDialog

// Class: Creat_account
// Members:
//          1. text fields
//          2. text labels
//          3. back button
//          4. create account button
// Description:
class Creat_account: UIViewController{
    
    //Reference to FireDataBase
    var ref: DatabaseReference!
    
    // Create User Object
    var CreateUser = User_Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Reference to Firebase Database
        ref = Database.database().reference()
        
        // Set X,Y and size for UI elements
        let font = UIFont.systemFont(ofSize: 18)
        sege.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        self.sege.layer.cornerRadius = 0;
        self.sege.layer.borderWidth = 2;
        self.sege.layer.borderColor = UIColor.white.cgColor
        
        fullname_field.frame = CGRect(origin: CGPoint(x: 337,y :230), size: CGSize(width: 350, height: 60))
        fullname_field.lineColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        fullname_field.lineHeight = 2
        fullname_field.selectedLineHeight = 3
        fullname_field.iconFont = UIFont(name: "FontAwesome", size: 25)
        fullname_field.iconMarginBottom = 10
        fullname_field.iconText = "\u{f007}"
        
        age_field.frame = CGRect(origin: CGPoint(x: 337,y :300), size: CGSize(width: 350, height: 60))
        age_field.lineHeight = 2
        age_field.lineColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        age_field.selectedLineHeight = 3
        age_field.iconFont = UIFont(name: "FontAwesome", size: 25)
        age_field.iconMarginBottom = 10
        age_field.iconText = "\u{f1fd}"
        
        name_field.frame = CGRect(origin: CGPoint(x: 337,y :450), size: CGSize(width: 350, height: 60))
        name_field.lineHeight = 2
        name_field.lineColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        name_field.selectedLineHeight = 3
        name_field.iconFont = UIFont(name: "FontAwesome", size: 25)
        name_field.iconMarginBottom = 10
        name_field.iconText = "\u{f003}"
        
        passwd_field.frame = CGRect(origin: CGPoint(x: 337,y :520), size: CGSize(width: 350, height: 60))
        passwd_field.lineHeight = 2
        passwd_field.lineColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        passwd_field.selectedLineHeight = 3
        passwd_field.iconFont = UIFont(name: "FontAwesome", size: 25)
        passwd_field.iconMarginBottom = 10
        passwd_field.iconText = "\u{f023}"
        
        confirmPW_field.frame = CGRect(origin: CGPoint(x: 337,y :590), size: CGSize(width: 350, height: 60))
        confirmPW_field.lineHeight = 2
        confirmPW_field.lineColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        confirmPW_field.selectedLineHeight = 3
        confirmPW_field.iconFont = UIFont(name: "FontAwesome", size: 25)
        confirmPW_field.iconMarginBottom = 10
        confirmPW_field.iconText = "\u{f023}"
        
        sege.frame = CGRect(origin: CGPoint(x: 337,y :377), size: CGSize(width: 350, height: 50))
        UserIcon.frame = CGRect(origin: CGPoint(x: 462,y :102), size: CGSize(width: 100, height: 100))
        
         // Ceate user object
        CreateUser = User_Model(ID: "uid", name: "", age: 1, gender: "", email: "", password: "", progress: ProgressArray(useriD: "", emotionIn: Constants.emoIDArray ,StateIn: Constants.stateIDArray, promptIn:  Constants.QuestionStringArray, pictureIn: Constants.pictureArray, urlIn: Constants.urlDArray), cqarray: [QuestionClass]());
    }
    
    //Input fields for user and account information
    @IBOutlet weak var fullname_field: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var age_field: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var sege: UISegmentedControl!
    @IBOutlet weak var name_field: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwd_field: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var confirmPW_field: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var UserIcon: UIImageView!
    
    // UI Component: Gender Segement Selection
    // Activated: When Pressed
    // Action: Base of index print to consol (Debug purpose) -> ** DO NOT SET VALUE **
    @IBAction func segeValueChange(_ sender: UISegmentedControl) {
        if sege.selectedSegmentIndex == 0 {print("Male")}
        else if sege.selectedSegmentIndex == 1 {print("Female")}
    }
    
    // UI Component: Create Account button
    // Activated: When Pressed
    // Action: Check all inputs for errror, attempt to create account via Auth.auth().createUser, If successful -> redirect user to main menu
    @IBAction func button_Create_ACC(_ sender: UIButton) {
        
        // Flag for correct inputs from text fields
        var ACCcheck = false
        var Infocheck = false
        
        //INFOCHECK: Check input for 1st 3 parameters, name(STRING), Age(Int), Gender(Bool)
        if let fullname = fullname_field.text, let age = age_field.text {
            
            //Check for Empty fields or fields with only space, return, and/or tab characters
            if fullname.trimmingCharacters(in: .whitespaces).isEmpty || age.trimmingCharacters(in: .whitespaces).isEmpty {
                Infocheck = false
                
                // *** Print to screen to be added ***
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
        
        //ACCCHECK: Check input for last 3 parameters
        if let email = name_field.text, let password = passwd_field.text, let confirmPW = confirmPW_field.text {
            
            //Check if password = confirm password, and email fields are empty
            if confirmPW == password && (confirmPW != "" && password != "") && email != "" {ACCcheck = true}
            else {showPopupError(animated: true,titleIn: "Incorrect Email or Password", messageIn: "Please make sure all fields are entered Correctly");print("PW ERROR") }
            // *** Print to screen to be added ***
            
            // All inputs are vaild and correct -> Attempt to create user via Auth.auth().createUser
            // Invaild inputs will NOT be able to reach functions under this condition
            if ACCcheck == true && Infocheck == true{
                
                // Firebase Authentication Function
                // Pre-Req: Internect connection must be vaild **** CHECKING NEED TO BE IMPLEMENTED ****
                // Input:
                //      1. withEmail: email -> user email for account
                //      2. password: password -> User password for account
                //      3. completion: {user, error in} -> Checks for error such as proper email address + password vaild
                // Ouput:
                //      1. Create Successful: message to terminal (Print to screen)
                //      2. Create Unsuccessful: message to terminal (Print to screen)
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    
                    // IF Account create ERROR occurs PRINT ERROR MESSAGE
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        //self.ErrorLabel.text = firebaseError.localizedDescription
                        self.showPopupError(animated: true,titleIn: "Incorrect Email or Password", messageIn: firebaseError.localizedDescription)
                        ACCcheck = false
                    }
                    else {
                        // Update User Object * search ID first *
                        let user1 = Auth.auth().currentUser!
                        let uid = user1.uid;
                        
                        // Check segement and load gender as STRING
                        var Ingen: String = ""
                        if self.sege.selectedSegmentIndex == 0 {  Ingen = "Male"}
                        else {  Ingen = "Female"}
                        
                        // Update user Object
                        self.updateUserObj(userObj: self.CreateUser, ID: uid, fullname: self.fullname_field.text!, age: Int(self.age_field.text!)!, gender: Ingen, mail: self.name_field.text!, pw: self.passwd_field.text!)
                        
                        // Add personal info to database, Add account info to database under node: ROOT (Sorted by UID)
                        self.CreateUserInDataBase(ID: uid, name: self.fullname_field.text!, age: self.age_field.text!, gender: Ingen, mail: self.name_field.text!, pw: self.passwd_field.text!)
                        
                        // Add progress array to databse
                        self.CreateProgressDB (obj: self.CreateUser, id: uid, tiers: TIER_SIZE, numQ: Q_PER_TIER)
                        
                        // *** ADD POP UP LATER ***
                        print("Create Accound Good")
                        self.performSegue(withIdentifier: "seg_createGood", sender: self)
                    }
                }
            }
            else {}
        }
    }
    
    // Function: Update Local User Object
    // Input:
    //      1. userObj: User_Model -> User object
    //      2. ID: String -> user ID
    //      3. fullname: String -> Full name of user
    //      4. age: Int -> age of user
    //      5. gender: String -> User object
    //      6. mail: String -> user email
    //      7. pw: String -> user account password
    // Ouput: N/A
    func updateUserObj(userObj: User_Model, ID: String, fullname: String, age: Int, gender: String, mail: String, pw: String){
        userObj.ID = ID;
        userObj.name = fullname
        userObj.age = age
        userObj.gender = gender
        userObj.email = mail
        userObj.password = pw
        userObj.progress.userID = ID
        userObj.print_user()
    }
    
    // Function: Create User table in Firebase database under ROOT using inputs provided below
    // Pre-Req: Internet connection must be vaild *** CHECKING NEED TO BE IMPLEMENTED ***
    // Input:
    //      1. ID: String -> user ID
    //      2. fullname: String -> Full name of user
    //      3. age: Int -> age of user
    //      4. gender: String -> User object
    //      5. mail: String -> user email
    //      6. pw: String -> user account password
    // Ouput: N/A
    func CreateUserInDataBase(ID: String, name: String, age: String, gender: String, mail: String, pw: String){
        self.ref.child("ROOT").child(ID).setValue(nil)
        self.ref.child("ROOT").child(ID).child("UID").setValue(ID)
        self.ref.child("ROOT").child(ID).child("Name").setValue(name)
        self.ref.child("ROOT").child(ID).child("Age").setValue(age)
        self.ref.child("ROOT").child(ID).child("Gender").setValue(gender)
        self.ref.child("ROOT").child(ID).child("Email").setValue(mail)
        self.ref.child("ROOT").child(ID).child("Password").setValue(pw)
        self.ref.child("ROOT").child(ID).child("Progress").setValue(nil)
        self.ref.child("ROOT").child(ID).child("CustomQuestions").setValue(0)
    }
    
    // Function: Create User progress array table in Firebase database under ROOT->UID(unique) using inputs provided below
    // Pre-Req: Internet connection must be vaild *** CHECKING NEED TO BE IMPLEMENTED ***
    // Input:
    //      1. userObj: User_Model -> User object
    //      2. id: String -> user ID
    //      3. tiers: Int -> number of tiers/level in game
    //      4. numQ: String -> number of question per tiers/level in game
    // Ouput: N/A
    // Suggestion: *** Globle variable to replace tiers: Int, and NumQ:Int ***
    func CreateProgressDB (obj: User_Model, id: String, tiers: Int, numQ: Int){
        
        //counter for indexing purposes
        var counter = 0
        // State of question, stored as int in database
        var Instate: Int = 0
        
        // Double for loop for traversing though progess array
        // i = tier/level index
        // j = question index
        for i in 0..<tiers{
            for j in 0..<numQ{
                
                // Update emotion ID base on ID ARRAYbase
                let err = Int(obj.progress.questionArray[counter].errCnt)
                let A = String(i); let B = String(j)
                let Qname = A + B
                
                //Set State of qusetion (Load from local user object, Store into DB)
                if obj.progress.questionArray[counter].questionState == .skipped {  Instate = 3 }
                else if obj.progress.questionArray[counter].questionState == .incorrect {  Instate = 2 }
                else if obj.progress.questionArray[counter].questionState == .correct { Instate = 1}
                else { Instate = 0}
                
                //Set State and errorcount of qusetion (Load from local user object, Store into DB)
                self.ref.child("ROOT").child(id).child("Progress").child(Qname).child("State").setValue(Instate)
                self.ref.child("ROOT").child(id).child("Progress").child(Qname).child("errCnt").setValue(err)
                counter += 1
            }
        }
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
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = self.CreateUser
        if let destinationViewController = segue.destination as? Main_menu {
            destinationViewController.user = send_user
        }
    }
}
