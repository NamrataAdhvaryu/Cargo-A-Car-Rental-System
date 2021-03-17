//
//  UserTabbarContollerVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 11/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class UserTabbarContollerVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedViewController = viewControllers![1]
    }
    

}
