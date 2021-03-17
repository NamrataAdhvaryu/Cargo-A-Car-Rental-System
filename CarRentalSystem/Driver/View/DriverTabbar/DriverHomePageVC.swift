//
//  DriverHomePageVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 18/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class DriverHomePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LogoutClick(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "driver_id")
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "HomeViewController")
    }
}
