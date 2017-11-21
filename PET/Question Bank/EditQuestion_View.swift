//
//  EditQuestion_View.swift
//  PET
//
//  Created by liuyal on 11/16/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SkyFloatingLabelTextField
import PopupDialog
import MobileCoreServices
import QuartzCore

// Class: EditQuestion_View
// Members:
//          1.
//          2.
//          3.
//          4.
// Description:
class EditQuestion_View: UIViewController {

    // Reference to Database
    var ref: DatabaseReference!
    // User object for passing of object between views
    var user: User_Model?
    // Drop down menu
    var button = dropDownBtn()
    // UIImagePickerController
    let imagePicker = UIImagePickerController()
    // Create a storage reference from our storage service
    let storage = Storage.storage()
    var storageRef: StorageReference!
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Reference to Firebase Database
        ref = Database.database().reference()
        // Get a reference to the storage service using the default Firebase App
        storageRef = self.storage.reference()
        
        // Initalize UI Elements
        Qprompt.frame = CGRect(origin: CGPoint(x: 680,y :120), size: CGSize(width: 320, height: 50))
        Qprompt.lineHeight = 1
        Qprompt.lineColor = UIColor.init(white: 1, alpha: 0.5)
        Qprompt.selectedLineHeight = 3
        Qprompt.iconFont = UIFont(name: "FontAwesome", size: 25)
        Qprompt.iconMarginBottom = 2
        Qprompt.iconText = "\u{f059}"
        Qprompt.placeholder = "Enter a Question Message"
        Qprompt.text = user?.CustomQArray[index!].imageFileRef
        
        saveQbutton.frame = CGRect(origin: CGPoint(x: 680,y :680), size: CGSize(width: 320, height: 60))
        saveQbutton.layer.borderWidth = 3
        saveQbutton.layer.borderColor = UIColor.white.cgColor
        
        // Drop down menu initialize Configure the button
        button = dropDownBtn.init(frame: CGRect(x: 680, y: 220, width: 320, height: 60))
        
        let tempEmo = user?.CustomQArray[index!].emotion
        let tempString = emoTostring(emo: tempEmo!)
        button.setTitle(tempString, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = true
        
        //Add Button to the View Controller
        self.view.addSubview(button)
        
        //Set the drop down menu's options
        button.dropView.dropDownOptions = ["Happy", "Sad", "Angry", "Scared", "Surprised", "Inlove", "Confused", "Shy", "Excited", "Sick", "Confident", "Embarrassed"]
        
        imageView.frame = CGRect(origin: CGPoint(x: 25,y :120), size: CGSize(width: 620, height: 620))
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = UIColor.clear
        imageView.image = user?.CustomQArray[index!].image
        
        addimagebutton.backgroundColor = UIColor.clear
        addimagebutton.frame = CGRect(origin: CGPoint(x: 25,y :120), size: CGSize(width: 100, height: 100))
    }

    // UI Element Lables
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var Qprompt: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var saveQbutton: UIButton!
    @IBOutlet weak var addimagebutton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    // UI Component: Add image for Custom Question BUTTON
    // Activated: When Pressed
    // Action: Open prompt for adding images
    @IBAction func addImagebutton(_ sender: UIButton) {
        self.showPopup()
    }
    
    // UI Component: Add Question BUTTON
    // Activated: When Pressed
    // Action: Open prompt for adding images
    @IBAction func safeQButton(_ sender: UIButton) {
        
        // Init Variables
        //let uid = user?.ID
        let imageSet = imageView.image
        let questionSet = Qprompt.text
        let emotionSet = button.currentTitle
        var emotionState: emotionID = .happy
        
        // Error detection
        if questionSet == "" {
            showPopupError(animated: true, titleIn: "Error", messageIn: "Please enter a question message")
            return
        }
        if imageSet == nil{
            showPopupError(animated: true, titleIn: "Error", messageIn: "Please Upload an image")
            return
        }
        if emotionSet == "Emotions"{
            showPopupError(animated: true, titleIn: "Error", messageIn: "Please select an emotion")
            return
        }
        
        // String to emo converstion
        emotionState = stringToemo(string: emotionSet!)

        self.user?.CustomQArray[index!].emotion = emotionState
        self.user?.CustomQArray[index!].imageFileRef = questionSet!
        self.user?.CustomQArray[index!].image = imageSet!
        self.user?.CustomQArray[index!].errCnt = 0
        self.user?.CustomQArray[index!].questionState = .initial
        
        self.updateDB(obj: (user?.CustomQArray[index!])!)
        print("Saved Question")
        self.performSegue(withIdentifier: "segEditQback", sender: self)
    }
    
    // UI Component: Return to question manager
    // Activated: When Pressed
    // Action: Perform segue  "segQmanageBack" to Main menu
    @IBAction func back(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segEditQback", sender: self)
    }
    
    // Function: Update Database
    // Input: 1. userObj: User_Model -> User object
    // Ouput: N/A
    func updateDB(obj: QuestionClass){
        
        // Load items to be stored
        let id = user?.ID
        let emotion = obj.emotion
        let emotionIn = emoTostring(emo: emotion)
        let message = obj.imageFileRef
        let Qname = String(obj.levelID) + String(obj.questionID)
        let path =  "Custom_Question_Images" + "/" + id! + "/" + Qname + ".png"
        
        // ImageData in memory
        let ImageData: NSData = UIImagePNGRepresentation(obj.image)! as NSData
        
        // Create a reference to the file you want to upload
        let pathRef = storageRef.child(path)
        
        // Upload the file to the path "images/rivers.jpg"
        _ = pathRef.putData(ImageData as Data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("Upload error")
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let MetaURL = metadata.downloadURL()!.absoluteString
            // Update table to database
            self.ref.child("ROOT").child(id!).child("CustomQuestions").child(Qname).child("URL").setValue(MetaURL)
            print(MetaURL)
        }
        
        //Set State and errorcount of qusetion (Load from local user object, Store into DB)
        self.ref.child("ROOT").child(id!).child("CustomQuestions").child(Qname).child("State").setValue(0)
        self.ref.child("ROOT").child(id!).child("CustomQuestions").child(Qname).child("errCnt").setValue(0)
        self.ref.child("ROOT").child(id!).child("CustomQuestions").child(Qname).child("prompt").setValue(message)
        self.ref.child("ROOT").child(id!).child("CustomQuestions").child(Qname).child("emotion").setValue(emotionIn)
    }
    
    // Function: Error Popup handel function
    // Input:
    //      1. animated: Bool -> Force popup animation
    //      2. titleIn: String -> Title of popup message
    //      3. messageIn: String -> Message of popup
    // Ouput: N/A
    func showPopupError(animated: Bool = true, titleIn: String, messageIn: String){
        // Create the dialog
        let popup = PopupDialog(title: titleIn, message: messageIn)
        let buttonOne = DefaultButton(title: "Okay"){}
        
        // Edit appearance
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = UIFont.boldSystemFont(ofSize: 25)
        dialogAppearance.messageFont = UIFont.systemFont(ofSize: 18)
        buttonOne.titleFont = UIFont.systemFont(ofSize: 20)
        buttonOne.titleColor = UIColor.darkGray
        popup.addButtons([buttonOne])
        
        self.present(popup, animated: true, completion: nil)
    }
    
    // Function: option select Popup handel function
    // Input: N/A
    // Ouput: N/A
    func showPopup(animated: Bool = true){
        // Create the dialog
        let popup = PopupDialog(title: "Select Option", message: "Import image from Photo Library or Camera")
        
        // Create buttons
        let buttonOne = DefaultButton(title: "Open Photo Library"){self.openPhotoLibrary() }
        let buttonTwo = DefaultButton(title: "Open Camera"){self.openCamera()}
        let buttonThree = CancelButton(title: "CANCEL"){}
        
        // Edit appearance
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = UIFont.boldSystemFont(ofSize: 30)
        dialogAppearance.messageFont = UIFont.systemFont(ofSize: 18)
        buttonOne.titleFont = UIFont.systemFont(ofSize: 20)
        buttonOne.titleColor = UIColor.darkGray
        buttonTwo.titleFont = UIFont.systemFont(ofSize: 20)
        buttonTwo.titleColor = UIColor.darkGray
        buttonThree.titleFont = UIFont.systemFont(ofSize: 20)
        buttonThree.titleColor = UIColor.red
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    // Function: Open Camera of device
    // Input: N/A
    // Ouput: N/A
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera)
            else{print("This device doesn't have a camera."); return}
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .rear
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for:.camera)!
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    // Function: Open Photo Library of device
    // Input: N/A
    // Ouput: N/A
    func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            else {print("can't open photo library"); return}
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        if let destinationViewController = segue.destination as? QManager_View {
            destinationViewController.user = send_user
        }
    }
}

extension EditQuestion_View: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {picker.dismiss(animated: true)}
        print(info)
        // get the image
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        // do something with it
        imageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {picker.dismiss(animated: true)}
        print("did cancel")
    }
}
