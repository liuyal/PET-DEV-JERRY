//
//  ViewController.swift
//  PET
//
//  Created by Wolf on 2017-10-18.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import Hero
import UIKit
import PopupDialog
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FontAwesome_swift
import SkyFloatingLabelTextField

// Class: Login_View
// Members:
//          1. Text labels
//          2. Text fields
//          3. login button
//          4. sign up button
// Description:
class Login_View: UIViewController
{
    // Reference to Database
    var ref: DatabaseReference!
    var storageRef: StorageReference!
    
    // Initialize objects
    var userload = User_Model()
    var index: Int?
    
    
    // Do any additional setup after loading the view, typically from a nib.
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // Load Reference to Firebase Database
        ref = Database.database().reference()
        // Get a reference to the storage service using the default Firebase App
        storageRef = Storage.storage().reference()
        
        // Set X,Y and size for UI elements
        loginButton.frame = CGRect(origin: CGPoint(x: 312,y :590), size: CGSize(width: 400, height: 60))
        loginButton.layer.borderWidth = 3
        loginButton.layer.borderColor = UIColor.white.cgColor
        
        signUpButton.frame = CGRect(origin: CGPoint(x: 312,y :660), size: CGSize(width: 400, height: 60))
        
        textField_username.frame = CGRect(origin: CGPoint(x: 312,y :420), size: CGSize(width: 400, height: 60))
        textField_username.lineHeight = 2
        textField_username.lineColor = UIColor.init(white: 1, alpha: 0.5)
        textField_username.selectedLineHeight = 3
        textField_username.iconFont = UIFont(name: "FontAwesome", size: 25)
        textField_username.iconMarginBottom = 10
        textField_username.iconText = "\u{f003}"

        textField_passowrd.frame = CGRect(origin: CGPoint(x: 312,y :490), size: CGSize(width: 400, height: 60))
        textField_passowrd.lineHeight = 2
        textField_passowrd.lineColor = UIColor.init(white: 1, alpha: 0.5)
        textField_passowrd.selectedLineHeight = 3
        textField_passowrd.iconFont = UIFont(name: "FontAwesome", size: 25)
        textField_passowrd.iconMarginBottom = 7
        textField_passowrd.iconColor = UIColor.white
        textField_passowrd.iconText = "\u{f023}"
    
        // Ceate user object
        userload = User_Model(ID: "uid", name: "", age: 1, gender: "", email: "", password: "", progress: ProgressArray(useriD: "", emotionIn: Constants.emoIDArray ,StateIn: Constants.stateIDArray, promptIn:  Constants.QuestionStringArray, pictureIn: Constants.pictureArray, urlIn: Constants.urlDArray), cqarray: [QuestionClass]());
    }
    
    // TEXT FIELD and TEXT LABEL FOR LOGIN SCREEN
    @IBOutlet weak var textField_username: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var textField_passowrd: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var LogoLabel: UIImageView!
    
    // UI Component: LOGIN BUTTON
    // Activated: When Pressed
    // Action: Perform Auth.auth() account authentication -> Redirect user to Main Menu
    @IBAction func button_login(_ sender: UIButton){
        
        if let email = textField_username.text, let password = textField_passowrd.text {
            // Firebase Authentication Function
            // Pre-Req: Internet connection must be vaild *** CHECKING NEED TO BE IMPLEMENTED ***
            // Input:
            //      1. withEmail: email -> user email for account
            //      2. password: password -> User password for account
            //      3. completion: {user, error in} -> Checks for error such as proper email address + password vaild
            // Ouput:
            //      1. Signin Successful: message to terminal (Print to screen)
            //      2. Signin Unsuccessful: message to terminal (Print to screen)
            Auth.auth().signIn(withEmail: email, password: password, completion: {user, error in
                
                // IF LOGIN ERROR OCCURS PRINT ERROR MESSAGE
                if let firebaseError = error {
                    self.showPopup()
                    // Print error to consol
                    print(firebaseError.localizedDescription)
                }
                    // Successful login
                else {
                    // LOAD USER UID FROM FIREBASE.AUTH()
                    let user1 = Auth.auth().currentUser!
                    let uid = user1.uid;
                    
                    // Set user UID from firebase into local user object
                    self.userload.ID = uid
                    self.userload.progress.userID = uid
                    
                    // LOAD FUNCTIONS FROM DATABASE
                    self.loadAccInfo(ID: uid, obj: self.userload)
                    self.loadProgress(ID: uid, obj: self.userload, tiers: TIER_SIZE, numQ: Q_PER_TIER, imageRef: Constants.QuestionStringArray)
                    self.loadCQ(ID: uid, obj: self.userload)
                    self.performSegue(withIdentifier: "segLogin", sender: self)
                }
            })
        }
    }
    
    // UI Component: SIGN UP BUTTON
    // Activated: When Pressed
    // Action: Perform Segue "seg_create" -> Redirect user into acccount creation view
    @IBAction func button_signUp(_ sender: Any){
        self.performSegue(withIdentifier: "seg_create", sender: self)
    }
    
    // Function: Load Account information from firebase database if login successful
    // Input:
    //      1. ID: String -> user ID
    //      2. obj: User_Model -> User object
    // Ouput: N/A
    func loadAccInfo(ID: String, obj: User_Model) {
        
        // From reference of DB load ROOT -> Contains all user tables
        // observeSingleEvent: View value under table once
        // snapshot: NSOBJECT for data structure viewed
        self.ref.child("ROOT").child(ID).observeSingleEvent(of: .value, with: { snapshot in
            
            // Load snapshot table from DB values as NS type
            let NSname = snapshot.childSnapshot(forPath: "Name").value as? NSString!
            let NSage = snapshot.childSnapshot(forPath: "Age").value as? NSString!
            let Sage = NSage as? String ?? ""
            let NSgender = snapshot.childSnapshot(forPath: "Gender").value as? NSString!
            let NSemail = snapshot.childSnapshot(forPath: "Email").value as? NSString!
            let NSpassword = snapshot.childSnapshot(forPath: "Password").value as? NSString!
            // let UIDP = snapshot.children
            // let NSshotSize = snapshot.childrenCount
            
            // Casting NSString into String and store into user object
            obj.name = NSname as? String ?? ""
            obj.age = Int(Sage)!
            obj.gender = NSgender as? String ?? ""
            obj.email = NSemail as? String ?? ""
            obj.password = NSpassword as? String ?? ""
        })
    }
    
    // Function: Load Progress Array from firebase database and store into local user object
    // Input:
    //      1. ID: String -> user ID
    //      2. obj: User_Model -> User object
    //      3. tiers: Int -> Tier or level number (indexed from 0 to 4)
    //      4. numQ: Int -> Question number (indexed from 0 to 9)
    // Ouput: N/A
    func loadProgress(ID: String, obj: User_Model, tiers: Int, numQ: Int, imageRef: [[String]]) {
        
        //Counter for indexing purposes
        var counter = 0
        
        // Double for loop for traversing though progess array
        // i = tier/level index
        // j = question index
        for i in 0..<tiers{
            for j in 0..<numQ{
                
                // Create set question name for question in database for seaching
                let A = String(i); let B = String(j)
                let Qname = A + B
                
                // From reference of DB load ROOT -> Contains all user tables
                // observeSingleEvent: View value under table once
                // snapshot: NSOBJECT for data structure viewed
                self.ref.child("ROOT").child(ID).child("Progress").child(Qname).observeSingleEvent(of: .value, with: { snapshot in
                    
                    //Search State of question under
                    let NSstate = snapshot.childSnapshot(forPath: "State").value as? NSNumber
                    
                    //Set State of qusetion (Load from DB, Store into local user object)
                    let InState = NSstate?.intValue
                    if InState == 3 {obj.progress.questionArray[counter].questionState = .skipped }
                    else if InState == 2 {obj.progress.questionArray[counter].questionState = .incorrect }
                    else if InState == 1 {obj.progress.questionArray[counter].questionState = .correct }
                    else { obj.progress.questionArray[counter].questionState = .initial}
                    
                    //Set Error counter of qusetion (Load from DB, Store into local user object)
                    let NSerrCnt = snapshot.childSnapshot(forPath: "errCnt").value as? NSNumber
                    obj.progress.questionArray[counter].errCnt = (NSerrCnt?.intValue)!
                    obj.progress.questionArray[counter].imageFileRef = imageRef[i][j]
                    
                    counter += 1
                })
            }
        }
    }
    
    
    // Function: Load custom questions from firebase database if login successful
    // Input:
    //      1. ID: String -> user ID
    //      2. obj: User_Model -> User object
    // Ouput: N/A
    func loadCQ(ID: String, obj: User_Model){
        
        self.ref.child("ROOT").child(ID).child("CustomQuestions").observeSingleEvent(of: .value, with: { (snapshot) in
            let NSshotSize = snapshot.childrenCount
            let DBsize = Int(NSshotSize)
            
            var groupNames = [String]()
            for group in snapshot.children {
                groupNames.append((group as AnyObject).key)
            }
            
            for i in 0..<DBsize{
                self.ref.child("ROOT").child(ID).child("CustomQuestions").child(groupNames[i]).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    //let NSshotSize2 = snapshot.childrenCount
                    //let DBsize2 = Int(NSshotSize2)
                    var groupNames2 = [String]()
                    for group2 in snapshot.children {
                        groupNames2.append((group2 as AnyObject).key)
                    }
                    
                    var imageIn = UIImage()
                    
                    // Name for each Question
                    let QID = Int(groupNames[i])
                    
                    // Load emotionID from DB
                    let NSemo = snapshot.childSnapshot(forPath: "emotion").value as? NSString!
                    let Semo = NSemo as? String ?? ""
                    let emoIn = self.stringToemo(string: Semo)
                    
                    // Load State from DB
                    let NSNState = snapshot.childSnapshot(forPath: "State").value as? NSNumber
                    let IntState = NSNState?.intValue
                    var StateID: state = .initial
                    if IntState == 3 {StateID = .skipped }
                    else if IntState == 2 {StateID = .incorrect }
                    else if IntState == 1 {StateID = .correct }
                    
                    // Load Error Count from DB
                    let NSSerrCnt = snapshot.childSnapshot(forPath: "errCnt").value as? NSNumber
                    let InterrCnt = NSSerrCnt?.intValue
                    
                    // Load Question Prompt from DB
                    let NSprompt = snapshot.childSnapshot(forPath: "prompt").value as? NSString!
                    let Sprompt = NSprompt as? String ?? ""
                    
                    // Load Url From DB
                    let NSUrl = snapshot.childSnapshot(forPath: "URL").value as? NSString!
                    let SUrl = NSUrl as? String ?? ""
                    
                    // Load Image From Firebase Storage
                    let rul = URL(string: SUrl)
                    if let data = try? Data(contentsOf: rul!){
                        imageIn = UIImage(data: data)!
                    }
                    
                    // Create Quesiton Objet with Loaded Values
                    let addedQ = QuestionClass(levelID: 0, questionID: QID!, emotion: emoIn, errCnt: InterrCnt!, questionState: StateID, imageFileRef: Sprompt, picture: imageIn, urlIn: SUrl)
                    obj.CustomQArray.append(addedQ)
                })
            }
        })
    }
    
    // Function: Popup handel function
    // Input: animated: Bool -> Force popup animation
    // Ouput: N/A
    func showPopup(animated: Bool = true){
        // Create the dialog with title and message
        let popup = PopupDialog(title: "Incorrect Username or Password", message: "Please Try Again")
        // Create buttons
        let buttonOne = CancelButton(title: "Okay") { print("Message PopUP")}
        // Add buttons to dialog
        popup.addButton(buttonOne)
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }

    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = userload
        if let destinationViewController = segue.destination as? Main_menu {
            destinationViewController.user = send_user
        }
    }
}
