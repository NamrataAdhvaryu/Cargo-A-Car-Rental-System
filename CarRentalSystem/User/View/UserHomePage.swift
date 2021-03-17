//
//  UserHomePage.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 15/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import ImageSlideshow

class UserHomePage: UIViewController {

    @IBOutlet weak var userView1: ImageSlideshow!
    
    @IBOutlet weak var userView2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        userView2.layer.cornerRadius = 30
        userView2.clipsToBounds = true
        imageSlideShow()
        //viewCar()
        // Do any additional setup after loading the view.
    }
    
    func imageSlideShow()
    {
        userView1.setImageInputs([
            ImageSource(image: UIImage(named: "home1.jpeg")!),
            ImageSource(image: UIImage(named: "home2.jpeg")!),
            ImageSource(image: UIImage(named: "home3.jpeg")!),
            ImageSource(image: UIImage(named: "home4.jpeg")!)
            ])
        
        // interval time
        userView1.slideshowInterval = 1.5
    }
    @IBAction func searchBtn(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserBookVC")
    }
}

