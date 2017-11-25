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
import PopupDialog
import AVFoundation
import Affdex

// Class: FacialFun_View
// Members:
//          1.
//          2.
//          3.
//          4.
// Description:
class FacialFun_View: UIViewController, AFDXDetectorDelegate {
    
    // Passed in data or object variables
    var user: User_Model?
    
    var detector : AFDXDetector? = nil
    var index: Int = 0
    let ansImages = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3")]
    
    var detectArray: [CGFloat] = Array(repeating: CGFloat(0.0), count: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
        
        // create the detector
        detector = AFDXDetector(delegate: self, using: captureDevice, maximumFaces: 1, face: LARGE_FACES)
        detector?.setDetectAllEmotions(true)
        detector?.setDetectEmojis(true)
        detector?.setDetectAllExpressions(true)
        detector?.joy = true
        detector?.anger = true
        detector?.smile = true
        detector!.start()
        
        perc.text = String(0) + "%"
        questImage.image = ansImages[index]
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPopupCorrect(animated:  true,titleIn: "Welcome To Facial Fun", messageIn: "Make the image shown by the picture")
    }
    
    @IBOutlet weak var questImage: UIImageView!
    @IBOutlet weak var imageout: UIView!
    @IBOutlet weak var perc: UILabel!
    @IBOutlet weak var imageDis: UIImageView!
    
    func detectorDidStartDetectingFace(face : AFDXFace) {
        // handle new face
    }
    
    func detectorDidStopDetectingFace(face : AFDXFace) {
        // handle loss of existing face
    }
    
    func detector(_ detector : AFDXDetector, hasResults : NSMutableDictionary?, for forImage : UIImage, atTime : TimeInterval) {
        // handle processed and unprocessed images here
        if hasResults != nil {
            // handle processed image in this block of code
            
            // enumrate the dictionary of faces
            for (_, face) in hasResults! {
                // for each face, get the rage score and print it
                //let emo: AFDXExpressions = (face as AnyObject).expressions
                let emo2: AFDXEmotions = (face as AnyObject).emotions
                let emo: AFDXExpressions = (face as AnyObject).expressions
                var Score = CGFloat(0.0)
                
                if index == 0{
                    Score = emo2.joy
                    detectArray.append(Score)
                    detectArray.remove(at: 0)
                    
                    let sum = detectArray.reduce(0, +)
                    let avgScore = Int(sum)/Int(detectArray.count)
                    perc.text = String(describing: Int(avgScore)) + "%"
                    
                    if avgScore >= 80{
                        index += 1
                        questImage.image = ansImages[index]
                        showPopupCorrect(animated:  true,titleIn: "Correct", messageIn: "")
                    }
                  
                }
                else if index == 1{
                    
                    Score = emo2.anger
                    detectArray.append(Score)
                    detectArray.remove(at: 0)
                    
                    let sum = detectArray.reduce(0, +)
                    let avgScore = Int(sum)/Int(detectArray.count)
                    perc.text = String(describing: Int(avgScore)) + "%"
                    
                    if avgScore >= 80{
                        index += 1
                        questImage.image = ansImages[index]
                         showPopupCorrect(animated:  true,titleIn: "Correct", messageIn: "")
                    }
                    
                }
                else{
                    Score = emo.browFurrow
                    detectArray.append(Score)
                    detectArray.remove(at: 0)
                    
                    let sum = detectArray.reduce(0, +)
                    let avgScore = Int(sum)/Int(detectArray.count)
                    perc.text = String(describing: Int(avgScore)) + "%"
                   
                     if avgScore >= 80{
                    
                    showPopupEND(animated: true,titleIn: "Congratulation!", messageIn: "All Questions Complete. Thanks for Playing")
                    }
                }
                print(detectArray)
            }
        }
        else {
            // handle unprocessed image in this block of code
            imageDis.image = forImage
           // imageout.backgroundColor = UIColor(patternImage: forImage)
        }
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
        let buttonThree = DefaultButton(title: "Okay"){  }
        
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
        let buttonThree = DefaultButton(title: "Okay"){
            self.detector!.stop()
            self.performSegue(withIdentifier: "segFFBack", sender: self)
            
        }
        
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
    
    // UI Component: Return to Level select button
    // Activated: When Pressed
    // Action: Return to level selection page
    @IBAction func BackButton(_ sender: UIButton) {
        self.detector!.stop()
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
