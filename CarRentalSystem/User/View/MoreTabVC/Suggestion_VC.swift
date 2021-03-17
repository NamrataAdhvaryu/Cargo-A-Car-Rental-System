//
//  Suggestion_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 07/09/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class Suggestion_VC: UIViewController {

    // MARK : outlet of view
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    // MARK : outlet of view1
    @IBOutlet weak var txtName: UITextField!
    
    // MARK : outlet of view2
    @IBOutlet weak var txtEMail: UITextField!
    
    // MARK " outlet of view 3
    @IBOutlet weak var txtSuggestion: UITextView!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    // MARK : get id of user sp and river
    let user = UserDefaults.standard.string(forKey: "user_id")
    let sp = UserDefaults.standard.string(forKey: "sp_id")
    let driver = UserDefaults.standard.string(forKey: "driver_id")

    
    // MARK : fill data
    var name = ""
    var email = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        filldata()
        // Do any additional setup after loading the view.
    }
    
    // MARK : function for design
    func design()
    {
        view1.layer.cornerRadius = 10
        view1.clipsToBounds = true
        txtName.clipsToBounds = true
        txtName.layer.cornerRadius = 10
        view1.layer.borderWidth = 1
        view1.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        
        view2.layer.cornerRadius = 10
        view2.clipsToBounds = true
        txtEMail.clipsToBounds = true
        txtEMail.layer.cornerRadius = 10
        view2.layer.borderWidth = 1
        view2.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        view3.layer.cornerRadius = 10
        view3.clipsToBounds = true
        txtSuggestion.clipsToBounds = true
        txtSuggestion.layer.cornerRadius = 10
        view3.layer.borderWidth = 1
        view3.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        submitBtn.layer.cornerRadius = 12
        submitBtn.clipsToBounds = true
    }
    // MARK : fill data
    func filldata()
    {
        print(user!)
        print(sp!)
        print(driver!)
        if Int(user!) != 0
        {
            getDataUser()
        }
        else if Int(sp!) != 0
        {
            getDataSP()
        }
        else if Int(driver!) != 0
        {
            getDataDriver()
        }
        else
        {
            print("no data.")
        }
    }
    
    // MARK : email sending
    
    // MARK : get email id and name
    func getDataUser()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllUserData.php?user_id=\(user!)")
        
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
                    print("This id is not match with user")
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let dic = json[0] as! [String : Any]
                        
                        let userName = dic["user_name"] as! String
                        self.txtName.text = userName
                        
                        let userEmail = dic["user_email"] as! String
                        self.txtEMail.text = userEmail
                        
                    }
                }
            }
            catch
            {
                
            }
            
        }
        dataTask.resume()
    }
    func getDataSP()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllspdata.php?sp_id=\(sp!)")
        
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
                    print("This id is not match with user")
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let dic = json[0] as! [String : Any]
                        
                        let spName = dic["sp_name"] as! String
                        self.txtName.text = spName
                        
                        let spEmail = dic["sp_email"] as! String
                        self.txtEMail.text = spEmail
                        
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
    func getDataDriver()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllDriverdata.php?driver_id=\(driver!)")
        
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
                    print("This id is not match with driver")
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let dic = json[0] as! [String : Any]
                        
                        let driverName = dic["driver_name"] as! String
                        self.txtName.text = driverName
                        
                        let driver_email = dic["driver_email"] as! String
                        self.txtEMail.text = driver_email
                        
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
    
    @IBAction func back(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
