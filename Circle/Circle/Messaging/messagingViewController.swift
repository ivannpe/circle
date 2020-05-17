//
//  messagingViewController.swift
//  Circle
//
//  Created by Leena Loo on 5/1/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase

class messagingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var userNameTitle: UINavigationItem!
    var senderType: String = ""
    var messages = [ChatMessage]()
    var chat: Chat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = 100
        self.tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    func initData(chat: Chat){
        //initialize data sent in from the create message thread page
        //initialize the users
        print("init data in messaging ")
        self.chat = chat
        print(self.chat!.members[0])
        //self.messages = self.chat.chatMessageArray
    }
    override func viewWillAppear(_ animated: Bool){
        userNameTitle.title = self.chat!.members[0]
        
        DataService.instance.REF_CHATS.observe(.value) { (snapshot) in
            DataService.instance.getAllChatMessages(chatKey: self.chat!.key) { (chatMessageArray) in
                
                self.messages = chatMessageArray
                self.tableView.reloadData()
                print("printing chatMessageArray")
                print(self.messages)
            }
        }
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        //create a message object here based off of text from textInput textfield
        //let message = textInput
        DataService.instance.uploadChat(withMessage: textInput.text!, forUID: (Auth.auth().currentUser?.email)!, withChatKey: self.chat?.key) { (success) in
            if success{
                print("successfully sent chat message")
                self.textInput.text = ""
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension messagingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of message in thread")
        print(self.messages.count)
        return self.messages.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messagingCell") as? messagingTableViewCell{
            //let email = messages[indexPath.row].senderId
            let email = self.messages[indexPath.row].senderId
            let content = self.messages[indexPath.row].content
            
            if email == (Auth.auth().currentUser?.email)! {
                senderType = "sent"
            }
            else{
                senderType = "received"
            }

           cell.configureCell(senderType: senderType, content: content)

            return cell
        } else {
            return UITableViewCell()
        }
    }
}

