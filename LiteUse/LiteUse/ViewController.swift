//
//  ViewController.swift
//  LiteUse
//
//  Created by Tran Anh on 8/2/16.
//  Copyright © 2016 Tran Anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    var myUser = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfile()
        

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "loginCompleted") {
            let tbc = segue.destinationViewController as! TabBarController;
            myUser = tbc.myUser
            
        }
    }
    
    func fetchProfile(){
        if let _ = FBSDKAccessToken.currentAccessToken() {
            
            let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
            FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler({ (connection, user, requestError) -> Void in
                
                if requestError != nil {
                    print(requestError)
                    return
                }
                
                var _ = user?["email"] as? String
                let firstName = user?["first_name"] as? String
                let lastName = user?["last_name"] as? String
                
                self.myUser.username = "\(firstName!) \(lastName!)"
                
                
                if let picture = user?["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
                    self.myUser.imageUser = url
                    
                }
                self.myUser.email = user?["email"] as? String
                
                
            })
            dispatch_async(dispatch_get_main_queue(),{
                self.performSegueWithIdentifier("loginCompleted", sender: nil)

            })
            
        }
    

    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("login completed", terminator: "")
        self.performSegueWithIdentifier("loginCompleted", sender: nil)

    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
   
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    @IBAction func loginButton(sender: AnyObject) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.loginBehavior = FBSDKLoginBehavior.Web
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self, handler: { (result, error) -> Void in
            
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                
                if(fbloginresult.isCancelled) {
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    self.fetchProfile()
                }
            }
        })
        
        
        
            }
  
    
   


}

