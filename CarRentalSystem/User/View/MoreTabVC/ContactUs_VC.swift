//
//  ContactUs_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 06/09/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class ContactUs_VC: UIViewController {
   
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mailImg: UIImageView!
    @IBOutlet weak var contactUsLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        tap()
        // Do any additional setup after loading the view.
    }
    func design()
    {
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
    }
    
    // MARK : tap gesture
    func tap()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        tap.numberOfTapsRequired = 1
        mainView.isUserInteractionEnabled = true
        mailImg.isUserInteractionEnabled = true
        contactUsLbl.isUserInteractionEnabled = true
        mailImg.addGestureRecognizer(tap)
        mainView.addGestureRecognizer(tap)
        contactUsLbl.addGestureRecognizer(tap)
        
    }
    
    // MARK : objc method of tap action
    @objc func tapAction(sender : UITapGestureRecognizer)
    {
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Suggestion_VC")
    }
    

    @IBAction func back(_ sender: Any) {
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
