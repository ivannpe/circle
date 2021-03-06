//
//  groupsViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/29/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase

class groupsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var groupsArray = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = 120
        //tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //retreives all groups in database as array
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (groups) in
                self.groupsArray = groups
                self.tableView.reloadData()
            }
        }
    }
}
//table view delegate to display all groups as cells
extension groupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GroupVCCell") as? GroupVCCell {
            cell.configureCell(title: groupsArray[indexPath.row].groupTitle, description: groupsArray[indexPath.row].groupDesc, memberCount: groupsArray[indexPath.row].memberCount, isSelected: false)
            return cell
        } else {
            return GroupVCCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedViewController") as? GroupFeedViewController else { return }
        print("didselectrowat function called in groups view controller")
        //segue into group feed with current group selected for initialization
        groupFeedVC.initData(group: groupsArray[indexPath.row])
        //to init group about page with proper group
        /*
        guard let aboutPageVC = storyboard?.instantiateViewController(withIdentifier: "AboutPageViewController") as? AboutPageViewController else { return }
        print("didselectrowat function called in groups view controller")
        aboutPageVC.initData(group: groupsArray[indexPath.row])
        */
        //presentDetail(groupFeedVC)
        show(groupFeedVC, sender: AnyObject.self)
    }
    // UITableViewAutomaticDimension calculates height of label contents/text
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("auto dimension called for height of rows")
        return UITableView.automaticDimension
    }*/
}
