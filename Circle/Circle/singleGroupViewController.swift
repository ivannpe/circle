//
//  singleGroupViewController.swift
//  Circle
//
//  Created by Leena Loo on 4/28/20.
//  Copyright © 2020 Ivanna Peña and Leena Loo. All rights reserved.
//

import UIKit

class singleGroupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        let groupPostsView = storyboard?.instantiateViewController(withIdentifier: "groupPosts") as! groupPostViewController
        let groupMembersView = storyboard?.instantiateViewController(withIdentifier: "groupMembers") as! groupMembersViewController
        let groupAboutView = storyboard?.instantiateViewController(withIdentifier: "groupAbout") as! groupAboutViewController

        
        //mainTabController.modalPresentationStyle = .fullScreen
        //present(mainTabController, animated: false, completion: nil)
        /*let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        mainTabController.modalPresentationStyle = .fullScreen
        present(mainTabController, animated: false, completion: nil)

        /*
        viewContainer.addSubview(groupPostsView)
        viewContainer.addSubview(groupMembersView)
        viewContainer.addSubview(groupAboutView)

        
    }
    func displayContentPosts(_ sender: UIViewController){

        addChild(groupPostsView)
        viewContainer.addSubview(groupPostViewController().view)
        didMove(toParent: self)
    
    }
    func displayContentMembers(_ sender: UIViewController){


        addChild(groupMembersView)
        viewContainer.addSubview(groupMembersViewController().view)
        didMove(toParent: self)
    
    }
    func displayContentAbout(_ sender: UIViewController){
        addChild(groupAboutView)
        viewContainer.addSubview(groupAboutViewController().view)
        didMove(toParent: self)
         
         

    
}*/*/
    }
    

        func groupSegControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        
        case 0:
            present(groupPostsView, animated: false, completion: nil)
            break
        case 1:
            present(groupMembersView, animated: false, completion: nil)
            break
        case 2:
                        present(groupAboutView, animated: false, completion: nil)
            break
        default:
            break
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */*/


}
}
