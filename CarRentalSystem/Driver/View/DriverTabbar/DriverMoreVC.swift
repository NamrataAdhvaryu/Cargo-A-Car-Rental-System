//
//  DriverMoreVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 15/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView

class DriverMoreVC: UIViewController,FCAlertViewDelegate {

    @IBOutlet weak var driverProfile: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var updateIcon: UIButton!
    @IBOutlet weak var updateProfileBtn: UIButton!
    @IBOutlet weak var view1: UIView!
    
    // menu button
    @IBOutlet weak var feedBackCustomer: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var contactUs: UIButton!
    @IBOutlet weak var aboutUsBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        desgin()
        getDriverData()
        // Do any additional setup after loading the view.
    }
    
    // design
    func desgin()
    {
        driverProfile.layer.cornerRadius = driverProfile.frame.size.width / 2
        driverProfile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        driverProfile.layer.borderWidth = 1
        driverProfile.clipsToBounds = true
        
        // view corner radius
        
        view1.layer.cornerRadius = 10
        username.layer.cornerRadius = 10
        username.clipsToBounds = true
        
        updateIcon.layer.cornerRadius = 10
        updateIcon.clipsToBounds = true
        
        updateProfileBtn.layer.cornerRadius = 10
        updateProfileBtn.clipsToBounds = true
        
        
        
        // design menu button shadow and layer
        feedBackCustomer.layer.cornerRadius = 15
        feedBackCustomer.clipsToBounds = true
        
        notificationBtn.layer.cornerRadius = 15
        notificationBtn.clipsToBounds = true
        
        contactUs.layer.cornerRadius = 15
        contactUs.clipsToBounds = true
        
        aboutUsBtn.layer.cornerRadius = 15
        aboutUsBtn.clipsToBounds = true
        
        settingBtn.layer.cornerRadius = 15
        settingBtn.clipsToBounds = true
        
        logoutBtn.layer.cornerRadius = 15
        logoutBtn.clipsToBounds = true
    }
    

    @IBAction func logoutBtnClick(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "driver_id")
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "HomeViewController")
    }
    
    // func getdata
    func getDriverData()
    {
        let Id = UserDefaults.standard.string(forKey: "driver_id")
        
        let url = URL(string: "\(commConst.baseUrl)driverImage.php?driver_id=\(Id!)")
        
        let request = URLRequest(url: url!);
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                print(jsondata)
                
                DispatchQueue.main.async {
                    
                    let dic = jsondata[0] as! [String : Any]
                    
                    let imgpath = dic["driver_profilepic"] as! String
                    let fullpath = "\(commConst.baseUrl)\(imgpath)";
                    print(fullpath);
                    let url = URL(string: fullpath)
                    do
                    {
                        let imgdata = try Data(contentsOf: url!)
                        self.driverProfile.image = UIImage(data: imgdata)
                    }
                    catch
                    {
                        print("error in image.")
                    }
                    
                    let name = dic["driver_name"] as! String
                    self.username.text = name
                }
            }
            catch
            {
                print("Error in do catch.")
            }
            
            
        }
        dataTask.resume()
    }
    
    // MARK : get data from data verification
    func getDataverificationData()
    {
        let driver = UserDefaults.standard.string(forKey: "driver_id")
        let url = URL(string: "\(commConst.baseUrl)getDriverVerificationdata.php?driver_id=\(driver!)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
           
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if json.count == 0
                {
                    DispatchQueue.main.async {
                        
                        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Driver_ProfileVerification1")
                        
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let alert = FCAlertView()
                        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
                        alert.makeAlertTypeCaution()
                        alert.delegate = self
                        alert.blurBackground = true
                        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Your Licence is already uploaded", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
                
                    }
                }
            }
            catch
            {
                print("Error in catch block")
            }
            
        }
        dataTask.resume()
        
    }
// action of updateIcon
    @IBAction func updateIcon(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "DriverUpdateProfile")
        
    }
    
// action of update profile button
    @IBAction func updateBtnClick(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "DriverUpdateProfile")
    }
    
    @IBAction func ProfileVerficationBtn(_ sender: Any) {
        
        getDataverificationData()
    }
    
    // MARK : Rate us
    
    @IBAction func rateUs(_ sender: Any) {
        
        //navigateObj.navigationCommonPush(uiViewController: self, identifier: "RateUs_VC")
        let present = self.storyboard?.instantiateViewController(withIdentifier: "RateUs_VC") as! RateUs_VC
        
        self.present(present, animated: false, completion: nil)
        
    }
    
    // MARK : contact us
    @IBAction func contactUs(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "ContactUs_VC")
        
    }
    
    // MARK : about us
    @IBAction func aboutUs(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "AboutUs_VC")
    }
    
    // MARK : setting
    @IBAction func setting(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Setting_VC")
    }
    
}
