//
//  Setting_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 06/09/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class Setting_VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        navigateObj.navigationCommonPop(uiViewController: self)
    }

}
