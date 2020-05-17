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
    //let lightBlue = UIColor(red: 0.7608, green: 0.8667, blue: 0.902, alpha: 1.0)
    @IBOutlet weak var tableView: UITableView!
    var messageArray = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        print("tableview.delegate")
        tableView.dataSource = self
        print("tableview.datasource")
        tableView.rowHeight = 150
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //retrieves all feed messages from database for groups user is a part of
        DataService.instance.getAllFeedMessages{ (messageArray) in
            print(messageArray)
            self.messageArray = messageArray.reversed()
            self.tableView.reloadData()
            print("back in viewwillappear")
            print(self.messageArray)
        }
        print("GETTING ALL FEED MESSAGES")
    }
    
}
//table view delegate for newsfeed
extension newsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("getting message array count")
        print(self.messageArray.count)
        return self.messageArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell for row at feed called")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell") as? NewsFeedCell {
            let message = self.messageArray[indexPath.row]
            print("message:")
            print(message.content)
            //DataService.instance.getUsername(forUID: message.senderId) { (username) in
                //print("username: ")
                //print(username)
                print(message.content)
            //display every message as a cell
            cell.setupCell(username: message.senderId, content: message.content)
            //}
            //cell.backgroundColor = lightBlue
            return cell
        } else {
            print("NO MESSAGES TO RETRIEVE")
            return UITableViewCell()
        }
    }
    /* to round edges
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
    }*/
}
