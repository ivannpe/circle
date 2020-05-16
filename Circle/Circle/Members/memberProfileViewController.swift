//
//  memberProfileViewController.swift
//  Circle
//
//  Created by Leena Loo on 5/8/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//


//this view controller is to view a profile other than the current user's account profile

import UIKit
import Firebase
import Alamofire
import AlamofireImage

class memberProfileViewController: UIViewController {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    //var user: DataSnapshot
    @IBOutlet weak var tableView: UITableView!
    var email: String = ""
    var groupsArray = [Group]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializingProfile()
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMembersGroupNames(email: self.email) { (groups) in
                self.groupsArray = groups
                self.tableView.reloadData()
                print(self.groupsArray)
            }
        }
    }
    
    func initData(email:String){
        self.email = email
        
    }
    func initializingProfile() {
        /*
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
        var idArray = [String]()
        guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
        for user in userSnapshot {
            let email = user.childSnapshot(forPath: "email").value as! String
            if usernames.contains(email) {
                idArray.append(user.key)
            }
        }
        print(idArray[0])
        handler(idArray)*/
            
        let ref = Database.database().reference().child("users")
        //let UserID = Auth.auth().currentUser?.uid
        //print(UserID!)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
        guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
            else { return }
        
        for user in snapshot {
            let email = user.childSnapshot(forPath: "email").value as! String
            if email.contains(self.email) {
                let userID = user.key 
                let fullname = user.childSnapshot(forPath: "fullname").value
                print(fullname!)
                self.fullNameLabel.text = ((fullname!) as! String)
                let username = user.childSnapshot(forPath: "username").value
                self.usernameLabel.text = "@" + ((username!) as! String)
                let school = user.childSnapshot(forPath: "school").value
                self.schoolLabel.text = ((school!) as! String)
                let major = user.childSnapshot(forPath: "major").value
                self.majorLabel.text = ((major!) as! String)
                let year = user.childSnapshot(forPath: "year").value
                self.yearLabel.text = "Class of " + ((year!) as! String)
                
                 //need to figure out how to get the user id from this
                 //crashes when try to cast user.value as a string which the function takes in
                DataService.instance.getCurrentUserProfilePicture(userUID: userID) { (imageURL) in
                    guard let url = URL(string: imageURL) else { return }
                    print("calling self.profilepic.af_setimage")
                    self.profilePic.af_setImage(withURL: url)
                }
            }
        }
            /*
        //to make full name label retrieve from database
        print(fullname!)
            self.fullNameLabel.text = ((self.fullname!) as! String)
        
        //to make username label retrieve from database
        print(username!)
        self.usernameLabel.text = "@" + ((username!) as! String)
        
        //to make full name label retrieve from database
        print(school!)
        self.schoolLabel.text = ((school!) as! String)
        
        //to make major label retrieve from database

        print(major!)
        self.majorLabel.text = ((major!) as! String)
        
        //to make year label retrieve from database
        
        print(year!)
        self.yearLabel.text = "Class of " + ((year!) as! String)*/
    })
        /*
    DataService.instance.getCurrentUserProfilePicture(userUID: UserID!) { (imageURL) in
        guard let url = URL(string: imageURL) else { return }
        print("calling self.profilepic.af_setimage")
        self.profilePic.af_setImage(withURL: url)
    }*/
    }

}

extension memberProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.groupsArray.count)
        return self.groupsArray.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("profile group cell for row at called")
        print(self.groupsArray[indexPath.row].groupTitle)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "memberProfileCell") as? memberProfileTableViewCell{
            cell.configureCell(title: self.groupsArray[indexPath.row].groupTitle, isSelected: false)
            print(self.groupsArray[indexPath.row].groupTitle)
            return cell
        } else {
            return memberProfileTableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedViewController") as? GroupFeedViewController else { return }
        print("didselectrowat function called in profile controller")
        groupFeedVC.initData(group: self.groupsArray[indexPath.row])
        //to init group about page with proper group
        /*
        guard let aboutPageVC = storyboard?.instantiateViewController(withIdentifier: "AboutPageViewController") as? AboutPageViewController else { return }
        print("didselectrowat function called in groups view controller")
        aboutPageVC.initData(group: groupsArray[indexPath.row])
        */
        //presentDetail(groupFeedVC)
        show(groupFeedVC, sender: AnyObject.self)
    }
    // UITableViewAutomaticDimension calculates height of label contents/text
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("auto dimension called for height of rows")
        return UITableView.automaticDimension
    }*/
}
