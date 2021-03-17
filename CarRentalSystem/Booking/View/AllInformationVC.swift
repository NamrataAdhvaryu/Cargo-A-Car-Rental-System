//
//  CheckOutVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 09/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class AllInformationVC: UIViewController {

    @IBOutlet weak var imgViewBook: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        navigateToViewBooking()
        // Do any additional setup after loading the view.
    }
    
    // MARK : design
    func design()
    {
        imgViewBook.layer.cornerRadius = imgViewBook.frame.size.width / 2
    }
    
    func navigateToViewBooking()
    {
        // create timer for splash screen
        
        let time = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.viewBooking), userInfo: nil, repeats: false)
    }
    
    // objc method
    @objc func viewBooking(sender : Timer)
    {
       navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserTabbar")
    }
    


}
