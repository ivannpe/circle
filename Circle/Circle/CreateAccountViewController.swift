//
//  CreateAccountViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/27/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//
//this is the view controller code for the initial welcome page view where it prompts the user to sign up or log in


import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        present(mainTabController, animated: false, completion: nil)
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
