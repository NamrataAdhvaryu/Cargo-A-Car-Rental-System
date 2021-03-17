//
//  UserRegistrationVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 10/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView



class UserRegistrationVC: UIViewController,userdelegate,FCAlertViewDelegate {

    
    // outlet of controlles
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var txtuser_name: TextFieldValidator!
    @IBOutlet weak var txtuser_address: TextFieldValidator!
    @IBOutlet weak var txtuser_email: TextFieldValidator!
    @IBOutlet weak var txtuser_password: TextFieldValidator!
    @IBOutlet weak var txtuser_mob: TextFieldValidator!
    @IBOutlet weak var txtuser_city: TextFieldValidator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       validationSetup()
        designControlles()
    }
// Function for design Controllers
    func designControlles()
    {
        signUpBtn.layer.cornerRadius = 5
    }
    // MARK : func for validation
    func validationSetup()
    {
        txtuser_name.addRegx(REGEX_USER_NAME, withMsg: "UserName must be between 3 to 10 character")
        txtuser_name.presentInView = self.view
        
        txtuser_password.addRegx(REGEX_PASSWORD, withMsg: "Password must be between 6 to 20 character")
        txtuser_password.presentInView = self.view
        
        txtuser_email.addRegx(REGEX_EMAIL, withMsg: "Email Id should be in 'abc@gmail.com' format")
        txtuser_email.presentInView = self.view
        
        txtuser_mob.addRegx(REGEX_PHONE_DEFAULT, withMsg: "Mobile No must be in 10 digit")
        txtuser_mob.presentInView = self.view
    }
    
    func validation() -> Bool
    {
        if txtuser_name.validate() && txtuser_password.validate() && txtuser_email.validate() && txtuser_mob.validate()
        {
            return true
        }
        else
        {
            return false
        }
    }
    
 // call delegate function
    func userReturnResponse(arr: [Any]) {
        
        let dic = arr[0] as? [String : Any]
        let status = dic!["status"] as? String
        
        if status == "success"
        {
            print(arr)
            print("Record insert")
            
            
            let alert = FCAlertView()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
            alert.makeAlertTypeSuccess()
            alert.delegate = self
            alert.showAlert(inView: self, withTitle: "Register with us!", withSubtitle: "Successfully Registered.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            
        }
    }
    
    // Fcalertview delegate function of done button clicked
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
         navigateObj.navigationCommonPush(uiViewController: self, identifier: "LoginViewController")
        
    }
    
    // MARK : error handle
    func ErrorUser(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        alert.makeAlertTypeWarning()
        alert.delegate = self
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Something is wrong in Registration.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
    }
    
// function for UserRegistration
    func userRegistration()
    {
        let defualtImg = UIImageView(image: UIImage(imageLiteralResourceName: "user2x"))
        let baseData = defualtImg.image?.jpegData(compressionQuality: 2.0)
        let base64Str = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
       // print(base64Str!)
        
        let userRegObj = UserController()
        
        userRegObj.delegate = self
        
        
        let userRegModel = usermodel(user_id: 101, user_name: txtuser_name.text!, user_address: txtuser_address.text!, user_email: txtuser_email.text!, user_password: txtuser_password.text!, user_city: txtuser_city.text!, user_mob: txtuser_mob.text!,user_profilepic: base64Str!)
            
            
        userRegObj.userRegistration(userModel: userRegModel)
    }
    @IBAction func SignUpClickAction(_ sender: Any) {
        
        if validation()
        {
            userRegistration()
            print("Submit successfully")
        }
        else
        {
            print(("Error"))
        }
        
        
    }
    @IBAction func BottomBtnAction(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "LoginViewController")
    }
    @IBAction func backAction(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    
    }
    @IBAction func homeAction(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "HomeViewController")

    }
  
    
    
   
}
