//
//  profileViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/28/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import AlamofireImage

class profileViewController: UIViewController {


    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var majorLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    var profilePictureTapGesture: UITapGestureRecognizer!
    var imagePickerController: UIImagePickerController!
    //var fullname: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //initializingProfile()
        settingProfilePictureTapGesture()
        
        // Do any additional setup after loading the view.
//        let ref = Database.database().reference().child("users")
//        let UserID = Auth.auth().currentUser?.uid
//        print(UserID!)
//
//        ref.child(UserID ?? "").observeSingleEvent(of: .value, with: { (snapshot) in
//            if !snapshot.exists() {
//                print("snapshot failed")
//                return }
//            print(snapshot)
//            print(snapshot.value as Any)
//
//            //to make full name label retrieve from database
//            let fullname = snapshot.childSnapshot(forPath: "fullname").value
//            print(fullname!)
//            self.fullNameLabel.text = ((fullname!) as! String)
//
//            //to make username label retrieve from database
//            let username = snapshot.childSnapshot(forPath: "username").value
//            print(username!)
//            self.usernameLabel.text = "@" + ((username!) as! String)
//
//            //to make full name label retrieve from database
//            let school = snapshot.childSnapshot(forPath: "school").value
//            print(school!)
//            self.schoolLabel.text = ((school!) as! String)
//
//            //to make major label retrieve from database
//            let major = snapshot.childSnapshot(forPath: "major").value
//            print(major!)
//            self.majorLabel.text = ((major!) as! String)
//
//            //to make year label retrieve from database
//            let year = snapshot.childSnapshot(forPath: "year").value
//            print(year!)
//            self.yearLabel.text = "Class of " + ((year!) as! String)
//        })
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializingProfile()
    }
    func initializingProfile() {
        let ref = Database.database().reference().child("users")
        let UserID = Auth.auth().currentUser?.uid
        print(UserID!)

        ref.child(UserID ?? "").observeSingleEvent(of: .value, with: { (snapshot) in
        if !snapshot.exists() {
            print("snapshot failed")
            return }
        print(snapshot)
        print(snapshot.value as Any)
        
        //to make full name label retrieve from database
        let fullname = snapshot.childSnapshot(forPath: "fullname").value
        print(fullname!)
        self.fullNameLabel.text = ((fullname!) as! String)
        
        //to make username label retrieve from database
        let username = snapshot.childSnapshot(forPath: "username").value
        print(username!)
        self.usernameLabel.text = "@" + ((username!) as! String)
        
        //to make full name label retrieve from database
        let school = snapshot.childSnapshot(forPath: "school").value
        print(school!)
        self.schoolLabel.text = ((school!) as! String)
        
        //to make major label retrieve from database
        let major = snapshot.childSnapshot(forPath: "major").value
        print(major!)
        self.majorLabel.text = ((major!) as! String)
        
        //to make year label retrieve from database
        let year = snapshot.childSnapshot(forPath: "year").value
        print(year!)
        self.yearLabel.text = "Class of " + ((year!) as! String)
    })
    DataService.instance.getCurrentUserProfilePicture(userUID: UserID!) { (imageURL) in
        guard let url = URL(string: imageURL) else { return }
        print("calling self.profilepic.af_setimage")
        self.profilePic.af_setImage(withURL: url)
    }
    }
    func settingProfilePictureTapGesture() {
        print("settingprofilepicturetapgesture called")
        //Creating Gesture for Profile Pic ImageView
        profilePictureTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileViewController.setProfilePicture))
        profilePictureTapGesture.numberOfTapsRequired = 1
        profilePictureTapGesture.numberOfTouchesRequired = 1
        
        //Adding gesture for ImageView
        profilePic.addGestureRecognizer(profilePictureTapGesture)
        profilePic.isUserInteractionEnabled = true
        print("IMAGE TAPPED");
    }
    
    //MARK: - Adding Profile Pictures
    @objc func setProfilePicture() {
        print("set profile pic() called")
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePictureAction = UIAlertAction(title: "Take Picture", style: .default) { (alertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePickerControllerWithSourceType(.camera)
            } else {
                print("Device has no camera")
            }
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (alertAction) in
            self.imagePickerControllerWithSourceType(.photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertSheet.addAction(takePictureAction)
        alertSheet.addAction(photoLibraryAction)
        alertSheet.addAction(cancelAction)
        present(alertSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerWithSourceType(_ imagePickerSourceType: UIImagePickerController.SourceType) {
        print("imagePickerControllerWithSourceType called")
        if imagePickerSourceType == .camera || imagePickerSourceType == .photoLibrary {
            imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            print("delegate called for")
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = imagePickerSourceType
            present(imagePickerController, animated: true, completion: nil)
            //imagePickerController.delegate = self
            print("present imagepickercontroller")
        } else {
            print("Device has no camera")
        }
    }
}

extension profileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imagePickerController called")
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        print("self.profilePic setting to pickedImage")
        self.profilePic.image = pickedImage
        self.profilePic.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
        StorageService(image: pickedImage).saveProfileImage((Auth.auth().currentUser?.uid)!) { (success, error) in
            if success {
                print("Image uploaded to Firebase Storage")
            } else {
                print("Failed to upload image to Firebase Storage",error?.localizedDescription as Any)
                let alert = UIAlertController(title: "Failed to upload image", message: "\(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
                    self.profilePic.image = UIImage(named: "defaultProfileImage.png")
                    self.profilePic.contentMode = .scaleAspectFit
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss(animated: true, completion: nil)
    //}
}


    

