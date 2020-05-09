//
//  MembersViewController.swift
//  Circle
//
//  Created by Ivanna Peña on 5/6/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MembersViewController: UIViewController {
    var group: Group?
    var emailArray = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    func initData(group: Group) {
        print("init data for member view")
        print(group.groupTitle)
        self.group = group
        //self.groupD = group.groupDesc
        print(group.groupTitle)
        //print(self.groupD)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialSetupPostView()
        // Do any additional setup after loading the view.
        print("member table view delegate called")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print(self.group!.groupTitle)
            print(group!.groupTitle)
            DataService.instance.getEmails(group: group!) { (returnedEmails) in
                self.emailArray = returnedEmails
                print(self.emailArray)
                print("retrieve email array")
                print(self.emailArray)
                self.tableView.reloadData()
                
            }
            /*
            DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
                DataService.instance.getEmails(group: self.group!, handler: { (emailArray) in
                    self.emailArray = emailArray
                    
                    self.tableView.reloadData()
                })
            }*/
        }
        
        /*func initialSetupPostView() {
            contentTextView.delegate = self as? UITextViewDelegate
        
            //postBtn.bindToKeyboard()
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
        }*/

}

extension MembersViewController: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("number of rows in section members called")
    print(self.emailArray.count)
    return self.emailArray.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("cell for row at members called")
    if let cell = tableView.dequeueReusableCell(withIdentifier: "memberTableViewCell") as? memberTableViewCell {
        let email = self.emailArray[indexPath.row]
        print("cell for row at called")
        print(email)
        //var selected = false
        cell.setupCell(email: email, isSelected: false)
            return cell
        } else {
            return UITableViewCell()
        }
}
}
