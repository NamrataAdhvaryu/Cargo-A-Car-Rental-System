
//
//  DriverLoginVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 11/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView
import GoogleSignIn

class DriverLoginVC: UIViewController,Driverdelegate,FCAlertViewDelegate {

    @IBOutlet weak var txtdriver_email: TextFieldValidator!
    @IBOutlet weak var txtdriver_password: TextFieldValidator!
    @IBOutlet weak var logInOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gmail = GIDSignInButton()
        gmail.frame = CGRect(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height / 2 + 200, width: 200, height: 60)
        gmail.style = .wide
        gmail.colorScheme = .dark
        
        self.view.addSubview(gmail)
        
        designControllls()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        designControllls()
        validationSetup()
    }
    func designControllls()
    {
        logInOutlet.layer.cornerRadius = 5
    }
    
    // MARK : validation
    func validationSetup()
    {
        txtdriver_password.addRegx(REGEX_PASSWORD, withMsg: "Password must be between 6 to 20 character")
        txtdriver_password.presentInView = self.view
        
        txtdriver_email.addRegx(REGEX_EMAIL, withMsg: "Email Id should be in 'abc@gmail.com' format")
        txtdriver_email.presentInView = self.view
    }
    func validation() -> Bool
    {
        if txtdriver_password.validate() && txtdriver_email.validate()
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    // delegate function
    func DriverLoginReturnResponse(arr: [Any]) {
        
        if arr.count == 1
        {
            let dataDic = arr[0] as! [String : Any]
            let id = dataDic["driver_id"] as? String
            
            let driverDF = UserDefaults.standard
            driverDF.set(id, forKey: "driver_id")
            
            //alert box
            
            let alert = FCAlertView()
            alert.delegate = self
            alert.makeAlertTypeSuccess()
            alert.blurBackground = true
            alert.showAlert(inView: self, withTitle: "Login Information", withSubtitle: "Successfully Log In", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            
            
        }
        
    }
    // MARK : error handler
    func ErrorDriver(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.delegate = self
        alert.makeAlertTypeSuccess()
        alert.blurBackground = true
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Somwthing went wrong in login. Invalid Email-ID and Password.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
    }
    
    // delegate function of Fcalertview "Done button click"
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Driver_Tabbar")
    }
    func DriverLogin()
    {
        let driverObj = DriverController()
        driverObj.delegate = self
        
        let DriverLoginObj = Drivermodel(driver_email: txtdriver_email.text!, driver_password: txtdriver_password.text!)
        
        driverObj.DriverLogin(driverModel: DriverLoginObj)
        
    }
    @IBAction func logInBTNAction(_ sender: UIButton) {
        
        if validation()
        {
            sender.pluseAnimation()
            DriverLogin()
        }
        else
        {
            print("Error")
        }
        
    }
    
    @IBAction func bottomBtnAction(_ sender: Any) {
     
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "DriverRegistrationVC")

    }
    
    @IBAction func backAction(_ sender: Any) {
        
       navigateObj.navigationCommonPop(uiViewController: self)
    }
    
}
