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

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialSetupPostView()
        // Do any additional setup after loading the view.
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        /*func initialSetupPostView() {
            contentTextView.delegate = self as? UITextViewDelegate
        
            //postBtn.bindToKeyboard()
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
        }*/
        
    
    @IBAction func postTapped(_ sender: Any) {
            if contentTextView.text != nil && contentTextView.text != "Write something here.." {
                postBtn.isEnabled = false
                DataService.instance.uploadPost(withMessage: contentTextView.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                    if isComplete {
                        self.postBtn.isEnabled = false
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.postBtn.isEnabled = true
                        print("Error while posting")
                    }
                })
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
