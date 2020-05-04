//
//  profileViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/28/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase

class profileViewController: UIViewController {


    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var majorLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    //var fullname: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let ref = Database.database().reference().child("users")
        let UserID = Auth.auth().currentUser?.uid
        print(UserID!)

        ref.child(UserID ?? "").observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                print("snapshot failed")
                return }
            print(snapshot)
            print(snapshot.value as Any)
            
            //to make full name label retrieve from database
            let fullname = snapshot.childSnapshot(forPath: "fullname").value
            print(fullname!)
            self.fullNameLabel.text = ((fullname!) as! String)
            
            //to make username label retrieve from database
            let username = snapshot.childSnapshot(forPath: "username").value
            print(username!)
            self.usernameLabel.text = "@" + ((username!) as! String)
            
            //to make full name label retrieve from database
            let school = snapshot.childSnapshot(forPath: "school").value
            print(school!)
            self.schoolLabel.text = ((school!) as! String)
            
            //to make major label retrieve from database
            let major = snapshot.childSnapshot(forPath: "major").value
            print(major!)
            self.majorLabel.text = ((major!) as! String)
            
            //to make year label retrieve from database
            let year = snapshot.childSnapshot(forPath: "year").value
            print(year!)
            self.yearLabel.text = "Class of " + ((year!) as! String)
        })
        

            /*
        DataService.instance.getDBFN { (fullname) in

        self.fullname = fullname

        if let fullname = fullname {

            self.fullNameLabel.text = "\(fullname)"
        }*/

        //Auth.auth().currentUser?.
    //}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
