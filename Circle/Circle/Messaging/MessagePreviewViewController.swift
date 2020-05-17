//
//  MessagePreviewViewController.swift
//  Circle
//
//  Created by Leena Loo on 5/16/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase

class MessagePreviewViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var chatArray = [Chat]()
    var user: String = ""
    var messages = [ChatMessage]()
    var preview: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets constraints
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //retrieves all chat objects that current user is a member of
        DataService.instance.REF_CHATS.observe(.value) { (snapshot) in
            DataService.instance.getAllChats { (chatArray) in
                self.chatArray = chatArray
                self.tableView.reloadData()
                print("printing chatArray")
                print(chatArray)
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
//table view delegate to display message previews and message recipients
extension MessagePreviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //fix this
        return chatArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messagePreview") as? messagePreviewTableViewCell {
            //change this when have chat message objects
            let chatkey = self.chatArray[indexPath.row].key
            //retrieve chatmessage objects from current chat object as an array
            DataService.instance.REF_CHATS.observe(.value) { (snapshot) in
                DataService.instance.getAllChatMessages(chatKey: chatkey) { (chatMessageArray) in
                self.messages = chatMessageArray
                    let count = self.messages.count
                    //sets preview message to last message in array
                    if count > 0{
                        self.preview = self.messages[count-1].content
                    }
                    
            }
            }
            //let preview = self.chatArray[indexPath.row].messages[count].value
            //let preview = ""
            //set name of chat as the secondary member email of the chat
            if self.chatArray[indexPath.row].members[0] == (Auth.auth().currentUser?.email)! {
                self.user = self.chatArray[indexPath.row].members[1]
            }
            if self.chatArray[indexPath.row].members[1] == (Auth.auth().currentUser?.email)! {
                self.user = self.chatArray[indexPath.row].members[0]
            }
            print("message preview users")
            print(user)
            print(self.preview)
            //configures messagePreviewTableViewCell
            cell.configureCell(user: self.user, preview: self.preview, isSelected: false)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let messagingVC = storyboard?.instantiateViewController(withIdentifier: "messagingViewController") as? messagingViewController else { return }
        print("didselectrowat function called in message preview")
        //initialize the messagingViewController with current chat object selected
        messagingVC.initData(chat: self.chatArray[indexPath.row])
        show(messagingVC, sender: AnyObject.self)
    }
}
