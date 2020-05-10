//
//  NewsFeedCell.swift
//  Circle
//
//  Created by Ivanna Peña on 5/9/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    func setupCell(username: String, content: String) {
        //groupLabel.text = groupname
        usernameLabel.text = username
        messageLabel.text = content
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
