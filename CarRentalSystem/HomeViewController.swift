//
//  HomeViewController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 09/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView
import GoogleSignIn

class HomeViewController: UIViewController,GIDSignInDelegate {

// Outlet of Controlles
    @IBOutlet weak var loginBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designContollers()
        gmailBtn()
    }
    
    func gmailBtn()
    {
        let gmail = GIDSignInButton()
        gmail.frame = CGRect(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height / 2 + 200, width: 200, height: 60)
        gmail.style = .wide
        gmail.colorScheme = .dark
        gmail.addTarget(self, action: #selector(self.googleAction), for: .touchUpInside)
        
        self.view.addSubview(gmail)
    }
    
    @objc func googleAction(sender : GIDSignInButton )
    {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // automatically sign in
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("We have error sign in user == \(error.localizedDescription)")
        } else {
            if let error = error
            {
                print("We have error sign in user == \(error.localizedDescription)")
            }
            else
            {
                if let gmailUser = user {
                    
                     let fullName = gmailUser.profile.name
                    let email = gmailUser.profile.email
                    
                    print(fullName as Any)
                    print(email as Any)
                    
                    if let imageUrl = gmailUser.profile.imageURL(withDimension: 200)
                    {
                        do
                        {
                            let data = try Data(contentsOf: imageUrl)
                            
                            let imageStr = UIImage(data: data)
                            let baseData = imageStr?.jpegData(compressionQuality: 2.0)
                            let base64 = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
                            print(baseData!)
                            
                            let userDetail = UserController()
                            userDetail.delegate = self as? userdelegate
                            
                            let body = usermodel(user_id:101, user_name: fullName!, user_address: "nil", user_email: email!, user_password: "nil", user_city: "nil", user_mob: "nil", user_profilepic: base64!)
                            
                            userDetail.userRegistration(userModel: body)
                            
                        }
                        catch
                        {
                            print(error.localizedDescription)
                        }
                        
                        
                    }
                    
                }
                else
                {
                    print("login");
                }
            }
            
            // perform
        }
    }
    
    // check internet Connectivity
    
    override func viewDidAppear(_ animated: Bool) {
        
        if CheckInternet.Connection()
        {
            
            let alert = FCAlertView()
            //alert.makeAlertTypeSuccess()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
           
            alert.showAlert(inView: self,
                            withTitle: "Internet Connectivity",
                            withSubtitle: "You are connected to the Internet.",
                            withCustomImage: UIImage(named: "img.png"),
                            withDoneButtonTitle: nil,
                            andButtons: nil)
            
            //alert.commonAlert(Msg: "Connection is Successful", uiVC: self)
            
            
        }
        else
        {
            let alert = FCAlertView()
            //alert.makeAlertTypeSuccess()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
            
            alert.showAlert(inView: self,
                            withTitle: "Internet Connectivity",
                            withSubtitle: "You are not connected to the Internet.",
                            withCustomImage: nil,
                            withDoneButtonTitle: nil,
                            andButtons: nil)
            //alert.commonAlert(Msg: "Not Connected", uiVC: self)
        }
    }
    
// function for to design controll
    func designContollers()
    {
        loginBTN.layer.cornerRadius = 10
    }

// Action of "LOG IN" button
    @IBAction func loginBTNaction(_ sender: UIButton) {
        
    
        sender.pluseAnimation()
        // navigate to "user Login Page"
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "LoginViewController")
    }

// Action of Bottom Delear button
    @IBAction func DealerBtnAction(_ sender: Any) {
        
        // navigate to "Service Provider Login"
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "ServiceProviderLoginVC")
    }

    
// Action of Bottom Driver Button
    @IBAction func DriverBtnAction(_ sender: Any) {
        
        // Navigate to "Driver Login Page"
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "DriverLoginVC")
    }
    
}
