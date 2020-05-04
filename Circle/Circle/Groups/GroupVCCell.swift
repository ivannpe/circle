//
//  GroupVCCell.swift
//  Circle
//
//  Created by Ivanna Peña on 5/3/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class GroupVCCell: UITableViewCell {
    @IBOutlet weak var groupnameLabel: UILabel!
    @IBOutlet weak var groupdescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(title: String, description: String) {
        self.groupnameLabel.text = title
        self.groupdescLabel.text = description
    }

}
