//
//  SPRegistrationVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 10/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView

class SPRegistrationVC: UIViewController,spdelegate,FCAlertViewDelegate {

    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var txtsp_name: TextFieldValidator!
    @IBOutlet weak var txtsp_address: TextFieldValidator!
    @IBOutlet weak var txtsp_email: TextFieldValidator!
    @IBOutlet weak var txtsp_password: TextFieldValidator!
    
    @IBOutlet weak var txtsp_mob: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designControlles()
        
    }
    func designControlles()
    {
        signUpBtn.layer.cornerRadius = 5
    }
    
    //func call for delegate
    
    func spReturnResponse(arr: [Any]) {
        
        let dic = arr[0] as? [String : Any]
        let status = dic!["status"] as? String
        
        if status == "success"
        {
            print(arr)
            print("Record Inserted")
            
            let alert = FCAlertView()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
            alert.makeAlertTypeSuccess()
            alert.delegate = self
            alert.blurBackground = true
            alert.showAlert(inView: self, withTitle: "Register with us!", withSubtitle: "Successfully Registered.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            
        }
    }
    
    // MARK : erroe handler
    func ErrorSP(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        alert.makeAlertTypeWarning()
        alert.delegate = self
        alert.blurBackground = true
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Somwthing went wrong in Registeration.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
    }
    
    // FcAlertview done button action login successfull
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "ServiceProviderLoginVC")
        
    }
    func SpRegistration()
    {
        
        let defualtImg = UIImageView(image: UIImage(imageLiteralResourceName: "user2x"))
        let baseData = defualtImg.image?.jpegData(compressionQuality: 2.0)
        let base64Str = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
       // print(base64Str!)
        
        let spRegObj = spController()
        
        spRegObj.delegate = self
        
       
        
        let spRegModel = spmodel(sp_id: 101, sp_name: txtsp_name.text!, sp_address: txtsp_address.text!, sp_email: txtsp_email.text!, sp_password: txtsp_password.text!, sp_mob: txtsp_mob.text!, sp_profilepic: base64Str!)
        
        spRegObj.spRegistration(spModel: spRegModel)
        
    }

    @IBAction func signUpAction(_ sender: Any) {
        
        SpRegistration()
    }
    @IBAction func bottomBtnAction(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "ServiceProviderLoginVC")
        
    }
    @IBAction func backAction(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)

    }
    @IBAction func homeAction(_ sender: Any) {
        
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(stb!, animated: true)
    }
}
