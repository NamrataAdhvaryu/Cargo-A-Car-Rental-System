//
//  ServiceProviderLoginVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 11/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView
import GoogleSignIn

class ServiceProviderLoginVC: UIViewController,spdelegate,FCAlertViewDelegate {


    @IBOutlet weak var txtSp_password: TextFieldValidator!
    @IBOutlet weak var txtSp_email: TextFieldValidator!
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
    
    // MARK : function for validadtion
    func validationSetup()
    {
        txtSp_password.addRegx(REGEX_PASSWORD, withMsg: "Password must be between 6 to 20 character")
        txtSp_password.presentInView = self.view
        
        txtSp_email.addRegx(REGEX_EMAIL, withMsg: "Email Id should be in 'abc@gmail.com' format")
        txtSp_email.presentInView = self.view
    }
    
    func validation() -> Bool
    {
        if txtSp_password.validate() && txtSp_email.validate()
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    // call sp delegate function
    func spLoginReturnResp(arr: [Any]) {
        
        if arr.count == 1
        {
            let dicData = arr[0] as? [String:Any]
            
            let id = dicData!["sp_id"] as? String
            
            let spDF = UserDefaults.standard
            spDF.set(id, forKey: "sp_id")
            
            // alert box
            
            let alert = FCAlertView()
            alert.delegate = self
            alert.blurBackground = true
            
            alert.makeAlertTypeSuccess()
            alert.showAlert(inView: self, withTitle: "Login Information", withSubtitle: "Successfully Log In.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            
        }
        
    }
    
    // MARK : eeror handler
    func ErrorSP(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.delegate = self
        alert.blurBackground = true
        
        alert.makeAlertTypeWarning()
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Something went wrong in login. Invalid Email-ID and Password.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
        
    }
    
    // delegate function of done button clicked
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "SpTabbar")
    }
    
    func SpLogin()
    {
        let spObj = spController()
        spObj.delegate = self
        
        let spLoginModel = spmodel(sp_email: txtSp_email.text!, sp_password: txtSp_password.text!)
        
        spObj.splogin(spModel: spLoginModel)
     
    }
    @IBAction func logInBTNaction(_ sender: Any) {
        
        if validation()
        {
            SpLogin()
        }
        else
        {
            print("Error")
        }
    }
    @IBAction func bottomBtnAction(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "SPRegistrationVC")
    }
    @IBAction func backAction(_ sender: Any) {
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "HomeViewController")
    }
    
    @IBAction func homeAction(_ sender: Any) {
        
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(stb!, animated: true)
    }
}
