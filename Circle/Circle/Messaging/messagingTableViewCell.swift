//
//  messagingTableViewCell.swift
//  Circle
//
//  Created by Leena Loo on 5/16/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class messagingTableViewCell: UITableViewCell {

    @IBOutlet weak var receiveTextLabel: UILabel!
    @IBOutlet weak var sentTextLabel: UILabel!
    
    /*
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }*/
        
        func configureCell(senderType: String, content: String) {
            if senderType == "received"{
                self.receiveTextLabel.text = content
                
            }
            if senderType == "sent"{
                self.sentTextLabel.text = content
            }
        }

    }
