//
//  MenuLeftTableViewController.swift
//  LiteUse
//
//  Created by Tran Anh on 8/3/16.
//  Copyright © 2016 Tran Anh. All rights reserved.
//

import UIKit

class MenuLeftTableViewController: UITableViewController {
    var myUser = User()

    @IBOutlet weak var ImageUser: UIImageView!

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showInformationOfUser()
        
    }
    
    func showInformationOfUser(){
        let tbc = self.tabBarController  as! TabBarController
        myUser = tbc.myUser
        userName.text = myUser.username
        emailUser.text = myUser.email
        
        
        let url = NSURL(string: myUser.imageUser!)
        
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error, terminator: "")
                return
            }
            
            let image = UIImage(data: data!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.ImageUser.image = image
            })
            
        }).resume()

        
        
      
        

    
    }
    
    
    @IBAction func LogoutUser(sender: AnyObject) {
        FBSDKLoginManager().logOut()
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    
    
}
