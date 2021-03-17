//
//  UserUpdateProfileVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 15/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView

class UserUpdateProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,userdelegate,FCAlertViewDelegate {
    
    // VIEW OUTLET
    
    @IBOutlet weak var txtFieldNameVIew: UIView!
    @IBOutlet weak var txtFieldEmailView: UIView!
    @IBOutlet weak var txtFieldAddressView: UIView!
    @IBOutlet weak var txtFieldCityView: UIView!
    @IBOutlet weak var txtFieldMobView: UIView!
    @IBOutlet weak var txtFieldPasswordView: UIView!
    
    @IBOutlet weak var DoneBtnCLick: UIButton!
    @IBOutlet weak var userProfilepic: UIImageView!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    
    
    
    @IBOutlet weak var txtName: TextFieldValidator!
    @IBOutlet weak var txtAddress: TextFieldValidator!
    @IBOutlet weak var txtmob: TextFieldValidator!
    @IBOutlet weak var txtcity: TextFieldValidator!
    @IBOutlet weak var txtemail: TextFieldValidator!
    @IBOutlet weak var txtpassword: TextFieldValidator!
    
    var UserData = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       getdata()
        tapOnimage()
        designProfilePic()
        validationsetUp()
       
    }
    func designProfilePic()
    {
        userProfilepic.layer.cornerRadius = userProfilepic.frame.size.width / 2
        userProfilepic.clipsToBounds = true
        userProfilepic.layer.borderColor = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        userProfilepic.layer.borderWidth = 1
        
        txtFieldNameVIew.layer.cornerRadius = 20
        txtFieldEmailView.layer.cornerRadius = 20
        txtFieldMobView.layer.cornerRadius = 20
        txtFieldPasswordView.layer.cornerRadius = 20
        txtFieldCityView.layer.cornerRadius = 20
        txtFieldAddressView.layer.cornerRadius = 20
        DoneBtnCLick.layer.cornerRadius = 20
        
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        
        
        // textfield
        
        // name
        alert.CommontextLayer(txt: txtName, imgStr: "user.png")
        
        // address
        alert.CommontextLayer(txt: txtAddress, imgStr: "location.png")
        
        // mob
        alert.CommontextLayer(txt: txtmob, imgStr: "phone.png")
        
        // city
        alert.CommontextLayer(txt: txtcity, imgStr: "city.png")
        
        //email
        alert.CommontextLayer(txt: txtemail, imgStr: "mail.png")
        
        // password
        alert.CommontextLayer(txt: txtpassword, imgStr: "password.png")
        
    }
    
    // MARK : validation
    func validationsetUp()
    {
        txtName.addRegx(REGEX_USER_NAME, withMsg: "UserName must be between 3 to 10 character")
        txtName.presentInView = self.view
        
        txtpassword.addRegx(REGEX_PASSWORD, withMsg: "Password must be between 6 to 20 character")
        txtpassword.presentInView = self.view
        
        txtemail.addRegx(REGEX_EMAIL, withMsg: "Email Id should be in 'abc@gmail.com' format")
        txtemail.presentInView = self.view
        
        txtmob.addRegx(REGEX_PHONE_DEFAULT, withMsg: "Mobile No must be in 10 digit")
        txtmob.presentInView = self.view
    }
    func validation() -> Bool
    {
        if txtName.validate() && txtpassword.validate() && txtemail.validate() && txtmob.validate()
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    // delegate method of update user data
    func getUpdateUserResponse(updateUser: [Any]) {
        
        let dic = updateUser[0] as? [String : Any]
        let status = dic!["status"] as? String
        
        if status == "success"
        {
            //print(updateUser)
            print("Update Information")
            let alert = FCAlertView()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
            alert.makeAlertTypeSuccess()
            alert.delegate = self
            alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Successfully Update data", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            
        }
    }
    
    // MARK : error handler
    func ErrorUser(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        alert.makeAlertTypeWarning()
        alert.delegate = self
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Something is wrong in Update data.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
        
    }
    
    //MARK : FcAlertView delegate method of button click
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserTabbar")
        getdata()
    }
    
   
    func tapOnimage()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.ImageTapAction))
        tap.numberOfTapsRequired = 1
       profileBtn.isUserInteractionEnabled = true
      profileBtn.addGestureRecognizer(tap)
        
    }
    @objc func ImageTapAction(Sender : UITapGestureRecognizer)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let profileImg = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        userProfilepic.image = profileImg
        
        self.dismiss(animated: true, completion: nil)
    }
    
// get user data
    func getdata()
    {
        
        // for get user image and user name
        
            let ID = UserDefaults.standard.string(forKey: "user_id")
            
            let url = URL(string: "\(commConst.baseUrl)getAllUserData.php?user_id=\(ID!)")
            
            let request = URLRequest(url: url!)
            
            let session = URLSession.shared
            
            let dataMask = session.dataTask(with: request) { (data, resp, err) in
                
                let str = String(data: data!, encoding: String.Encoding.utf8)
                
                print(str!)
                do
                {
                    let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                    
                    self.UserData = jsondata
                    
                    DispatchQueue.main.async {
                        
                      
                        let dic = self.UserData[0] as! [String : Any]
                        
                        
                        // FOR IMAGE
                        let imgpath = dic["user_profilepic"] as! String
                        let fullPath = "\(commConst.baseUrl)\(imgpath)"
                        let url = URL(string: fullPath)
                        do
                        {
                            let data = try Data(contentsOf: url!)
                            self.userProfilepic.image = UIImage(data: data)
                        }
                        catch
                        {
                            print("Error")
                        }
                        
                        // for name
                        let nameData = dic["user_name"] as! String
                        self.txtName.text = nameData
                        
                        //for email
                        let emailData = dic["user_email"] as! String
                        self.txtemail.text = emailData
                        
                        // for password
                        let passData = dic["user_password"] as! String
                        self.txtpassword.text = passData
                        
                        //for address
                        let addData = dic["user_address"] as! String
                        self.txtAddress.text = addData
                        
                        // for mob
                        let mobData = dic["user_mob"] as! String
                        self.txtmob.text = mobData
                        
                        // for city
                        let cityData = dic["user_city"] as! String
                        self.txtcity.text = cityData
                    
                        
                    }
                    
                    
                }
                catch
                {
                    print("Error")
                }
            }
            dataMask.resume()
        }
    
    @IBAction func backBtnAction(_ sender: Any) {
       
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
    @IBAction func updateBtnClick(_ sender: Any) {
        
        if validation()
        {
            updateuserData()
        }
        else
        {
            print("Error")
        }
    }
    
   // func for update user
    func updateuserData()
    {
        
        let ID = UserDefaults.standard.string(forKey: "user_id")
       
        let updatedata = UserController()
        let baseData = userProfilepic.image?.jpegData(compressionQuality: 2.0)
        let base64str = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
       // print(base64str!)
        
        updatedata.delegate = self
        
        let UserInfo = usermodel(userid: Int(ID!)!, username: txtName.text!, useraddress: txtAddress.text!, useremail: txtemail.text!, userpassword: txtpassword.text!, usercity: txtcity.text!, usermob: txtmob.text!, userprofilepic: base64str!)
        
        
        
        updatedata.updateUserFunc(userModel: UserInfo)
        
    }
}
