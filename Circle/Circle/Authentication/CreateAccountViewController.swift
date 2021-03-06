//
//  CreateAccountViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/27/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//
//this is the view controller code for the initial welcome page view where it prompts the user to sign up or log in


import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var universityLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var schoolLabel: UITextField!
    @IBOutlet weak var majorLabel: UITextField!
    @IBOutlet weak var yearLabel: UITextField!
    @IBOutlet weak var hiddenLabel: UILabel!
    var cantReg = true
    override func viewDidLoad() {
        hiddenLabel.isHidden = true
        passwordLabel.isSecureTextEntry = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //check if email is valid

    //ensure fields are full and email is valid
    func fieldsfull()->Bool{
        let university = universityLabel.text
        let email = emailLabel.text
        let name = nameLabel.text
        let username = usernameLabel.text
        let password = passwordLabel.text
        let school = schoolLabel.text
        let major = majorLabel.text
        let year = yearLabel.text
        if university == "" || email == "" || name == "" || username == "" || password == "" || school == "" || major == "" || year == "" {
            hiddenLabel.isHidden = false
            hiddenLabel.text = "📩 fill all fields"
            return false
        }
        //calls function in string extension to ensure it is an nyu email
        if email!.isValidEmail() == false{
            hiddenLabel.isHidden = false
            hiddenLabel.text = "📩 enter a valid email address"
            return false
        }
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if fieldsfull() == true && self.cantReg != true{
            return true
        }
        else {
            return false
        }
    }
    @IBAction func signUpTapped(_ sender: Any) {
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        mainTabController.modalPresentationStyle = .fullScreen
        if fieldsfull(){
            //instantiates a new user with Firebase authentication
            AuthService.instance.loginUser(withEmail: emailLabel.text!, withPassword: passwordLabel.text!, loginComplete: { (success, loginError) in
                if success {
                    //self.dismiss(animated: true, completion: nil)
                    print("success: fields full")
                    self.performSegue(withIdentifier: "signupSegue", sender: AnyObject.self)
                    self.cantReg = false
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
                //registers user with different profile categories
                AuthService.instance.registerUser(withUniversity:self.universityLabel.text!, withEmail:self.emailLabel.text!, withFullName:self.nameLabel.text!, withUsername:self.usernameLabel.text!,withPassword:self.passwordLabel.text!, withSchool:self.schoolLabel.text!, withMajor:self.majorLabel.text!, withYear:self.yearLabel.text!, userCreationComplete: { (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailLabel.text!, withPassword: self.passwordLabel.text!, loginComplete: { (success, nil) in
                            //self.dismiss(animated: true, completion: nil)
                            //self.present(mainTabController, animated: false, completion: nil)
                            print("Successfully registered user")
                            //only performs segue if user is successfully registered
                            self.performSegue(withIdentifier: "signupSegue", sender: AnyObject.self)
                            self.cantReg = false
                            print(self.cantReg)
                        })
                        //display firebase error if unsuccessful
                    } else {
                        print(String(describing: registrationError?.localizedDescription))
                        self.hiddenLabel.isHidden = false
                        self.hiddenLabel.text = String(describing:registrationError?.localizedDescription)
                        self.cantReg = true
                        print(self.cantReg)
                    }
                })
            })
        }

//        mainTabController.modalPresentationStyle = .fullScreen
//        present(mainTabController, animated: false, completion: nil)
        
        
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
