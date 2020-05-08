//
//  AboutPageViewController.swift
//  Circle
//
//  Created by Ivanna Peña on 5/6/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class AboutPageViewController: UIViewController {
    var group: Group?
    //var groupD: String = ""
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    func initData(group: Group) {
        print("init data")
        print(group.groupTitle)
        self.group = group
        //self.groupD = group.groupDesc
        print(group.groupTitle)
        //print(self.groupD)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //groupDescriptionLabel.text = self.groupSingle?.groupDesc
        //print("viewdidloadcalled in about page")
        //print(self.groupSingle?.groupDesc)
        //initialSetupPostView()
        // Do any additional setup after loading the view.
        print("viewdidload")
        //print(groupD)
        self.aboutLabel.text = "About " + self.group!.groupTitle
        self.groupDescriptionLabel.text = self.group?.groupDesc
        self.memberCountLabel.text = String(format:"%d Members", self.group!.memberCount)
        //print(self.groupD)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

        
    }
        
        /*func initialSetupPostView() {
            contentTextView.delegate = self as? UITextViewDelegate
        
            //postBtn.bindToKeyboard()
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
        }*/

}
