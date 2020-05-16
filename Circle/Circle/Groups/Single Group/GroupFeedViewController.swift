//
//  GroupFeedViewController.swift
//  Circle
//
//  Created by Ivanna Peña on 5/6/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class GroupFeedViewController: UIViewController {
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var aboutPage: UIButton!
    @IBOutlet weak var membersPage: UIButton!
    @IBOutlet weak var postPage: UIButton!
    @IBOutlet weak var groupName: UINavigationItem!
    var group: Group?
    var messages = [Message]()
    var emailArray = [String]()

    func initData(group: Group) {
        self.group = group
        print("group");
        print(group)
        print(group.groupTitle)
        DataService.instance.getEmails(group: self.group!) { (returnedEmails) in
        self.emailArray = returnedEmails
        }
        print("initdata")
        print(self.emailArray)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //followButton.isHidden = true
        //postPage.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        self.tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let group = group {
            groupName.title = group.groupTitle
            groupNameLabel.text = group.groupTitle
//            self.memberLbl.text = group.members.joined(separator: ", ")
        }
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessages(group: self.group!, handler: { (messages) in
                self.messages = messages
                print(self.messages)
                self.tableView.reloadData()

                if(self.messages.count > 0) {
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .none, animated: true)
                    }
                }else{
                    print("no messages")
                }
            }) //end of data service
        }
        /*
        if (self.emailArray.contains((Auth.auth().currentUser?.email)!)){
            print("hide follow button")
            followButton.isHidden = true
            postPage.isHidden = false
        }
        if !(self.emailArray.contains((Auth.auth().currentUser?.email)!)){
            print("show follow button")
            followButton.isHidden = false
            postPage.isHidden = true
        }*/
    }

    @IBAction func followButtonPressed(_ sender: Any) {
        print("follow button pressed")
        
        //DataService.instance.REF_GROUPS.observe(.value) { (userSnapshot) in
            //guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
        
        //self.emailArray = self.group!.members
        print("original returned emails in follow button pressed")
        print(self.emailArray)
        if !(self.emailArray.contains((Auth.auth().currentUser?.email)!)){
            self.emailArray.append((Auth.auth().currentUser?.email)!)
        }
        print("appended current user email")
        print(self.emailArray)
            //userSnapshot.updateChildValues(["members": self.emailArray])
        //}
        let groupKey = self.group?.key
        print(groupKey!)
        if groupKey != nil {
            DataService.instance.REF_GROUPS.child(groupKey!).updateChildValues(["members": self.emailArray])
            print("updated members")
            followButton.isHidden = true
        }
}
    
    
    @IBAction func aboutButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutPageViewController") as! AboutPageViewController
        //vc.initData(group: group)
        //group != nil
        if let group = group {
            vc.group = self.group
        }
        //presentDetail(vc)
        showDetailViewController(vc, sender: AnyObject.self)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func membersButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MembersViewController") as! MembersViewController
        //vc.group = self.group
        if let group = group {
            vc.group = self.group
        }
        showDetailViewController(vc, sender: AnyObject.self)
//        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func postButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        if let group = group {
            vc.group = self.group
        }
        showDetailViewController(vc, sender: AnyObject.self)
        //vc.group = self.group
//        navigationController?.pushViewController(vc, animated: true)
    }
    //    @IBAction func backBtnPressed(_ sender: Any) {
//        dismissDetail()
//    }

//    @IBAction func sendMessageBtnPressed(_ sender: Any) {
//        let message: String = messageTextField.text!
//
//        if(message != "") {
//            sendBtn.isEnabled = false
//            messageTextField.isEnabled = false
//
//            DataService.instance.uploadPost(withMessage: message, forUID: (Auth.auth().currentUser?.email)!, withGroupKey: (group?.key)!) { (success) in
//                if(success) {
//                    self.sendBtn.isEnabled = true
//                    self.messageTextField.isEnabled = true
//                    self.messageTextField.text = ""
//                }
//            }
//        }
//    }
}

extension GroupFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GroupFeedTableViewCell") as? GroupFeedTableViewCell {
            let email = messages[indexPath.row].senderId
            let content = messages[indexPath.row].content

            cell.configureCell(username: email, content: content)

            return cell
        } else {
            return UITableViewCell()
        }
    }
}
