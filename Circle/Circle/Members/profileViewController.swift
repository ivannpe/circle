//
//  profileViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/28/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit
import Firebase
//api to customize user profile
import Alamofire
import AlamofireImage

class profileViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    @IBOutlet weak var majorLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    var groupsArray = [Group]()
    
    @IBOutlet weak var tableView: UITableView!
    /*
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "cell"*/
    
    var profilePictureTapGesture: UITapGestureRecognizer!
    var imagePickerController: UIImagePickerController!
    //var fullname: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //initializingProfile()
        tableView.delegate = self
        tableView.dataSource = self
        print("profile table view delegate called")
        self.tableView.reloadData()
        //tableView.estimatedRowHeight = UITableView.automaticDimension
        settingProfilePictureTapGesture()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializingProfile()
        
        //collectionView.delegate = self
        //collectionView.dataSource = self
        //retrieve all groups current user is a part of
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllProfileGroups { (groups) in
                self.groupsArray = groups
                self.tableView.reloadData()
                print(self.groupsArray)
            }
        }

    }
    //retrieve all relevant user information from database and display in labels
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
        //retrieves current user profile picture url from database
    DataService.instance.getCurrentUserProfilePicture(userUID: UserID!) { (imageURL) in
        guard let url = URL(string: imageURL) else { return }
        print("calling self.profilepic.af_setimage")
        self.profilePic.af_setImage(withURL: url)
    }

    }
    //sets up the gesture to recognize user profile picture tap
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
    //closes current user instance and returns to welcome screen
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let welcomePageViewController = storyboard?.instantiateViewController(withIdentifier: "WelcomePageViewController") as! WelcomeScreenViewController
        welcomePageViewController.modalPresentationStyle = .fullScreen
        self.present(welcomePageViewController, animated:true, completion:nil)
        
    }
    //sets the current profile picture for user with options to take a picture with camera or choose from photo library
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
    //allows user to pick image from photolibrary to save as profile picture
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
//image picker delegate to upload image file to Firebase storage
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
/*
extension profileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of rows in collection")
        return self.groupsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell for item at")
        print("call data service for groups")
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (groups) in
                for group in groups{
                    if !(self.groupsArray.contains(group.groupTitle)) {
                        self.groupsArray.append(group.groupTitle)
                    }
                    print(group.groupTitle)
                }
                print(self.groupsArray)
            }
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,for: indexPath as IndexPath) as! profileCollectionViewCell
        cell.collectionViewCellLabel.text = self.groupsArray[indexPath.item]
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /* put select collection cell code here
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedViewController") as? GroupFeedViewController else { return }
        print("didselectrowat function called in groups view controller")
        groupFeedVC.initData(group: groupsArray[indexPath.row])*/
        //to init group about page with proper group
        /*
        guard let aboutPageVC = storyboard?.instantiateViewController(withIdentifier: "AboutPageViewController") as? AboutPageViewController else { return }
        print("didselectrowat function called in groups view controller")
        aboutPageVC.initData(group: groupsArray[indexPath.row])
        */
        //presentDetail(groupFeedVC)
        //show(groupFeedVC, sender: AnyObject.self)
    }
}*/
//table view delegate to display all groups user is in
extension profileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.groupsArray.count)
        return self.groupsArray.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("profile group cell for row at called")
        print(self.groupsArray[indexPath.row].groupTitle)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileGroupTableViewCell") as? ProfileGroupTableViewCell {
            cell.configureCell(title: self.groupsArray[indexPath.row].groupTitle, isSelected: false)
            print(self.groupsArray[indexPath.row].groupTitle)
            return cell
        } else {
            return ProfileGroupTableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedViewController") as? GroupFeedViewController else { return }
        print("didselectrowat function called in profile controller")
        groupFeedVC.initData(group: self.groupsArray[indexPath.row])
        //to init group about page with proper group
        /*
        guard let aboutPageVC = storyboard?.instantiateViewController(withIdentifier: "AboutPageViewController") as? AboutPageViewController else { return }
        print("didselectrowat function called in groups view controller")
        aboutPageVC.initData(group: groupsArray[indexPath.row])
        */
        //presentDetail(groupFeedVC)
        show(groupFeedVC, sender: AnyObject.self)
    }
    // UITableViewAutomaticDimension calculates height of label contents/text
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("auto dimension called for height of rows")
        return UITableView.automaticDimension
    }*/
}

