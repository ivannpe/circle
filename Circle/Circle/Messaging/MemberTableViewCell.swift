//
//  MemberTableViewCell.swift
//  Circle
//
//  Created by Ivanna Peña on 5/16/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import Foundation
import UIKit
//cell for creating a chat table of available users to chat with
class MemberTableViewCell: UITableViewCell {
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    var checked = false
    
    func setupCell(email: String, isSelected: Bool) {
        userEmail.text = email
        checkMark.isHidden = !isSelected
        checked = !isSelected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if(selected) {
            checkMark.isHidden = !checked
            checked = !checked
        }
    }

}
