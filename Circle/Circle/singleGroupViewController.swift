//
//  singleGroupViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/28/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class singleGroupViewController: UIViewController {

    @IBOutlet weak var singleGroupNavBar: UISegmentedControl!
    @IBOutlet weak var membersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func singleGroupSegmentControl(_ sender: Any) {
        if(singleGroupNavBar.selectedSegmentIndex == 0){
            //show only posts for this group
            //hide the table view of members
            //might need to do sublayers here with this view controller as the parent
            membersTableView.isHidden = true;
        }
        if(singleGroupNavBar.selectedSegmentIndex == 1){
            //show table view of members in this group
            membersTableView.isHidden = false;
        }
        if(singleGroupNavBar.selectedSegmentIndex == 2){
            //show about info for this group
            membersTableView.isHidden = true;
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
