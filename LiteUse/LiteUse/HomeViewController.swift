//
//  HomeViewController.swift
//  LiteUse
//
//  Created by Tran Anh on 8/3/16.
//  Copyright © 2016 Tran Anh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var myUser = User()

    @IBOutlet weak var menuleft: UIBarButtonItem!
    @IBOutlet weak var menuRight: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Mark: Menu siderbar
        menuSlidebar()
        let tbc = self.tabBarController  as! TabBarController
        myUser = tbc.myUser

    }
    
    func menuSlidebar(){
        if self.revealViewController() != nil {
            
            menuleft.target = self.revealViewController()
            menuleft.action = #selector(SWRevealViewController.revealToggle(_:))
            self.revealViewController().rearViewRevealWidth = 310
            
            
            revealViewController().rightViewRevealWidth = 310
            menuRight.target = revealViewController()
            menuRight.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    
    }
    
    
}
