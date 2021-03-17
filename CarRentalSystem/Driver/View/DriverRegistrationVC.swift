//
//  DriverRegistrationVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 10/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView

class DriverRegistrationVC: UIViewController,Driverdelegate,FCAlertViewDelegate {
    @IBOutlet weak var txtdriver_name: TextFieldValidator!
    
    @IBOutlet weak var txtdriver_address: TextFieldValidator!
    @IBOutlet weak var txtdriver_email: TextFieldValidator!
    @IBOutlet weak var txtdriver_password: TextFieldValidator!
    
    @IBOutlet weak var txtdriver_mob: TextFieldValidator!
    @IBOutlet weak var signUpBtn: UIButton!
    
    // lable for driver status
    let status = "Not verify"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designControlles()
        validationSetup()
        
    }
    func designControlles()
    {
        signUpBtn.layer.cornerRadius = 5
    }
    // MARK : validation
    func validationSetup()
    {
        txtdriver_name.addRegx(REGEX_USER_NAME, withMsg: "UserName must be between 3 to 10 character")
        txtdriver_name.presentInView = self.view
        
        txtdriver_password.addRegx(REGEX_PASSWORD, withMsg: "Password must be between 6 to 20 character")
        txtdriver_password.presentInView = self.view
        
        txtdriver_email.addRegx(REGEX_EMAIL, withMsg: "Email Id should be in 'abc@gmail.com' format")
        txtdriver_email.presentInView = self.view
        
        txtdriver_mob.addRegx(REGEX_PHONE_DEFAULT, withMsg: "Mobile No must be in 10 digit")
        txtdriver_mob.presentInView = self.view
    }
    func validation() -> Bool
    {
        if txtdriver_name.validate() && txtdriver_password.validate() && txtdriver_email.validate() && txtdriver_mob.validate()
        {
            return true
        }
        else
        {
            return false
        }
    }
    // delegate function calling
    
    func DriverReturnResponse(arr: [Any]) {
        
        print(arr);
        
        let dic = arr[0] as? [String:Any];
        
        let status  = dic!["status"] as? String;
        
        if status  == "success" {
            
            print("record inserted success fully");
            
            //alert box
            
            let alert = FCAlertView()
            alert.delegate = self
            alert.makeAlertTypeSuccess()
            alert.blurBackground = true
            alert.showAlert(inView: self, withTitle: "Register with us!", withSubtitle: "Successfully Registered.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            
            
        }
    }
    
    // MARK : error handler
    func ErrorDriver(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.delegate = self
        alert.makeAlertTypeWarning()
        alert.blurBackground = true
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Something went wrong in registration.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
        
    }
    
    // delegete function of alert view of done button click
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "DriverLoginVC")
    }
    func DriverRegistration()
    {
        
        let defualtImg = UIImageView(image: UIImage(imageLiteralResourceName: "user2x"))
        let baseData = defualtImg.image?.jpegData(compressionQuality: 2.0)
        let base64Str = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        print(base64Str!)
        
        let driverRegObj = DriverController()
        driverRegObj.delegate = self
        
        
        let driverRegModel = Drivermodel(driver_id: 101, driver_name: txtdriver_name.text!, driver_address: txtdriver_address.text!, driver_email: txtdriver_email.text!, driver_password: txtdriver_password.text!, driver_mob: txtdriver_mob.text!,driver_status:status, driver_profilepic: base64Str!)
        
        driverRegObj.DriverRegistration(driverModel: driverRegModel)
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        
        if validation()
        {
            sender.pluseAnimation()
            DriverRegistration()
        }
        else
        {
            print("Error")
        }
        
    }
    
    @IBAction func bottomBtnAction(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "DriverLoginVC")
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)

    }
    
    @IBAction func homeAction(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "HomeViewController")
    }
}
