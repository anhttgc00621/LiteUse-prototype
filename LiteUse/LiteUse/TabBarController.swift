//
//  TabBarController.swift
//  LiteUse
//
//  Created by Tran Anh on 8/3/16.
//  Copyright © 2016 Tran Anh. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    let myUser = User()
    override func viewDidLoad() {
        self.selectedIndex = 1;
    }
}
