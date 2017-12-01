//
//  GlobalPlay_View.swift
//  PET
//
//  Created by liuyal on 11/16/17.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import PopupDialog
import FontAwesome_swift

class GlobalPlay_View: UIViewController {
    
    // Reference to Database
    var ref: DatabaseReference!
    // User object for passing of object between views
    var user: User_Model?
    // Create a storage reference from our storage service
    let storage = Storage.storage()
    var storageRef: StorageReference!
    var index: Int = 0
    
    var globalPlaylist = [QuestionClass]()
    var creatorList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load Reference to Firebase Database
        ref = Database.database().reference()
        // Get a reference to the storage service using the default Firebase App
        storageRef = self.storage.reference()
        
        // Set tableView delegate and dataSource to self -> class QManager_View: UIViewController
        tableView.delegate = self
        tableView.dataSource = self
        
        titleBar.frame = CGRect(origin: CGPoint(x: 0,y :20), size: CGSize(width: 1024, height: 80))
        backButton.frame = CGRect(origin: CGPoint(x: 0,y :20), size: CGSize(width: 80, height: 80))
        tableView.frame = CGRect(origin: CGPoint(x: 25,y :115), size: CGSize(width: 975, height: 630))
        RefreshButton.frame = CGRect(origin: CGPoint(x: 954,y :35), size: CGSize(width: 50, height: 50))
        
        self.tableView!.separatorStyle = .singleLine
        
        if globalPlaylist.count == 0{
            self.LoadPlaylist()
            // self.LoadCreatorlist()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //tableView.reloadData()
        if globalPlaylist.count == 0{
            showPopupError(animated:true, titleIn: "Welcome to Global Playlist", messageIn: "Hit Okay to play shared questions.")
        }
    }
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var RefreshButton: UIButton!
    
    @IBAction func backbutton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segGlobalPlayback", sender: self)
    }
    
    @IBAction func load(_ sender: UIButton) {
        tableView.reloadData()
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
        let buttonOne = DefaultButton(title: "Okay"){self.tableView.reloadData()}
        
        // Edit appearance
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = UIFont.boldSystemFont(ofSize: 25)
        dialogAppearance.messageFont = UIFont.systemFont(ofSize: 18)
        buttonOne.titleFont = UIFont.systemFont(ofSize: 20)
        buttonOne.titleColor = UIColor.darkGray
        popup.addButtons([buttonOne])
        
        self.present(popup, animated: true, completion: nil)
    }
    
    func LoadPlaylist(){
        var counter = 0
        self.ref.child("ROOT").observeSingleEvent(of: .value, with: { (snapshot) in
            let NSshotSize = snapshot.childrenCount
            let DBsize = Int(NSshotSize)
            var groupNames = [String]()
            for group in snapshot.children {
                groupNames.append((group as AnyObject).key)
            }
            
            for i in 0..<DBsize{
                self.ref.child("ROOT").child(groupNames[i]).child("CustomQuestions").observeSingleEvent(of: .value, with: { (snapshot) in
                    let NSshotSize2 = snapshot.childrenCount
                    let DBsize2 = Int(NSshotSize2)
                    var groupNames2 = [String]()
                    for group2 in snapshot.children {
                        groupNames2.append((group2 as AnyObject).key)
                    }
                    
                    for j in 0..<DBsize2{
                        self.ref.child("ROOT").child(groupNames[i]).child("CustomQuestions").child(groupNames2[j]).observeSingleEvent(of: .value, with: { (snapshot) in
                            
                            var imageIn = UIImage()
                            // Name for each Question
                            let QID = Int(groupNames2[j])
                            // Load emotionID from DB
                            let NSemo = snapshot.childSnapshot(forPath: "emotion").value as? NSString!
                            let Semo = NSemo as? String ?? ""
                            let emoIn = self.stringToemo(string: Semo)
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
                            let addedQ = QuestionClass(levelID: 0, questionID: QID!, emotion: emoIn, errCnt: 0, questionState: .initial, imageFileRef: Sprompt, picture: imageIn, urlIn: SUrl)
                            self.globalPlaylist.append(addedQ)
                        })
                        counter += 1
                    }
                })
            }
        })
    }
    
    /*
     func LoadCreatorlist(){
     self.ref.child("ROOT").observeSingleEvent(of: .value, with: { (snapshot) in
     let NSshotSize = snapshot.childrenCount
     let DBsize = Int(NSshotSize)
     var groupNames = [String]()
     for group in snapshot.children {
     groupNames.append((group as AnyObject).key)
     }
     print(groupNames)
     for i in 0..<DBsize{
     self.ref.child("ROOT").child(groupNames[i]).child("CustomQuestions").observeSingleEvent(of: .value, with: { (snapshot) in
     let NSshotSize2 = snapshot.childrenCount
     let DBsize2 = Int(NSshotSize2)
     var groupNames2 = [String]()
     for group2 in snapshot.children {
     groupNames2.append((group2 as AnyObject).key)
     }
     print(groupNames2)
     
     self.ref.child("ROOT").child(groupNames[i]).observeSingleEvent(of: .value, with: { (snapshot) in
     let NSName = snapshot.childSnapshot(forPath: "Name").value as? NSString!
     let SName = NSName as? String ?? ""
     for j in 0..<DBsize2{
     self.ref.child("ROOT").child(groupNames[i]).child("CustomQuestions").child(groupNames2[j]).observeSingleEvent(of: .value, with: { (snapshot) in
     
     self.creatorList.append(SName)
     print(SName)
     })
     }
     })
     })
     }
     })
     }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        let send_playlist = globalPlaylist
        let send_index = index
        if let destinationViewController = segue.destination as? LevelSelect_View {
            destinationViewController.user = send_user
        }
        else if let destinationViewController = segue.destination as? GlobalGameplay_View {
            destinationViewController.user = send_user
            destinationViewController.playlist = send_playlist
            destinationViewController.index = send_index
        }
    }
}

// Extenstion for TableView functions
extension GlobalPlay_View: UITableViewDelegate, UITableViewDataSource{
    
    // Return numver of cells in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalPlaylist.count
    }
    
    // Load cells with class QuestionCell: UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell2", for: indexPath) as! QuestionCell2
        cell.Qimage?.image = globalPlaylist[indexPath.row].image
        cell.QuestionLabel?.text = globalPlaylist[indexPath.row].imageFileRef
        //cell.creator?.text = "Created By: " + creatorList[indexPath.row]
        print(indexPath.row)
        return cell
    }
    
    // set cells to be editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Set Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        
        self.performSegue(withIdentifier: "Gplay", sender: self)
        
    }
}

// Class: QuestionCell2
// Members:
//          1. Qimage: UIImageView?
//          2. QuestionLabel: UILabel?
// Description: Cell used to populate table
class QuestionCell2: UITableViewCell {
    
    public typealias T = QuestionClass
    @IBOutlet public var Qimage: UIImageView?
    @IBOutlet public var QuestionLabel: UILabel?
    
    // Initializer
    public func configure(_ model: QuestionClass, path: IndexPath) {
        self.Qimage?.image = model.image
        self.QuestionLabel?.text = model.imageFileRef
    }
}
