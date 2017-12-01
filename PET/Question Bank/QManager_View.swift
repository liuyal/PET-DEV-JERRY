//
//  QManager_View.swift
//  PET
//
//  Created by Wolf on 2017-10-19.
//  Copyright © 2017 TEAMX. All rights reserved.
//

// IMPORT FRAMWORKS
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import PopupDialog
import FontAwesome_swift

// Class: QManager_View
// Members:
//          1.
//          2.
//          3.
//          4.
// Description:
class QManager_View: UIViewController {
    
    // Reference to Database
    var ref: DatabaseReference!
    // User object for passing of object between views
    var user: User_Model?
    // Create a storage reference from our storage service
    let storage = Storage.storage()
    var storageRef: StorageReference!
    
    var questArray = [QuestionClass]()
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load Reference to Firebase Database
        ref = Database.database().reference()
        // Get a reference to the storage service using the default Firebase App
        storageRef = self.storage.reference()
        
        // Set tableView delegate and dataSource to self -> class QManager_View: UIViewController
        tableView.delegate = self
        tableView.dataSource = self
        
        // Update UI Elements
        titleBar.frame = CGRect(origin: CGPoint(x: 0,y :20), size: CGSize(width: 1024, height: 80))
        backButton.frame = CGRect(origin: CGPoint(x: 0,y :20), size: CGSize(width: 80, height: 80))
        addButton.frame = CGRect(origin: CGPoint(x: 944,y :20), size: CGSize(width: 80, height: 80))
        tableView.frame = CGRect(origin: CGPoint(x: 25,y :115), size: CGSize(width: 975, height: 630))
        
        self.tableView!.separatorStyle = .singleLine
        questArray = (user?.CustomQArray)!
        print(questArray.count)
    }
    
    // UI Button Label
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // UI Component: Direct to Add question page
    // Activated: When Pressed
    // Action: Perform segue  "segAddQ" to Add question page
    @IBAction func addButon(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segAddQ", sender: self)
    }
    
    // UI Component: Return to Main Menu BUTTON
    // Activated: When Pressed
    // Action: Perform segue  "segQmanageBack" to Main menu
    @IBAction func Main_menuButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segQmanageBack", sender: self)
    }
    
    // Function: overrider prepare() to allow for sending of variables to other view controllers
    // Input:
    //      1. for segue: UIStoryboardSegue
    //      2. sender: Any
    // Ouput: N/A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send_user = user
        let send_index = index
        if let destinationViewController = segue.destination as? Main_menu {
            destinationViewController.user = send_user
        }
        else if let destinationViewController = segue.destination as? AddQuestion_View {
            destinationViewController.user = send_user
        }
        else if let destinationViewController = segue.destination as? EditQuestion_View {
            destinationViewController.user = send_user
            destinationViewController.index = send_index
        }
    }
}

// Extenstion for TableView functions
extension QManager_View: UITableViewDelegate, UITableViewDataSource{
    
    // Return numver of cells in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questArray.count
    }
    
    // Load cells with class QuestionCell: UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
        cell.Qimage?.image = questArray[indexPath.row].image
        cell.QuestionLabel?.text = questArray[indexPath.row].imageFileRef
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
    
    // Delete and edit fields
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        //Edit
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            //print("edit button tapped", index[1])
            self.index = index[1]
            self.performSegue(withIdentifier: "segEditQ", sender: self)
           
        }
        // set tab color
        edit.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        //Delete
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            //Remove from DB
            let a =  self.user?.CustomQArray[index.item].levelID
            let b =  self.user?.CustomQArray[index.item].questionID
            
            // Create Path of image
            let Qname =  String(a!) + String(b!)
            let id = self.user?.ID
            let path =  "Custom_Question_Images" + "/" + id! + "/" + Qname + ".png"
            
            // remove image from storage
            let desertRef = self.storageRef.child(path)
            desertRef.delete { error in
                if let error = error {
                    print("Uh-oh, an error occurred!", error)
                } else {
                    print("File deleted successfully")
                }
            }
            
            // Remove from table database
            self.ref.child("ROOT").child(id!).child("CustomQuestions").child(Qname).setValue(nil)

            //Remove from local object
            self.questArray.remove(at: index.item)
            
            //Remove from Local user Object
            self.user?.CustomQArray.remove(at: index.item)
            
            // Remove from Table
            tableView.deleteRows(at: [index], with: .automatic)
            print("delete button tapped")
        }
        // set tab color
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return [delete,edit]
    }
}

// Class: QuestionCell
// Members:
//          1. Qimage: UIImageView?
//          2. QuestionLabel: UILabel?
// Description: Cell used to populate table
class QuestionCell: UITableViewCell {
    
    public typealias T = QuestionClass
    @IBOutlet public var Qimage: UIImageView?
    @IBOutlet public var QuestionLabel: UILabel?
    
    // Initializer
    public func configure(_ model: QuestionClass, path: IndexPath) {
        self.Qimage?.image = model.image
        self.QuestionLabel?.text = model.imageFileRef
    }
}


