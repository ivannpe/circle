//
//  memberTableViewCell.swift
//  Circle
//
//  Created by Leena Loo on 5/8/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class memberTableViewCell: UITableViewCell {
    @IBOutlet weak var memberNameLabel: UILabel!
    
    //var checked = false
        
    func setupCell(email: String, isSelected: Bool) {
        print("setup member table cell")
        memberNameLabel.text = email
        print(email)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
