//
//  Driver_Tabbar.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 14/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class Driver_Tabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedViewController = viewControllers![1]
        // Do any additional setup after loading the view.
    }
    

}
