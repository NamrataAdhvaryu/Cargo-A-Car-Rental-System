//
//  SpMoreItem_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 13/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class SpMoreItem_VC: UIViewController {

    // outlet
    @IBOutlet weak var spProfile: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var updateIcon: UIButton!
    @IBOutlet weak var updateprofile: UIButton!
    
    @IBOutlet weak var viewBookingBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var contactUsBtn: UIButton!
    @IBOutlet weak var aboutusBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //txtBox.bottomLine()
        design()
      getSPdata()
        
    }
    
    func design()
    {
        spProfile.layer.cornerRadius = spProfile.frame.size.width / 2
        spProfile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        spProfile.layer.borderWidth = 1
        spProfile.clipsToBounds = true
        
        // view corner radius
        
        view1.layer.cornerRadius = 10
        usernameLbl.layer.cornerRadius = 10
        usernameLbl.clipsToBounds = true
        
        updateIcon.layer.cornerRadius = 10
        updateIcon.clipsToBounds = true
        
        updateprofile.layer.cornerRadius = 10
        updateprofile.clipsToBounds = true
        
        
        
        // design menu button shadow and layer
        viewBookingBtn.layer.cornerRadius = 15
        viewBookingBtn.clipsToBounds = true
        
        notificationBtn.layer.cornerRadius = 15
        notificationBtn.clipsToBounds = true
        
        contactUsBtn.layer.cornerRadius = 15
        contactUsBtn.clipsToBounds = true
        
        aboutusBtn.layer.cornerRadius = 15
        aboutusBtn.clipsToBounds = true
        
        settingBtn.layer.cornerRadius = 15
        settingBtn.clipsToBounds = true
        
        logoutBtn.layer.cornerRadius = 15
        logoutBtn.clipsToBounds = true
        
        
    }
    
    // func for get service provider data
    func getSPdata()
    {
        let ID = UserDefaults.standard.string(forKey: "sp_id")
        
        let url = URL(string: "\(commConst.baseUrl)spImage.php?sp_id=\(ID!)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
           let str = String(data: data!, encoding: String.Encoding.utf8)
            
            print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
              DispatchQueue.main.async {
                    
                    let dic = jsondata[0] as! [String : Any]
                    
                    let imgpath = dic["sp_profilepic"] as! String
                    let fullPath = "\(commConst.baseUrl)\(imgpath)"
                    let url = URL(string: fullPath)
                    do
                    {
                        let data = try Data(contentsOf: url!)
                        self.spProfile.image = UIImage(data: data)
                    }
                    catch
                    {
                        print("Error in data catch")
                    }
                    
                    
                    let name = dic["sp_name"] as! String
                    self.usernameLbl.text = name
                    
              }
                
                
            }
            catch
            {
                print("Error in do catch")
            }
        }
        dataTask.resume()
    }

    //MARK : update icon action
    @IBAction func updateIcon(_ sender: UIButton) {
        
        //navigateObj.navigationCommonPush(uiViewController: self, identifier: "SPupdateProfile_VC")
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Sp_updateProfileVC")
        
        
    }
    
    // MARK : Update Button Action
    
    @IBAction func updateIconBtn(_ sender: UIButton) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Sp_updateProfileVC")
        
    }
    
    // MARK : Logout Action
    
    @IBAction func logoutAction(_ sender: UIButton) {
        
        UserDefaults.standard.set(false, forKey: "sp_id")
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "HomeViewController")
        
    }
    
    // MARK : View Booking UIbutton Action
    @IBAction func viewBookingClick(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "SP_ViewBooking_VC")
    }
    
    // MARK : about us
    @IBAction func aboutUs(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "AboutUs_VC")
    }
    
    
    // MARK : contact us
    @IBAction func contactUs(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "ContactUs_VC")
    }
    
    // MARK : Setting
    @IBAction func setting(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Setting_VC")
    }
    
    // MARK : rate us
    @IBAction func rateUs(_ sender: Any) {
        
        //navigateObj.navigationCommonPush(uiViewController: self, identifier: "RateUs_VC")
        
        let present = self.storyboard?.instantiateViewController(withIdentifier: "RateUs_VC") as! RateUs_VC
        
        self.present(present, animated: false, completion: nil)
    }
    
    
    
}


