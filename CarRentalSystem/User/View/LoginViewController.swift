//
//  LoginViewController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 10/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//
import UIKit
import FCAlertView
import GoogleSignIn

let REGEX_USER_NAME = "[A-Za-z0-9]{3,10}"
let REGEX_EMAIL = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let REGEX_PASSWORD = "[A-Za-z0-9]{6,20}"
let REGEX_PHONE_DEFAULT = "[0-9]{10}"

class LoginViewController: UIViewController,userdelegate,FCAlertViewDelegate{
    
    @IBOutlet weak var btnClick: UIButton!
    @IBOutlet weak var txtUser_email: TextFieldValidator!
    @IBOutlet weak var txtUser_password: TextFieldValidator!
    override func viewDidLoad() {
        super.viewDidLoad()

        validationSetup()
        
        let gmail = GIDSignInButton()
        gmail.frame = CGRect(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height / 2 + 200, width: 200, height: 60)
        gmail.style = .wide
        gmail.colorScheme = .dark
        gmail.addTarget(self, action: #selector(self.googleAction), for: .touchUpInside)
        
        self.view.addSubview(gmail)
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        designControllls()
       
    }
    
    @objc func googleAction(sender : GIDSignInButton)
    {
        
    }
    // for design controllers
    func designControllls()
    {
        btnClick.layer.cornerRadius = 5
    }
    
// bottonButton Action "Don't have an account? Sign uP"
    @IBAction func LinkBtnAction(_ sender: Any) {
        
        //navigate to "Driver Registration"
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserRegistrationVC")
    }
    
    // MARK : func for set up validation
    func validationSetup()
    {
        txtUser_email.addRegx(REGEX_EMAIL, withMsg: "Email Id should be in 'abc@gmail.com' format")
        txtUser_email.presentInView = self.view
        
        txtUser_password.addRegx(REGEX_PASSWORD, withMsg: "Password must be between 6 to 20 character")
        txtUser_password.presentInView = self.view
    }
    
    func validation() -> Bool
    {
        if txtUser_email.validate() && txtUser_password.validate()
        {
            return true
        }
        else
        {
            return false
        }
    }

    
 // call delegate function
    func userLoginReturnResp(arr: [Any]) {
        
        if arr.count == 1
        {
            let dicData = arr[0] as? [String : Any]
            
            //get "id" from dicData
            let id = dicData!["user_id"] as? String
            
            
            
            // one time login with the help of USer default
            let userDF = UserDefaults.standard
            userDF.set(id, forKey: "user_id")
            
            let alert = FCAlertView()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
            alert.makeAlertTypeSuccess()
            alert.delegate = self
            alert.showAlert(inView: self, withTitle: "Login Information", withSubtitle: "Successfully Login", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
           
        }
    }
    
    // MARK : Error handleer
    func ErrorUser(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        alert.makeAlertTypeWarning()
        alert.delegate = self
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Something is wrong in login. Please insert valid Email-ID and Password.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
        
    }
    
    // FcAlertview done button action login successfull
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
        // navigate to "User Tabbar (Home Page)"
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserTabbar")
        
    }
    
    //MARK : func for log IN
    func UserLogin()
    {
        let userObj = UserController()
        userObj.delegate = self
        
        let userLoginModel = usermodel(user_email: txtUser_email.text!, user_password: txtUser_password.text!)
        
        userObj.userLogin(userModel: userLoginModel)
    }
    
    func Error(arr: [Any]) {
        
        print(arr)
        alert.commonAlert(Msg: "\(arr) LOGIN FAILED", uiVC: self)
    }
    
// upper Back Button action
    @IBAction func BackAction(_ sender: Any) {
        
        // navigate to back view controller
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    

    
    // log in action
    @IBAction func LogInCLick(_ sender: UIButton) {
        
        if validation()
        {
            sender.pluseAnimation()
            UserLogin()
        }
        else
        {
            print("Enter proper data.")
        }
       
    }
    
}


/*
 
 //create function for one time login using create plist file
 func CreatePlistFunc(mainArr : [Any])
 {
 let path1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
 
 let path2 = path1[0]
 
 let finalPath = path2.appending("/profile.plist");
 let fmg = FileManager()
 
 print(finalPath)
 if !fmg.fileExists(atPath: finalPath)
 {
 let tempDic = NSArray(array: mainArr)
 print(tempDic)
 tempDic.write(toFile: finalPath, atomically: true)
 }
 
 
 }
 */

