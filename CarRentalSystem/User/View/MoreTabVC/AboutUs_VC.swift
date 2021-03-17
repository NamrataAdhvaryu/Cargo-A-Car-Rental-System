//
//  AboutUs_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 06/09/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class AboutUs_VC: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
    }
    
    // MARK : func for design
    func design()
    {
        view1.layer.cornerRadius = 15
        view1.clipsToBounds = true
        
        view2.layer.cornerRadius = 15
        view2.clipsToBounds = true
        
        view3.layer.cornerRadius = 15
        view3.clipsToBounds = true
    }
    @IBAction func backBtn(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
