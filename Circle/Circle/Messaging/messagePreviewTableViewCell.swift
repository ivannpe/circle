//
//  messagePreviewTableViewCell.swift
//  Circle
//
//  Created by Leena Loo on 5/16/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class messagePreviewTableViewCell: UITableViewCell {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messagePreviewLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(user: String, preview: String, isSelected: Bool) {
        self.userLabel.text = user
        self.messagePreviewLabel.text = preview
    }
}
