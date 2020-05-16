//
//  memberProfileTableViewCell.swift
//  Circle
//
//  Created by Leena Loo on 5/15/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class memberProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
        func configureCell(title: String) {
            print("member profile group configure cell called")
            self.groupNameLabel.text = title
            print(title)
            //self.groupdescLabel.text = description
            //print(description)
            //self.memberCountLabel.text = "\(memberCount) members"
            //print(memberCount)
        }
    }