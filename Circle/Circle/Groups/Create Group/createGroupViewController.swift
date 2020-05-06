//
//  createGroupViewController.swift
//  Circle
//
//  Created by Leena Loo on 5/4/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class createGroupViewController: UIViewController {
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupDesc: UITextView!
    @IBOutlet weak var groupMembers: UITextField!
    @IBOutlet weak var addMemberLabel: UILabel!
    @IBOutlet weak var membersTableView: UITableView!
    @IBOutlet weak var createGroupBtn: UIButton!
    var emailArray = [String]()
    var chosenUserArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        membersTableView.delegate = self
        membersTableView.dataSource = self
        groupMembers.delegate = self
        
        groupMembers.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        createGroupBtn.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func textFieldDidChange() {
        if(groupMembers.text == "") {
            self.emailArray.removeAll()
            membersTableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: groupMembers.text!) { (emails) in
                self.emailArray = emails
                self.membersTableView.reloadData()
            }
        }
    }

    @IBAction func createGroupBtnPressed(_ sender: Any) {
        let title = groupName.text
        let description = groupDesc.text
        
        if(title != "" && description != "") {
            chosenUserArray.append((Auth.auth().currentUser?.email)!)
            
            DataService.instance.createGroups(withTitle: title!, andDescription: description!, forUserIds: chosenUserArray) { (completed) in
                if(completed) {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Failed to create group")
                }
            }
        }
    }
}

extension createGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell {
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
        
        addMemberLabel.text = chosenUserArray.joined(separator: ", ")
        
        if(addMemberLabel.text == "") {
            addMemberLabel.text = "Add Members"
            createGroupBtn.isHidden = true
        } else {
            createGroupBtn.isHidden = false
        }
    }
}

extension createGroupViewController: UITextFieldDelegate {
    
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


