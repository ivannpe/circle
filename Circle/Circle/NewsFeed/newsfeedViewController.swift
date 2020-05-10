//
//  newsfeedViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/28/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase

class newsfeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var messageArray = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        print("tableview.delegate")
        tableView.dataSource = self
        print("tableview.datasource")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        DataService.instance.getAllFeedMessages { (messages) in
            self.messageArray = messages.reversed()
            self.tableView.reloadData()
        }
        print("GETTING ALL FEED MESSAGES")
    }
}

extension newsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("getting message array count")
        return messageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell") as? NewsFeedCell {
            let message = messageArray[indexPath.row]
            print("message:")
            print(message)
            DataService.instance.getUsername(forUID: message.senderId) { (username) in
                print("username: ")
                print(username)
                cell.setupCell(username: username, content: message.content)
            }

            return cell
        } else {
            print("NO MESSAGES TO RETRIEVE")
            return UITableViewCell()
        }
    }
}
