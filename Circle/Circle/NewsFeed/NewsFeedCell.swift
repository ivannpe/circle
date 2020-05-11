//
//  NewsFeedCell.swift
//  Circle
//
//  Created by Ivanna Peña on 5/9/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    let lightBlue = UIColor(red: 0.7608, green: 0.8667, blue: 0.902, alpha: 1.0)
    func setupCell(username: String, content: String) {
        //groupLabel.text = groupname
        usernameLabel.text = username
        messageLabel.text = content
        //contentView.backgroundColor = lightBlue
        //contentView.layer.cornerRadius = 35
        //got rid of lines in between each cell with separator none in storyboard
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
