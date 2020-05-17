//
//  createChatViewController.swift
//  Circle
//
//  Created by Ivanna Peña on 5/16/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class createChatViewController: UIViewController {
    //member label
    //table view
    //createGoupbutton
    @IBOutlet weak var chatMember: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createChatButton: UIButton!
    var emailArray = [String]()
    var chosenUserArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        chatMember.delegate = self
        
        chatMember.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        createChatButton.isHidden = true
    }
    
    @objc func textFieldDidChange() {
        if(chatMember.text == "") {
            self.emailArray.removeAll()
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: chatMember.text!) { (emails) in
                self.emailArray = emails
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func createChatButton(_ sender: Any) {
        let members = chatMember.text
        if(members != "") {
            chosenUserArray.append((Auth.auth().currentUser?.email)!)
            
            DataService.instance.createChats(forUserIds: chosenUserArray) { (completed) in
                if(completed) {
                    self.dismiss(animated: true, completion: nil)

                } else {
                    print("Failed to create chat")
                }
            }
        }
    }
}

extension createChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell") as? MemberTableViewCell {
            let email = emailArray[indexPath.row]
            var selected = false
            
            if(chosenUserArray.contains(email)) {
                selected = true
            }
            
            cell.setupCell(email: email, isSelected: selected)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let email = emailArray[indexPath.row]
        
        if(!chosenUserArray.contains(email)) {
            chosenUserArray.append(email)
        } else {
            if let index = chosenUserArray.firstIndex(of: email) {
                chosenUserArray.remove(at: index)
            }
        }
        
    }
}

extension createChatViewController: UITextFieldDelegate {
    
}
