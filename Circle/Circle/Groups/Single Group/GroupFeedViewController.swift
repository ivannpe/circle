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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var aboutPage: UIButton!
    @IBOutlet weak var membersPage: UIButton!
    @IBOutlet weak var postPage: UIButton!
    @IBOutlet weak var groupName: UINavigationItem!
    var group: Group?
    var messages = [Message]()
    
    func initData(group: Group) {
        self.group = group
        //print(group);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let group = group {
            groupName.title = group.groupTitle
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
    }

    @IBAction func aboutButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutPageViewController") as! AboutPageViewController
        //vc.group = self.group
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func membersButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MembersViewController") as! MembersViewController
        //vc.group = self.group
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func postButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        //vc.group = self.group
        navigationController?.pushViewController(vc, animated: true)
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

