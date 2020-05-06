//
//  groupsViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/29/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class groupsViewController: UIViewController {
    @IBOutlet weak var groupsTableView: UITableView!
    var groupsArray = [Group]()
        override func viewDidLoad() {
            super.viewDidLoad()
            groupsTableView.delegate = self
            groupsTableView.dataSource = self
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
                DataService.instance.getAllGroups { (returnedGroupsArray) in
                    self.groupsArray = returnedGroupsArray
                    self.groupsTableView.reloadData()
                }
            }
        }
    }

    extension groupsViewController: UITableViewDelegate, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return groupsArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupVCCell else { return UITableViewCell() }
            let group = groupsArray[indexPath.row]
            cell.configureCell(title: group.groupTitle, description: group.groupDesc)
            return cell
        }
        //ADD ONCE FEED IS MADE
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else { return }
//            groupFeedVC.initData(forGroup: groupsArray[indexPath.row])
//            presentDetail(groupFeedVC)
//        }
    }
