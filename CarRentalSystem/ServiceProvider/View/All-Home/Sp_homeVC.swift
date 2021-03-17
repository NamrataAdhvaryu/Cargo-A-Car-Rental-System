//
//  Sp_homeVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 22/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class Sp_homeVC: UIViewController {

    @IBOutlet weak var titleBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       designCOntrol()
    }
    
    func designCOntrol()
    {
        titleBTN.layer.cornerRadius = 10
        titleBTN.clipsToBounds = true
    }
    
}
