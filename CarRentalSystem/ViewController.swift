//
//  ViewController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 09/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import GoogleSignIn

// create an object of "CommonNavigationFunc" for navigate
let navigateObj = CommonNavigationFunc()

// create an object of "CommonAlert"
let alert = CommonAlert()

// create an object of commonURL class
let commConst = CommonURL()


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        let userDF = UserDefaults.standard
        let Uservalue = userDF.value(forKey: "user_id") as? String
       
        let spDF = UserDefaults.standard
        let Spvalue = spDF.value(forKey: "sp_id") as? String
        
        let driverDF = UserDefaults.standard
        let Dvalue = driverDF.value(forKey: "driver_id") as? String

        if Uservalue == nil && Spvalue == nil && Dvalue == nil
        {
            navigateTohomePage()
        }
        else
        {
            if (Uservalue != nil)
            {
                navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserTabbar")
            }
            else if (Spvalue != nil)
            {
                navigateObj.navigationCommonPush(uiViewController: self, identifier: "SpTabbar")
            }
            else if (Dvalue != nil)
            {
                navigateObj.navigationCommonPush(uiViewController: self, identifier: "Driver_Tabbar")
            }
        }
        
        /*
        if checkplist()
        {
            navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserTabbar")
        }
        else
        {
            navigateTohomePage()
        }
 */
        
    }
    
    /*
 // function for Check Plist
    func checkplist() -> Bool
    {
        let path1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let path2 = path1[0]
        
        let finalPath = path2.appending("/profile.plist");
        let fmg = FileManager()
        
        print(finalPath)
        
        if fmg.fileExists(atPath: finalPath)
        {
            return true
        }
        else
        {
            return false
        }
    }
 */
/*
// for hide navigationbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
 */
    
// Splash Screen
// Navigate to HomeViewController
    func navigateTohomePage()
    {
        // create timer for splash screen
        
        let time = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.navigateTohome), userInfo: nil, repeats: false)
    }
    
// objc method
    @objc func navigateTohome(sender : Timer)
    {
        // Automatically sign in the user.
       // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        // here we use "navigationCommonPush" func with the help of "navifateObj" for navigation
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "HomeViewController")
    }
    
    
    /*
     // for un hide navigationbar
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
 */

    
}

