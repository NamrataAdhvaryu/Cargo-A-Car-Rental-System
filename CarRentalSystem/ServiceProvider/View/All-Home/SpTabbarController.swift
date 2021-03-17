//
//  SpTabbarController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 13/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class SpTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedViewController = viewControllers![1]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
