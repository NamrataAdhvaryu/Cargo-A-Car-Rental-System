//
//  SP_ViewBookingDetailVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 19/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class SP_ViewBookingDetailVC: UIViewController {

    // MARK : Outlets of View
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    // MARK : Outlet of view1
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carModelName: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    // MARK : Outlet of view2
    @IBOutlet weak var pickDateLbl: UILabel!
    @IBOutlet weak var pickLocationLbl: UILabel!
    @IBOutlet weak var dropDateLbl: UILabel!
    @IBOutlet weak var dropLocationLbl: UILabel!
    @IBOutlet weak var totalKM: UILabel!
    
    // MARK : Outlet of view3
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userContact: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPaymentMode: UILabel!
    
    // MARK : outlet of view4
    @IBOutlet weak var driverProfile: UIImageView!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var driverContact: UILabel!
    @IBOutlet weak var driverEmailID: UILabel!
    
    // MARK : outlet of view guidelines
    @IBOutlet weak var viewGuideBtn: UIButton!
    
    // MARK : Create to store book id
    var bookId : String = ""
    
    // MARK : Create to store car id
    var carId : String = ""
    
    // MARK : Create to store user id
    var userId : String = ""
    
    // MARK : Create to store driver id
    var driverId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        bookingData()
        getBookedcar()
        getBookedUser()
        getBookedDriver()
        
    }
    
    // MARK : func for desgin of control
    func design()
    {
        
      // views
        view2.layer.cornerRadius = 10
        view2.clipsToBounds = true
        view2.layer.borderWidth = 1.5
        view2.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        view3.layer.cornerRadius = 10
        view3.clipsToBounds = true
        view3.layer.borderWidth = 1.5
        view3.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        view4.layer.cornerRadius = 10
        view4.clipsToBounds = true
        view4.layer.borderWidth = 1.5
        view4.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
      // car image from view 1
        carImageView.layer.cornerRadius = 10
        carImageView.clipsToBounds = true
        
      // user image from view 3
        userProfile.layer.cornerRadius = userProfile.frame.size.width / 2
        userProfile.clipsToBounds = true
        
      // driver image from view 4
        driverProfile.layer.cornerRadius = driverProfile.frame.size.width / 2
        driverProfile.clipsToBounds = true
        
      // view guidelines button
        viewGuideBtn.layer.cornerRadius = 15
        viewGuideBtn.clipsToBounds = true
    }
    
    // MARK : get booking data based upon book id
    func bookingData()
    {
        let url = URL(string: "\(commConst.baseUrl)getBookedData.php?book_id=\(bookId)");
        
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
                    alert.commonAlert(Msg: "No data found", uiVC: self)
                }
                else
                {
                    
                    DispatchQueue.main.async {
                        
                        let dic = json[0] as! [String : Any]
                        
                        // MARK : for pick date and drop date
                        let pickdate = dic["pickDate"] as! String
                        self.pickDateLbl.text = pickdate
                        
                        let dropdate = dic["dropDate"] as! String
                        self.dropDateLbl.text = dropdate
                        
                        let picklocation = dic["pickLocation"] as! String
                        self.pickLocationLbl.text = picklocation
                        
                        let droplocation = dic["dropLocation"] as! String
                        self.dropLocationLbl.text = droplocation
                        
                        let totalkm = dic["totalKM"] as! String
                        self.totalKM.text = "\(totalkm) KM"
                    }
                    
                }
            }
            catch
            {
                alert.commonAlert(Msg: "Error in getting Json Data.", uiVC: self)
            }
        }
        dataTask.resume()
    }
    
    // MARK : Get booked car detail by using car id
    func getBookedcar()
    {
        let url = URL(string: "\(commConst.baseUrl)getPerticulerCar.php?car_id=\(carId)");
        
        let request = URLRequest(url: url!);
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsonData.count == 0
                {
                    alert.commonAlert(Msg: "No data found", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let dic = jsonData[0] as! [String : Any]
                        
                        // MARK : car name
                        let carname = dic["car_name"] as! String
                        self.carName.text = carname
                        
                        // MARK : car model
                        let carmodel = dic["car_model"] as! String
                        self.carModelName.text = carmodel
                        
                        // MARK : car image
                        let carimage = dic["car_image"] as! String
                        let fullpath = "\(commConst.baseUrl)\(carimage)"
                        let Imgurl = URL(string: fullpath)
                        do
                        {
                            let imgData = try Data(contentsOf: Imgurl!)
                            self.carImageView.image = UIImage(data: imgData)
                        }
                        catch
                        {
                            alert.commonAlert(Msg: "Error in getting download image", uiVC: self)
                        }
                    }
                }
            }
            catch
            {
                alert.commonAlert(Msg: "Error in getting json data.", uiVC: self)
            }
            
        }
        dataTask.resume()
    }
    
    // MARK : Get booked user detail by using user id
    func getBookedUser()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllUserData.php?user_id=\(userId)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonUser = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsonUser.count == 0
                {
                    alert.commonAlert(Msg: "No data found.", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let dic = jsonUser[0] as! [String : Any]
                        
                        // MARK : user name
                        let username = dic["user_name"] as! String
                        self.userName.text = "User Name : \(username)"
                        
                        // MARK : user contact
                        let usercontact = dic["user_mob"] as! String
                        self.userContact.text = "Contact : +91\(usercontact)"
                        
                        // MARK : user email id
                        let useremail = dic["user_email"] as! String
                        self.userEmail.text = "Email ID : \(useremail)"
                        
                        // MARK : user profile
                        let userprofile = dic["user_profilepic"] as! String
                        let imgpath = "\(commConst.baseUrl)\(userprofile)"
                        let imgurl = URL(string: imgpath)
                        
                        do
                        {
                            let imgData = try Data(contentsOf: imgurl!)
                            self.userProfile.image = UIImage(data: imgData)
                        }
                        catch
                        {
                            alert.commonAlert(Msg: "Error in downloading image", uiVC: self)
                        }
                        
                    }
                }
            }
            catch
            {
                alert.commonAlert(Msg: "Error in getting json data", uiVC: self)
            }
            
        }
        dataTask.resume()
    }
    
    // MARK : Get booked driver detail by using driver id
    func getBookedDriver()
    {
        
        let url = URL(string: "\(commConst.baseUrl)getAllDriverdata.php?driver_id=\(driverId)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, rep, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonDriver = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsonDriver.count == 0
                {
                    alert.commonAlert(Msg: "No data Found", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let dic = jsonDriver[0] as! [String : Any]
                        
                        // MARK : driver name
                        let drivername = dic["driver_name"] as! String
                        self.driverName.text = "Driver Name : \(drivername)"
                        
                        // MARK : driver contact
                        let drivercontact = dic["driver_mob"] as! String
                        self.driverContact.text = "Contact : +91\(drivercontact)"
                        
                        // MARK : driver email id
                        let driveremail = dic["driver_email"] as! String
                        self.driverEmailID.text = "Email ID : \(driveremail)"
                        
                        // MARK : driver profile
                        let driverprofile = dic["driver_profilepic"] as! String
                        let imgpath = "\(commConst.baseUrl)\(driverprofile)"
                        let imgurl = URL(string: imgpath)
                        
                        do
                        {
                            let imgdata = try Data(contentsOf: imgurl!)
                            self.driverProfile.image = UIImage(data: imgdata)
                        }
                        catch
                        {
                            alert.commonAlert(Msg: "Error in download image", uiVC: self)
                        }
                        
                    }
                }
            }
            catch
            {
                alert.commonAlert(Msg: "Error in getting json data", uiVC: self)
            }
            
            
        }
        dataTask.resume()
        
    }
    
    @IBAction func viewGuideLIne(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Important_infoVC")
    }
    @IBAction func back(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
