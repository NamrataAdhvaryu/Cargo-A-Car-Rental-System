//
//  BookingDetailVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 14/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class BookingDetailVC: UIViewController,carDelegate,Driverdelegate {

    // MARK : view outlet
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    // MARK : view 1
    @IBOutlet weak var carNamelbl: UILabel!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var carModelName: UILabel!
    
    
    // MARK : View 2
    @IBOutlet weak var pickdateLbl: UILabel!
    @IBOutlet weak var pickLocation: UILabel!
    @IBOutlet weak var dropDatelbl: UILabel!
    @IBOutlet weak var dropLocation: UILabel!
    @IBOutlet weak var totalKmlbl: UILabel!
    
    // MARK : View 3
    @IBOutlet weak var spProfile: UIImageView!
    @IBOutlet weak var spEmailid: UILabel!
    @IBOutlet weak var spNameLbl: UILabel!
    @IBOutlet weak var spContactLbl: UILabel!
    @IBOutlet weak var spPrice: UILabel!
    
    // MARK : View 4
    @IBOutlet weak var driverProfile: UIImageView!
    @IBOutlet weak var driverEmailLbl: UILabel!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var driverContactLbl: UILabel!
    @IBOutlet weak var driverPrice: UILabel!
    
    // MARK : Uibutton
    @IBOutlet weak var viewGuideLineBtn: UIButton!
    @IBOutlet weak var cancleBookingBtn: UIButton!
    @IBOutlet weak var finalBookingBtn: UIButton!
    
    
    // MARK : variable for store tour data value from past viewcontroller
    var bookID : String = ""
    var carId : String = ""
    var spId : String = ""
    var driverId : String = ""
    
    var PickPlace : String = ""
    var dropPlace :String = ""
    
    var pickdate : String = ""
    var dropDate : String = ""
    
    var priceSP : String = ""
    var totalKM : String = ""
    
    // MARK : sp car price per KM
    var carPricePerKM : String = ""
    var driverPricePerHour : String = ""
    var spTotalFare : String = ""
    
    // MARK : to store car status
    var storeCarStatus : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        finalBookingBtn.isHidden = true
       design()
        fullInfo()
        getBookData()
    }
    
    // MARK : design
    func design()
    {
        // MARK : car image
        carImgView.layer.cornerRadius = 10
        carImgView.clipsToBounds = true
        
        // MARK : sp image
        spProfile.layer.cornerRadius = spProfile.frame.size.width / 2
        spProfile.clipsToBounds = true
        
        // MARK : Driver image
        driverProfile.layer.cornerRadius = driverProfile.frame.size.width / 2
        driverProfile.clipsToBounds = true
        
        // MARK : view 3
        view3.layer.cornerRadius = 10
        view3.clipsToBounds = true
        view3.layer.borderWidth = 1
        view3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // MARK : view 4
        view4.layer.cornerRadius = 10
        view4.clipsToBounds = true
        view4.layer.borderWidth = 1
        view4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // MARK : UIBUTTON
        viewGuideLineBtn.layer.cornerRadius = 10
        viewGuideLineBtn.clipsToBounds = true
        
        cancleBookingBtn.layer.cornerRadius = 10
        cancleBookingBtn.clipsToBounds = true
        
        finalBookingBtn.layer.cornerRadius = 10
        finalBookingBtn.clipsToBounds = true
        
        // MARK : Price lable
        spPrice.layer.cornerRadius = 20
        spPrice.clipsToBounds = true
        driverPrice.layer.cornerRadius = 20
        driverPrice.clipsToBounds = true
    }
    
    // MARK : Fill the information whic are navigated
    func fullInfo()
    {
        pickdateLbl.text = pickdate
        pickLocation.text = PickPlace
        
        dropDatelbl.text = dropDate
        dropLocation.text = dropPlace
        
        totalKmlbl.text = "\(totalKM) KM"
        
        spPrice.text = "  ₹ \(priceSP)"
    }
    
    // MARK : get Booking table data using "tour_id"
    func getBookData()
    {
        let url = URL(string: "\(commConst.baseUrl)getBookedData.php?book_id=\(bookID)")
        print(bookID)
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    let dic = jsondata[0] as! [String : Any]
                    
                    // For get car_id
                    let car = dic["car_id"] as! String
                    self.carId = car
                    print(car)
                    
                    // For get sp_id
                    let sp = dic["sp_id"] as! String
                    self.spId = sp
                    print(sp)
                    
                    // For get drive_id
                    let driver = dic["driver_id"] as! String
                    self.driverId = driver
                    print(driver)
                    
                    // For total sp fare
                    let spFare = dic["spFare"] as! String
                    self.spTotalFare = spFare
                    
                    // MARK : call driver detail func here
                    self.DriverInfo()
                    
                    // MARK : Service provider detail func
                    self.spInfo()
                    
                    // MARK : call cardetail func here
                    self.carDetail()
                    
                    
                    
                    
                    
                }
            }
            catch
            {
                print("Error in getting jason data")
            }
            
            
        }
        dataTask.resume()
        
    }
    
    // MARK : get car inforamtion
    func carDetail()
    {
        let url = URL(string: "\(commConst.baseUrl)getBookedCar.php?car_id=\(carId)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    let dic = json[0] as! [String : Any]
                    
                    // Car name
                    
                    let carName = dic["car_name"] as! String
                    let carModel = dic["car_model"] as! String
                    self.carNamelbl.text = " \(carName)"
                    self.carModelName.text = " \(carModel)"
                    
                    // MARK : Car price per KM
                    let carPriceKM = dic["car_PriceKM"] as! String
                    self.carPricePerKM = carPriceKM
                    
                    // Car image
                    let carImage = dic["car_image"] as! String
                    let fullpath = "\(commConst.baseUrl)\(carImage)"
                    let url = URL(string: fullpath)
                    do
                    {
                        let imgdata = try Data(contentsOf: url!)
                        self.carImgView.image = UIImage(data: imgdata)
                    }
                    catch
                    {
                        print("error in download image")
                    }
                    
                    // MARK : car status
                    let carStatus = dic["car_bookedStatus"] as! String
                    print(carStatus)
                    
                    if carStatus == "Pending"
                    {
                        print("Car \(carStatus)")
                        self.changeCarStatus()
                    }
                    else if carStatus == "Booked"
                    {
                        print("Car \(carStatus)")
                        self.cancleBookingBtn.isHidden = true
                        self.finalBookingBtn.isHidden = false
                    }
                    
                    if carStatus == "Available"
                    {
                        print("Car \(carStatus)")
                        self.cancleBookingBtn.isHidden = true
                        self.finalBookingBtn.isHidden = true
                    }
                }
            }
            catch
            {
                print("Error in getting json data")
            }
            
        }
        dataTask.resume()
    }
    
    // MARK : get service provider information
    func spInfo()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllspdata.php?sp_id=\(spId)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    let dic = json[0] as! [String : Any]
                    
              // get SerivceProvider Name
                    let spname = dic["sp_name"] as! String
                    self.spNameLbl.text = "Name : \(spname)"
                    
             // get Sp Email
                    let spEmail = dic["sp_email"] as! String
                    self.spEmailid.text = "Email ID : \(spEmail)"
                    
             // get sp contact
                    let spCOntact = dic["sp_mob"] as! String
                    self.spContactLbl.text = "Mob : +91\(spCOntact)"
                    
                    
            
             // get sp profile imahe
                    let spProfile = dic["sp_profilepic"] as! String
                    let fullpath = "\(commConst.baseUrl)\(spProfile)"
                    let imgUrl = URL(string: fullpath)
                    do
                    {
                        let imgdata = try Data(contentsOf: imgUrl!)
                        self.spProfile.image = UIImage(data: imgdata)
                    }
                    catch
                    {
                        print("Error in getting downloading image")
                    }
                    
                    
                }
            }
            catch
            {
                print("Error in getting json data.")
            }
            
        }
        dataTask.resume()
    }
    
    // MARK : get driver information
    func DriverInfo()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllDriverdata.php?driver_id=\(driverId)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonDriver = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    let dic = jsonDriver[0] as! [String : Any]
                    
           // Drive name
                    let driverName = dic["driver_name"] as! String
                    self.driverNameLbl.text = "Name : \(driverName)"
                    
          // Driver Email
                    let driverEmail = dic["driver_email"] as! String
                    self.driverEmailLbl.text = "Email ID : \(driverEmail)"
                    
         // Driver Contact
                    let driverMob = dic["driver_mob"] as! String
                    self.driverContactLbl.text = "Mob : +91\(driverMob)"
                    
        // Driver price
                    let driverPrice = dic["driver_priceperHour"] as! String
                    self.driverPrice.text = " Per hour : ₹\(driverPrice)"
                    self.driverPricePerHour = driverPrice
                    
          // Driver profile pic
                    
                    let driverProfile = dic["driver_profilepic"] as! String
                    let fullPath = "\(commConst.baseUrl)\(driverProfile)"
                    let imgURl = URL(string: fullPath)
                    
                    do
                    {
                        let imgdata = try Data(contentsOf: imgURl!)
                        self.driverProfile.image = UIImage(data: imgdata)
                    }
                    catch
                    {
                        print("Error in downloading img")
                    }
                    
                    
                    // MARK : driver status
                    let driverStatus = dic["driver_isbooked_status"] as! String
                    print(driverStatus)
                    
                    if driverStatus == "Pending"
                    {
                        
                        print("Driver \(driverStatus)")
                        self.driverStatusUpdate()
                    }
                    
                    else if driverStatus == "Booked"
                    {
                        print("Driver \(driverStatus)")
                        self.cancleBookingBtn.isHidden = true
                        self.finalBookingBtn.isHidden = false
                    }
                    
                    if driverStatus == "Available"
                    {
                        print("Driver \(driverStatus)")
                        self.cancleBookingBtn.isHidden = true
                        self.finalBookingBtn.isHidden = true
                    }
 
                }
            }
            catch
            {
                print("Error in getting json data of driver")
            }
        }
        dataTask.resume()
    }
    
    // MARK : function for update car status
    func changeCarStatus()
    {
        let today = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let todayDate = formatter.string(from: today)
        print(todayDate)
        
        print(pickdate)
        
        if todayDate >= pickdate
        {
            finalBookingBtn.isHidden = false
            cancleBookingBtn.isHidden = true
            
            let carStatus = addCarController()
            carStatus.delegate = self
            
            let carStatusModelObj = addCarModel(bookstatus: "Booked", carid: Int(carId)!)
            
            carStatus.carBookStatus(carBook: carStatusModelObj)
            
        }

    }
    
    // MARK : delegate function of update car status
    func UpdateStatusReturnResp(arr: [Any]) {
        
            let dic = arr[0] as! [String : Any]
            
            let status = dic["status"] as! String
            
            if status == "success"
            {
                print("Update car Sttaus.")
            }
            
        }
    
    // MARK : change driver status
    func driverStatusUpdate()
    {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let todayDate = formatter.string(from: today)
        
        if todayDate >= pickdate
        {
            let driverStatus = DriverController()
            driverStatus.delegate = self
            
            let driverObj = Drivermodel(driver_id: Int(driverId)!, driverStats: "Booked")
            
            driverStatus.bookedStatusUpdate(updateStatus: driverObj)
        }
    }
    
    // MARK : delegate function of driver
    func DriverBookedStatusUpdate(arr: [Any]) {
        
        let dic = arr[0] as! [String : Any]
        let status = dic["status"] as! String
        
        if status == "success"
        {
            print("update driver status.")
        }
        
    }
    
    @IBAction func finishBookingBtn(_ sender: Any) {
        
        
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "UserEndtrip_VC") as! UserEndtrip_VC
        
        stb.finishspId = spId
        stb.finishcarId = carId
        stb.finishdriverId = driverId
        
        stb.finishcarprice = carPricePerKM
        stb.finishTotalSpPrice = spTotalFare
        stb.finishTotalKm = totalKM
        
        stb.finishDriverPricePerHour = driverPricePerHour
        
        
        
        self.navigationController?.pushViewController(stb, animated: true)
        //navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserEndtrip_VC")
    }
    
    @IBAction func cancleBookingBtn(_ sender: Any) {
        
        calcleBooking()
    }
    
    
    // MARK : cancle booking
    func calcleBooking()
    {
        let alert = UIAlertController(title: "Cancle Booking On CarRental", message: "Are you sure you want to cancle booking?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (okclick) in
            
            // MARK : delete query
            
            let url = URL(string: "\(commConst.baseUrl)deleteBookeddata.php?book_id=\(self.bookID)");
            let request = URLRequest(url: url!)
            let session = URLSession.shared;
            let dataTask = session.dataTask(with: request, completionHandler: { (data, rep, err) in
                
                let str = String(data: data!, encoding: String.Encoding.utf8)
                print(str!)
                
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                    
                    DispatchQueue.main.async {
                        
                        let dic = json[0] as! [String : Any]
                        let status = dic["status"] as! String
                        
                        if status == "success"
                        {
                            print("Data delete successfully.")
                            
                            // MARK : car status function
                            self.CarStatusOnCancle()
                            
                            // MARK : driver status function
                            self.DriverStatusOnCancle()
                            
                            
                            navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserBookVC")
                        }
                    }
                }
                catch
                {
                    print("Error in delete data.")
                }
                
                
            })
            dataTask.resume()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: { (cancleClick) in
            
            print("Cancle")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK : change car status when user click on "Cancle Booking"
    func CarStatusOnCancle()
    {
        let carStatus = addCarController()
        carStatus.delegate = self
        
        let carStatusModelObj = addCarModel(bookstatus: "Available", carid: Int(carId)!)
        
        carStatus.carBookStatus(carBook: carStatusModelObj)
    }
    
    // MARK : chnage driver status when user click on "cancle booking"
    func DriverStatusOnCancle()
    {
        let driverStatus = DriverController()
        driverStatus.delegate = self
        
        let driverObj = Drivermodel(driver_id: Int(driverId)!, driverStats: "Available")
        
        driverStatus.bookedStatusUpdate(updateStatus: driverObj)
    }
    
    // MARK : back arrow
    @IBAction func back(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
    @IBAction func viewGuideLIne(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Important_infoVC")
    }
}
