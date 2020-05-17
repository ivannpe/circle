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
    var messages = [ChatMessage]()
    var preview: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

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

extension MessagePreviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //fix this
        return chatArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messagePreview") as? messagePreviewTableViewCell {
            //change this when have chat message objects
            let chatkey = self.chatArray[indexPath.row].key
            DataService.instance.REF_CHATS.observe(.value) { (snapshot) in
                DataService.instance.getAllChatMessages(chatKey: chatkey) { (chatMessageArray) in
                self.messages = chatMessageArray
                    let count = self.messages.count
                    self.preview = self.messages[count-1].content

                    
            }
            }
            //let preview = self.chatArray[indexPath.row].messages[count].value
            //let preview = ""
            let user = self.chatArray[indexPath.row].members[0]
            print("message preview users")
            print(user)
            print(self.preview)
            cell.configureCell(user: user, preview: self.preview, isSelected: false)
            return cell
        } else {
            return GroupVCCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let messagingVC = storyboard?.instantiateViewController(withIdentifier: "messagingViewController") as? messagingViewController else { return }
        print("didselectrowat function called in message preview")
        messagingVC.initData(chat: self.chatArray[indexPath.row])
        //to init group about page with proper group
        /*
        guard let aboutPageVC = storyboard?.instantiateViewController(withIdentifier: "AboutPageViewController") as? AboutPageViewController else { return }
        print("didselectrowat function called in groups view controller")
        aboutPageVC.initData(group: groupsArray[indexPath.row])
        */
        //presentDetail(groupFeedVC)
        show(messagingVC, sender: AnyObject.self)
    }
    // UITableViewAutomaticDimension calculates height of label contents/text
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("auto dimension called for height of rows")
        return UITableView.automaticDimension
    }*/
}
