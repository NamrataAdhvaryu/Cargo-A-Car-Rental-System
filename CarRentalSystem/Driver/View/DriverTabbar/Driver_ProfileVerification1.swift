//
//  Driver_ProfileVerification1.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 20/07/20.
//  Copyright © 2020 Namrata AkashKhushbu. All rights reserved.
//

import UIKit

class Driver_ProfileVerification1: UIViewController {

    @IBOutlet weak var licenceLbl: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var disbilityLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.hidesBottomBarWhenPushed = true
        
        design()
        // Do any additional setup after loading the view.
    }

    func design()
    {
        licenceLbl.layer.cornerRadius = 10
        licenceLbl.clipsToBounds = true
        
    disbilityLbl.layer.cornerRadius = 10
        disbilityLbl.clipsToBounds = true
        
        verifyBtn.layer.cornerRadius = 10
        verifyBtn.clipsToBounds = true
    }
    
    @IBAction func backIconClick(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
    @IBAction func verifyBtnClick(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Driver_ProfileVerification2")
    }
}
