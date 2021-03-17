//
//  Sp_updateProfileVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 14/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView

class Sp_updateProfileVC: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,spdelegate,FCAlertViewDelegate {

    // outlet
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    
    @IBOutlet weak var spProfile: UIImageView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var password: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var AddressView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var pincodeView: UIView!
    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet weak var doneBtnClick: UIButton!
    
    
    // textfield
    @IBOutlet weak var txtname: TextFieldValidator!
    @IBOutlet weak var txtemail: TextFieldValidator!
    @IBOutlet weak var txtpassword: TextFieldValidator!
    @IBOutlet weak var txtmob: TextFieldValidator!
    @IBOutlet weak var txtaddress: TextFieldValidator!
    @IBOutlet weak var txtstatus: TextFieldValidator!
    @IBOutlet weak var txtpincode: TextFieldValidator!
    @IBOutlet weak var txtlocation: TextFieldValidator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
       design()
        tapOnCamera()
        getSPdata()
      
        // Do any additional setup after loading the view.
    }
    
    func design()
    {
        spProfile.layer.cornerRadius = spProfile.frame.size.width / 2
        spProfile.clipsToBounds = true
        spProfile.layer.borderColor = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        spProfile.layer.borderWidth = 1
        
        nameView.layer.cornerRadius = 20
        emailView.layer.cornerRadius = 20
        password.layer.cornerRadius = 20
        mobileView.layer.cornerRadius = 20
        AddressView.layer.cornerRadius = 20
        statusView.layer.cornerRadius = 20
        pincodeView.layer.cornerRadius = 20
        locationView.layer.cornerRadius = 20
        
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        
        doneBtnClick.layer.cornerRadius = 20
        
        
        // design textfield (bottom line textfiled)
        
    // for name
        alert.CommontextLayer(txt: (txtname)!, imgStr:"user.png");
        
    // for email
        alert.CommontextLayer(txt: (txtemail)!, imgStr:"mail.png");
        
    // for password
        alert.CommontextLayer(txt: (txtpassword)!, imgStr:"password.png");
        
    // for mobilr number
        alert.CommontextLayer(txt: (txtmob)!, imgStr:"phone.png");
        
    // for address
        alert.CommontextLayer(txt: (txtaddress)!, imgStr:"city.png");
        
    // for status
        alert.CommontextLayer(txt: (txtstatus)!, imgStr: "user.png");
        
    // for pincode
        alert.CommontextLayer(txt: (txtpincode)!, imgStr: "user.png");
        
    // for location
        alert.CommontextLayer(txt: (txtlocation)!, imgStr: "location.png");
        
    }
    // MARK : validation
    func validationSetup()
    {
        txtname.addRegx(REGEX_USER_NAME, withMsg: "UserName must be between 3 to 10 character")
        txtname.presentInView = self.view
        
        txtpassword.addRegx(REGEX_PASSWORD, withMsg: "Password must be between 6 to 20 character")
        txtpassword.presentInView = self.view
        
        txtemail.addRegx(REGEX_EMAIL, withMsg: "Email Id should be in 'abc@gmail.com' format")
        txtemail.presentInView = self.view
        
        txtmob.addRegx(REGEX_PHONE_DEFAULT, withMsg: "Mobile No must be in 10 digit")
        txtmob.presentInView = self.view
    }
    func validation() -> Bool
    {
        if txtname.validate() && txtpassword.validate() && txtemail.validate() && txtmob.validate()
        {
            return true
        }
        else
        {
            return false
        }
    }
    // delegate fucntion of sp update data
    func spUpdateReturnResp(arr: [Any]) {
        
        let dic = arr[0] as? [String : Any]
        let status = dic!["status"] as? String
        
        if status == "success"
        {
            print("Update data");
            let alert = FCAlertView()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
            alert.makeAlertTypeSuccess()
            alert.delegate = self
            alert.blurBackground = true
            alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Successfully Update Profile.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
        }
    }
    
    // MARK : ERROR HANDLER
    func ErrorSP(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        alert.makeAlertTypeWarning()
        alert.delegate = self
        alert.blurBackground = true
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Successfully Registered.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
    }
    
    // MARK : FCAlertView delegate function
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "SpTabbar")
    }
    
    // tap gesture for change profile
    
    func tapOnCamera()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapChooseImage))
        tap.numberOfTapsRequired = 1
        profileBtn.isUserInteractionEnabled = true
        profileBtn.addGestureRecognizer(tap)
    }
    
    // function handler for action tapChooseImage
    @objc func tapChooseImage(sender : UITapGestureRecognizer)
    {
        let picker = UIImagePickerController();
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        spProfile.image = img
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getSPdata()
    {
        let id = UserDefaults.standard.string(forKey: "sp_id");
        let url = URL(string: "\(commConst.baseUrl)getAllspdata.php?sp_id=\(id!)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, error) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!);
            
            do
            {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    let dic = jsonData[0] as? [String : Any]
                    
                    
                // for image
                    let imagepath = dic!["sp_profilepic"] as? String
                    let fullpath = "\(commConst.baseUrl)\(imagepath!)"
                    let url = URL(string: fullpath)
                    
                    do
                    {
                       let data = try Data(contentsOf: url!)
                        self.spProfile.image = UIImage(data: data)
                    }
                    catch
                    {
                        print("Error in download image.")
                    }
                  
                    
               // for name
                    let name = dic!["sp_name"] as? String
                    self.txtname.text = name
                    
              // for email
                    let email = dic!["sp_email"] as? String
                    self.txtemail.text = email
                    
              // for password
                    let password = dic!["sp_password"] as? String
                    self.txtpassword.text = password
                    
              // for mobile number
                    let mobile = dic!["sp_mob"] as? String
                    self.txtmob.text = mobile
                    
              // for address
                    let address = dic!["sp_address"] as? String
                    self.txtaddress.text = address
                    
            // for status
                    let status = dic!["sp_status"] as? String
                    self.txtstatus.text = status
                    
            // for pincode
                    let pincode = dic!["sp_pincode"] as? String
                    self.txtpincode.text = pincode
                    
            //for location
                    let location = dic!["sp_location"] as? String
                    self.txtlocation.text = location
                
                }
            }
            catch
            {
                print("Error in do catch block")
            }
            
            
        }
        dataTask.resume()
        
    }
    
    @IBAction func updateClick(_ sender: Any) {
        
        if validation()
        {
            updateSpData()
        }
        else
        {
            print("Error")
        }
        
    }
    // update sp data
    
    func updateSpData()
    {
        let id = UserDefaults.standard.string(forKey: "sp_id");
        let spObj = spController()
        
        let baseData = spProfile.image?.jpegData(compressionQuality: 2.0)
        let base64 = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        print(base64!)
        
        spObj.delegate = self
        
        let spUpdate = spmodel(sp_id: Int(id!)!, sp_name: txtname.text!, sp_address: txtaddress.text!, sp_email: txtemail.text!, sp_password: txtpassword.text!, sp_mob: txtmob.text!, sp_profilepic: base64!, sp_pincode: txtpincode.text!, sp_location: txtlocation.text!, sp_status: txtstatus.text!)
        
        spObj.spUpdate(spUpdateModel: spUpdate)
        
    }
    
    // MARK : Back button click
    
    @IBAction func backBtn(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
   

}
