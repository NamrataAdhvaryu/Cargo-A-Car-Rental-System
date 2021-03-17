//
//  DriverUpdateProfile.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 15/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView

class DriverUpdateProfile: UIViewController,Driverdelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,FCAlertViewDelegate {

    //outlet VIEW
    @IBOutlet weak var driverProfile: UIImageView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var mobView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var totaltourView: UIView!
    @IBOutlet weak var pricePerHourView: UIView!
    @IBOutlet weak var isBookedStatusView: UIView!
  
    
    @IBOutlet weak var submitBtnView: UIButton!
    
    // outlet of textfield
    
    @IBOutlet weak var txtname: TextFieldValidator!
    @IBOutlet weak var txtemail: TextFieldValidator!
    @IBOutlet weak var txtPassword: TextFieldValidator!
    @IBOutlet weak var txtMob: TextFieldValidator!
    @IBOutlet weak var txtaddress: TextFieldValidator!
    @IBOutlet weak var txtLocation: TextFieldValidator!
    @IBOutlet weak var txtStatus: TextFieldValidator!
    @IBOutlet weak var txtNoofTour: TextFieldValidator!
    @IBOutlet weak var txtPricePerHour: TextFieldValidator!
    @IBOutlet weak var txtIsBooked: TextFieldValidator!
    
    @IBOutlet weak var swt: UISwitch!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    
    // array for Driver data
    
    var DriverArr = [Any]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtIsBooked.text = "Available"
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        desgin()
        validationSetup()
        tapGestureForImage()
        getDriverdata()
        
        if txtIsBooked.text == "Available"
        {
            swt.isOn = true
        }
        else
        {
            swt.isOn = false
        }
        // Do any additional setup after loading the view.
    }
    // Switch action for is booked status
    
    @IBAction func swt(_ sender: Any) {
        
        // for switch control
        if swt.isOn
        {
            txtIsBooked.text = "Available"
        }
        else
        {
            txtIsBooked.text = "Booked"
        }
    }
    // MARK : validation
    func validationSetup()
    {
        txtname.addRegx(REGEX_USER_NAME, withMsg: "UserName must be between 3 to 10 character")
        txtname.presentInView = self.view
        
        txtPassword.addRegx(REGEX_PASSWORD, withMsg: "Password must be between 6 to 20 character")
        txtPassword.presentInView = self.view
        
        txtemail.addRegx(REGEX_EMAIL, withMsg: "Email Id should be in 'abc@gmail.com' format")
        txtemail.presentInView = self.view
        
        txtMob.addRegx(REGEX_PHONE_DEFAULT, withMsg: "Mobile No must be in 10 digit")
        txtMob.presentInView = self.view
    }
    func validation() -> Bool
    {
        if txtname.validate() && txtPassword.validate() && txtemail.validate() && txtMob.validate()
        {
            return true
        }
        else
        {
            return false
        }
    }
    // delegate function
    func DriverUpdateReturnResponse(arr: [Any]) {
        
        let dic = arr[0] as? [String : Any]
        let status = dic!["status"] as? String
        
        if status == "success"
        {
            //print(updateUser)
            print("Update Information")
            let alert = FCAlertView()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
            alert.makeAlertTypeSuccess()
            alert.delegate = self
            alert.blurBackground = true
            alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Sucessfully Update data.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
           
            //getDriverdata()
        }
    }
    // MARK : error handler
    func ErrorDriver(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        alert.makeAlertTypeWarning()
        alert.delegate = self
        alert.blurBackground = true
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Something is wrong in Update data.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
        
    }
    
    
    // Fcalertview delegate function of done button clicked
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
         navigateObj.navigationCommonPush(uiViewController: self, identifier: "DriverMoreVC")
        
    }
    func desgin()
    {
        driverProfile.layer.cornerRadius = driverProfile.frame.size.width / 2
        driverProfile.clipsToBounds = true
        driverProfile.layer.borderColor = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        driverProfile.layer.borderWidth = 1
        
        nameView.layer.cornerRadius = 20
        emailView.layer.cornerRadius = 20
        passwordView.layer.cornerRadius = 20
        
        mobView.layer.cornerRadius = 20
        addressView.layer.cornerRadius = 20
        locationView.layer.cornerRadius = 20
        statusView.layer.cornerRadius = 20
        
        totaltourView.layer.cornerRadius = 20
        isBookedStatusView.layer.cornerRadius = 20
        pricePerHourView.layer.cornerRadius = 20
        submitBtnView.layer.cornerRadius = 20
        
       // textfield
        //name
        alert.CommontextLayer(txt: (txtname)!, imgStr: "user.png")
        
        //email
        alert.CommontextLayer(txt: (txtemail)!, imgStr: "mail.png")
        
        //password
        alert.CommontextLayer(txt: (txtPassword)!, imgStr: "password.png")
        
        //mob
        alert.CommontextLayer(txt: (txtMob)!, imgStr: "phone.png")
        
        //address
        alert.CommontextLayer(txt: (txtaddress)!, imgStr: "city.png")
        
        //location
        alert.CommontextLayer(txt: (txtLocation)!, imgStr: "location.png")
       
        //number of tour
        alert.CommontextLayer(txt: (txtNoofTour)!, imgStr: "user.png")
       
        //status
        alert.CommontextLayer(txt: (txtStatus)!, imgStr: "user.png")
       
        //is booked sattus
        alert.CommontextLayer(txt: (txtIsBooked)!, imgStr: "user.png")
        
        //price per hour
        alert.CommontextLayer(txt: (txtPricePerHour)!, imgStr: "user.png")
       
    }
    
    // submit action
    @IBAction func submitAction(_ sender: Any) {
        
        if validation()
        {
            updateDriverdata()
        }
        else
        {
            print("Error")
        }
    }
    
    // for image tap gesture
    func tapGestureForImage()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.chooseImage))
        tap.numberOfTapsRequired = 1
        profileBtn.isUserInteractionEnabled = true
        profileBtn.addGestureRecognizer(tap)
    }
    @objc func chooseImage()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let profileImg = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        driverProfile.image = profileImg
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getDriverdata()
    {
        let id = UserDefaults.standard.string(forKey: "driver_id");
        let url = URL(string: "\(commConst.baseUrl)getAllDriverdata.php?driver_id=\(id!)");
        
        let request = URLRequest(url: url!)
        let session = URLSession.shared;
        
        let datatask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                self.DriverArr = jsondata;
                
                DispatchQueue.main.async {
                    
                    let dic = self.DriverArr[0] as! [String : Any]
                    
                    //for image
                    
                    let imagepath = dic["driver_profilepic"] as? String
                    let fullpath = "\(commConst.baseUrl)\(imagepath!)"
                    let url = URL(string: fullpath)
                    do
                    {
                        let dataImage = try Data(contentsOf: url!)
                        self.driverProfile.image = UIImage(data: dataImage)
                    }
                    catch
                    {
                        print("Error in dwonload image")
                    }
                    
                    // name
                    let name = dic["driver_name"] as? String
                    self.txtname.text = name
                    
                    //email
                    let email = dic["driver_email"] as? String
                    self.txtemail.text = email
                    
                    //password
                    let password = dic["driver_password"] as? String
                    self.txtPassword.text = password
                    
                    // mobile no
                    let mob = dic["driver_mob"] as? String
                    self.txtMob.text = mob
                    
                    // address
                    let address = dic["driver_address"] as? String
                    self.txtaddress.text = address
                    
                    // location
                    let location = dic["driver_location"] as? String
                    self.txtLocation.text = location
                    
                    // status
                    let status = dic["driver_status"] as? String
                    self.txtStatus.text = status
                    
                    // total number of tour
                    let totalTour = dic["driver_numberOftour"] as? String
                    self.txtNoofTour.text = totalTour
                    
                    // price per hour
                    let pricePerHour = dic["driver_priceperHour"] as? String
                    self.txtPricePerHour.text = pricePerHour
                    
                    // is booked status
                    let isBooked = dic["driver_isbooked_status"] as? String
                    self.txtIsBooked.text = isBooked
                }
                
            }
            catch
            {
                print("Error in get data from json.")
            }
            
            
        }
        datatask.resume()
    }
    
    // func for update data
    func updateDriverdata()
    {
        let id = UserDefaults.standard.string(forKey: "driver_id")
        
        let driverUpdate = DriverController()
        
        let baseData = driverProfile.image?.jpegData(compressionQuality: 2.0)
        let base64str = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
       // print(base64str!)
        
        driverUpdate.delegate = self
        
        
        let DriverInfo = Drivermodel(driver_id: Int(id!)!, driver_name: txtname.text!, driver_address: txtaddress.text!, driver_email: txtemail.text!, driver_password: txtPassword.text!, driver_mob: txtMob.text!, driver_profilepic: base64str!, driver_location: txtLocation.text!, driver_isbooked_status: txtIsBooked.text!, driver_numberOftour: txtNoofTour.text!, driver_priceperHour: txtPricePerHour.text!, driver_status: txtStatus.text!)
        
        driverUpdate.updateDriverData(driverModel: DriverInfo)
        
    }
    
    @IBAction func back(_ sender: Any) {
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
