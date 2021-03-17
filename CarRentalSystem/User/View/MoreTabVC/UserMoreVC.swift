//
//  UserMoreVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 02/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import StoreKit

class UserMoreVC: UIViewController {

    // outlet
    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var updateIcon: UIButton!
    @IBOutlet weak var updateProfileBtn: UIButton!
    
    
    // BUTTON MENU OUTLET
    
    @IBOutlet weak var searchBtnMenu: UIButton!
    @IBOutlet weak var notificationBtnMenu: UIButton!
    @IBOutlet weak var settingBtnMenu: UIButton!
    @IBOutlet weak var contactUsBtnMenu: UIButton!
    @IBOutlet weak var aboutUsBtnMenu: UIButton!
    @IBOutlet weak var logoutBtnMenu: UIButton!
    
    let arrData = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
design()
        getData()
        
        // Do any additional setup after loading the view.
    }
    
    func design()
    {
        img.layer.cornerRadius = img.frame.size.width / 2
        img.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        img.layer.borderWidth = 1
        img.clipsToBounds = true
        
        // view corner radius
        
        viewOutlet.layer.cornerRadius = 10
        userName.layer.cornerRadius = 10
        userName.clipsToBounds = true
        
        updateIcon.layer.cornerRadius = 10
        updateIcon.clipsToBounds = true
        
        updateProfileBtn.layer.cornerRadius = 10
        updateProfileBtn.clipsToBounds = true
        
        
        
        // design menu button shadow and layer
        searchBtnMenu.layer.cornerRadius = 15
        searchBtnMenu.clipsToBounds = true
        
        notificationBtnMenu.layer.cornerRadius = 15
        notificationBtnMenu.clipsToBounds = true
        
        contactUsBtnMenu.layer.cornerRadius = 15
        contactUsBtnMenu.clipsToBounds = true
        
        aboutUsBtnMenu.layer.cornerRadius = 15
        aboutUsBtnMenu.clipsToBounds = true
        
        settingBtnMenu.layer.cornerRadius = 15
        settingBtnMenu.clipsToBounds = true
        
        logoutBtnMenu.layer.cornerRadius = 15
        logoutBtnMenu.clipsToBounds = true
        
        
        
    }
    
    @IBAction func updateIcon(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserUpdateProfileVC")
    }
    
    @IBAction func updateprofileBtn(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserUpdateProfileVC")
    }
    
    
    // for get user image and user name
    func getData()
    {
        let ID = UserDefaults.standard.string(forKey: "user_id")
        
        let url = URL(string: "\(commConst.baseUrl)userImage.php?user_id=\(ID!)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        let dataMask = session.dataTask(with: request) { (data, resp, err) in
            
           // let str = String(data: data!, encoding: String.Encoding.utf8)
            
           // print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    let dic = jsondata[0] as! [String : Any]
                    
                    let imgpath = dic["user_profilepic"] as! String
                    let fullPath = "\(commConst.baseUrl)\(imgpath)"
                     let url = URL(string: fullPath)
                    do
                    {
                        let data = try Data(contentsOf: url!)
                        self.img.image = UIImage(data: data)
                    }
                    catch
                    {
                        print("Error")
                    }
                    
                    
                    let name = dic["user_name"] as! String
                    self.userName.text = name
                    
                }
                
                
            }
            catch
            {
                print("Error")
            }
        }
        dataMask.resume()
    }
    
    
    // action of btn Search History
    @IBAction func searchBtn(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "SearchHistory_VC")
        
    }
    //MARK : about us menu
    
    @IBAction func aboutUsBtn(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "AboutUs_VC")
        
    }
    
    // MARK : CONTACT US
    @IBAction func contactUs(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "ContactUs_VC")
    }
    
    // MARK : rate us
    @IBAction func rateUs(_ sender: Any) {
        
      //  navigateObj.navigationCommonPush(uiViewController: self, identifier: "RateUs_VC")

    let present = self.storyboard?.instantiateViewController(withIdentifier: "RateUs_VC") as! RateUs_VC
        
        self.present(present, animated: false, completion: nil)

    }
    
    // MARK : Setting
    @IBAction func setting(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Setting_VC")
    }
    
    
    // MARK : logout
    @IBAction func logoutAction(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "user_id")
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "HomeViewController")
        
    }

}
