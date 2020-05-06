//
//  LogInViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/27/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase
class LogInViewController: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var hiddenLabel: UILabel!
    override func viewDidLoad() {
        hiddenLabel.isHidden = true
        passwordLabel.isSecureTextEntry = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func fieldsfull()->Bool{
        let email = emailLabel.text
        let password = passwordLabel.text
        if email == "" || password == "" {
            hiddenLabel.isHidden = false
            hiddenLabel.text = "📩 fill all fields"
            return false
        }
        if email!.isValidEmail() == false{
            hiddenLabel.isHidden = false
            hiddenLabel.text = "📩 enter a valid email address"
            return false
        }
        return true
    }
     
    @IBAction func loginTapped(_ sender: Any) {
        if fieldsfull(){
            AuthService.instance.loginUser(withEmail: emailLabel.text!, withPassword: passwordLabel.text!, loginComplete: { (success, loginError) in
                if success {
                    //self.dismiss(animated: true, completion: nil)
                    print("Login Successful")
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
            })
        }
        //let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        //mainTabController.modalPresentationStyle = .fullScreen
        //present(mainTabController, animated: false, completion: nil)
        
        
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
