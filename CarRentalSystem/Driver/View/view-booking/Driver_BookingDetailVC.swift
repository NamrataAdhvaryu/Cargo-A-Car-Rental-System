//
//  Driver_BookingDetailVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 20/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class Driver_BookingDetailVC: UIViewController {

    
    // MARK : outles of views
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    // MARK : outlet of view2
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLbl: UILabel!
    @IBOutlet weak var carModelNameLbl: UILabel!
    
    // MAARK :  outlet of view3
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userContactLbl: UILabel!
    @IBOutlet weak var userEmailidLbl: UILabel!
    @IBOutlet weak var userProfileImg: UIImageView!
    
    // MARK : outlet of view4
    @IBOutlet weak var spNameLbl: UILabel!
    @IBOutlet weak var spContactLbl: UILabel!
    @IBOutlet weak var spEmailidLbl: UILabel!
    @IBOutlet weak var spProfileView: UIImageView!
    
    // MARK : outlet of view5
    @IBOutlet weak var pickLocationLbl: UILabel!
    @IBOutlet weak var pickDateLbl: UILabel!
    @IBOutlet weak var dropLocationLbl: UILabel!
    @IBOutlet weak var dropDateLbl: UILabel!
    @IBOutlet weak var totalKMLbl: UILabel!
    
    // MARK : outlet of view6
    @IBOutlet weak var driverfareLBL: UILabel!
    
    // MARK : outlet of uibutton
    @IBOutlet weak var calcluatePriceBtn: UIButton!
    @IBOutlet weak var viewGuideLineBtn: UIButton!
    
    //MARK : store id which are navigate from driver booking vc
    var book = "";
    var car = "";
    var sp = "";
    var user = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

       design()
       viewBookingata()
       carData()
       userData()
       spData()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK : func for design
    func design()
    {
    // MARK : view1
        view1.layer.cornerRadius = 10
        view1.clipsToBounds = true
       // view1.layer.borderWidth = 1
       // view1.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
   // MARK : view3
        view3.layer.cornerRadius = 10
        view3.clipsToBounds = true
        view3.layer.borderWidth = 1
        view3.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

        
    // MARK : view4
        view4.layer.cornerRadius = 10
        view4.clipsToBounds = true
        view4.layer.borderWidth = 1
        view4.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

        
    // MARK : view5
        view5.layer.cornerRadius = 10
        view5.clipsToBounds = true
        view5.layer.borderWidth = 1
        view5.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

        
    // MARK : view6
        view6.layer.cornerRadius = 10
        view6.clipsToBounds = true
        view6.layer.borderWidth = 1
        view6.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
    // MARK : user profile
        userProfileImg.layer.cornerRadius = userProfileImg.frame.size.width / 2
        userProfileImg.clipsToBounds = true
        
    // MARK : Sp profile
        spProfileView.layer.cornerRadius = spProfileView.frame.size.width / 2
        spProfileView.clipsToBounds = true
        
    // MARK : view guideline button
        viewGuideLineBtn.layer.cornerRadius = 15
        viewGuideLineBtn.clipsToBounds = true
        
    // MARK : Calcluate button
        calcluatePriceBtn.layer.cornerRadius = 15
        calcluatePriceBtn.clipsToBounds = true
        
    // MARK : driver lable
        driverfareLBL.sizeToFit()
        driverfareLBL.numberOfLines = 7
        driverfareLBL.text = "As a driver , Your total fare is besaed on how many hour you drive / travel. After the end of the travel or by ending day you can calculate your total fare by entring your total travel hour on clicking the button which is given below."

        // MARK : car image
    carImageView.layer.cornerRadius = 10
        carImageView.clipsToBounds = true
        
    }
    
    //MARK : get booking data of perticuler booking
    func viewBookingata()
    {
        let url = URL(string: "\(commConst.baseUrl)getBookedData.php?book_id=\(book)")
        let request = URLRequest(url: url!)
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonBook = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsonBook.count == 0
                {
                    alert.commonAlert(Msg: "No data found", uiVC: self)
                }
                else
                {
                    
                    DispatchQueue.main.async {
                        
                        let dic = jsonBook[0] as! [String : Any]
                        
                        let pickLocation = dic["pickLocation"] as! String
                        self.pickLocationLbl.text = pickLocation
                        
                        let pickDate = dic["pickDate"] as! String
                        self.pickDateLbl.text = pickDate
                        
                        let dropLocation = dic["dropLocation"] as! String
                        self.dropLocationLbl.text = dropLocation
                        
                        let dropDate = dic["dropDate"] as! String
                        self.dropDateLbl.text = dropDate
                        
                        let totalKM = dic["totalKM"] as! String
                        self.totalKMLbl.text = totalKM
                        
                    }
                    
                }
            }
            catch
            {
                alert.commonAlert(Msg: "Errir in getting json data.", uiVC: self)
            }
        }
        dataTask.resume()
    }
    
    
    // MARK : getting car information by using carid
    func carData()
    {
        let url = URL(string: "\(commConst.baseUrl)getBookedCar.php?car_id=\(car)")
        let request = URLRequest(url: url!)
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonBook = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsonBook.count == 0
                {
                    alert.commonAlert(Msg: "No data found", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let dic = jsonBook[0] as! [String : Any]
                        
                        let carname = dic["car_name"] as! String
                        self.carNameLbl.text = carname
                        
                        let carmodel = dic["car_model"] as! String
                        self.carModelNameLbl.text = carmodel
                        
                        let carimage = dic["car_image"] as! String
                        let fullpath = "\(commConst.baseUrl)\(carimage)"
                        let imgurl = URL(string: fullpath)
                        do
                        {
                            let imgdata = try Data(contentsOf: imgurl!)
                            self.carImageView.image = UIImage(data: imgdata)
                        }
                        catch
                        {
                            alert.commonAlert(Msg: "Error in download car image", uiVC: self)
                        }
                        
                    }
                }
            }
            catch
            {
                alert.commonAlert(Msg: "Errir in getting json data.", uiVC: self)
            }
        }
        dataTask.resume()
    }
    
    // MARK : get booked user information
    func userData()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllUserData.php?user_id=\(user)")
        let request = URLRequest(url: url!)
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonBook = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsonBook.count == 0
                {
                    alert.commonAlert(Msg: "No data found", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let dic = jsonBook[0] as! [String : Any]
                        
                        let username = dic["user_name"] as! String
                        self.userNameLbl.text = username
                        
                        let usercontact = dic["user_mob"] as! String
                        self.userContactLbl.text = usercontact
                        
                        let useremail = dic["user_email"] as! String
                        self.userEmailidLbl.text = useremail
                        
                        let userimg = dic["user_profilepic"] as! String
                        let fullpath = "\(commConst.baseUrl)\(userimg)"
                        let imgurl = URL(string: fullpath)
                        do
                        {
                            let imgdata = try Data(contentsOf: imgurl!)
                            self.userProfileImg.image = UIImage(data: imgdata)
                        }
                        catch
                        {
                            alert.commonAlert(Msg: "Error in download car image", uiVC: self)
                        }
                    }
                    
                }
            }
            catch
            {
                alert.commonAlert(Msg: "Errir in getting json data.", uiVC: self)
            }
        }
        dataTask.resume()
    }
    
    // MARK : get service provider information
    func spData()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllspdata.php?sp_id=\(sp)")
        let request = URLRequest(url: url!)
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonBook = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsonBook.count == 0
                {
                    alert.commonAlert(Msg: "No data found", uiVC: self)
                }
                else
                {
                    
                    DispatchQueue.main.async {
                        
                        let dic = jsonBook[0] as! [String : Any]
                        
                        let spname = dic["sp_name"] as! String
                        self.spNameLbl.text = spname
                        
                        let spcontact = dic["sp_mob"] as! String
                        self.spContactLbl.text = spcontact
                        
                        let spemail = dic["sp_email"] as! String
                        self.spEmailidLbl.text = spemail
                        
                        let spimg = dic["sp_profilepic"] as! String
                        let fullpath = "\(commConst.baseUrl)\(spimg)"
                        let imgurl = URL(string: fullpath)
                        do
                        {
                            let imgdata = try Data(contentsOf: imgurl!)
                            self.spProfileView.image = UIImage(data: imgdata)
                        }
                        catch
                        {
                            alert.commonAlert(Msg: "Error in download car image", uiVC: self)
                        }
                       
                    }
                   
                }
            }
            catch
            {
                alert.commonAlert(Msg: "Errir in getting json data.", uiVC: self)
            }
        }
        dataTask.resume()
    }

    @IBAction func back(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    @IBAction func viewGuideline(_ sender: Any) {
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Important_infoVC")
    }
}
