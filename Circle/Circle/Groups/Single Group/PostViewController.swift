//
//  PostViewController.swift
//  Circle
//
//  Created by Leena Loo on 5/3/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {


    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    var group: Group?
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
        //initialSetupPostView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        let message: String = messageText.text!
        if(message != "") {
            postBtn.isEnabled = false
            //messageText.isEnabled = false

            DataService.instance.uploadPost(withMessage: message, forUID: (Auth.auth().currentUser?.email)!, withGroupKey: (group?.key)!) { (success) in
                if(success) {
                    self.postBtn.isEnabled = true
                    //self.messageText.isEnabled = true
                    self.messageText.text = ""
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
/*
extension PostViewController: UITextViewDelegate {
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
        }
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
