//
//  messagingViewController.swift
//  Circle
//
//  Created by Leena Loo on 5/1/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class messagingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        self.tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    func initData(){
        //initialize data sent in from the create message thread page
        //initialize the users
    }
    

    @IBAction func sendButtonPressed(_ sender: Any) {
        //create a message object here based off of text from textInput textfield
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
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messagingCell") as? messagingTableViewCell{
            //let email = messages[indexPath.row].senderId
            //let content = messages[indexPath.row].content

           //here is where you input data for cell //cell.configureCell(senderType: email, content: content)

            return cell
        } else {
            return UITableViewCell()
        }
    }
}
