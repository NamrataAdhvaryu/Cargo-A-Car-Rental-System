//
//  checkoutSummaryVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 09/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import FCAlertView

class checkoutSummaryVC: UIViewController,BookDelegate,carDelegate,UNUserNotificationCenterDelegate,Driverdelegate,FCAlertViewDelegate {

    
    // MARK : outlet
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    // MARK : outlet of view1
    @IBOutlet weak var carNameLbl: UILabel!
    @IBOutlet weak var pickupdateLbl: UILabel!
    @IBOutlet weak var pickupLocationLbl: UILabel!
    @IBOutlet weak var dropoffDateLbl: UILabel!
    @IBOutlet weak var dropOffLocationLbl: UILabel!
    
    // MARK : outlet of view2
    @IBOutlet weak var spTotalPrice: UILabel!
    @IBOutlet weak var driverPrice: UILabel!
    
    // MARK : outlet of view3
    @IBOutlet weak var spProfileimg: UIImageView!
    @IBOutlet weak var spNameLbl: UILabel!
    @IBOutlet weak var spContactLbl: UILabel!
    
    // MARK : outlet of view4
    @IBOutlet weak var driverProfileimg: UIImageView!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var driverContactLbl: UILabel!
    
    // MARK : booking uibutton
    @IBOutlet weak var bookBtn: UIButton!
    
    
    // MARK : for get selected driver ID
    var selected_DriverId = "";
    
    // MARK : for get selected driver price per hour
    var selected_DriverPrice = "";
    
    // MARK : for get service provider total fare
    var selected_SpPrice : Int = 0
    
    // MARK : for get selected car id
    var selected_CarId = "";
    
    // MARK : for get pickup date and drop off date
    var selectedPickDate = "";
    var selectedDropDate = "";
    
    // MARK : for get pick location and drop location
    var selectedPickLocation = "";
    var selectedDropLocation = "";
    
    // MARK : to store total km
    var selectedTotalKm = "";
    
    // MARK : for get selected sp id
    var selected_SpID = "";
    
    // MARK : instance of usernotification
    var usernotification = UNUserNotificationCenter.current()
    
    // mark : store car name and driver name
    var NotificationcarName : String = "";
    var NotificationdriverName : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        usernotification.delegate = self
        usernotification.requestAuthorization(options: [.alert, .badge ,.sound]) { (success, err) in
            
        }
        design()
        Checkout()
    }
    
    // MARK : desgin of all controls
    func design()
    {
        
        // MARK : view1
        view1.layer.cornerRadius = 10
        view1.layer.borderWidth = 1
        view1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view1.clipsToBounds = true
        
        // MARK : view2
        view2.layer.cornerRadius = 10
        view2.layer.borderWidth = 1
        view2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view2.clipsToBounds = true
        
        // MARK : view3
        view3.layer.cornerRadius = 10
        view3.layer.borderWidth = 1
        view3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view3.clipsToBounds = true
        
        // MARK : view4
        view4.layer.cornerRadius = 10
        view4.layer.borderWidth = 1
        view4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view4.clipsToBounds = true
        
        // MARK : Book button
        bookBtn.layer.cornerRadius = 10
        bookBtn.clipsToBounds = true
        
        // MARK : sp profile from view3
        spProfileimg.layer.cornerRadius = spProfileimg.frame.size.width / 2
        spProfileimg.clipsToBounds = true
        spProfileimg.layer.borderWidth = 1
        spProfileimg.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // MARK : driver profile from view4
        driverProfileimg.layer.cornerRadius = driverProfileimg.frame.size.width / 2
        driverProfileimg.clipsToBounds = true
        driverProfileimg.layer.borderWidth = 1
        driverProfileimg.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    
    // Getting All information
    func Checkout()
    {
        
        // MARK : Assign the value to the variable
        
        selected_CarId = FinalCarId
        selected_SpPrice = finalPrice
        selectedPickDate = pickUpdate
        selectedDropDate = dropOffdate
        selectedPickLocation = FinalpickUpLocation
        selectedDropLocation = FinaldropOffLocation
        selectedTotalKm = String(totalKm)
        
        
        // MARK : for get sp id to get service provider information
        getSpID()
        
        // MARK : for get selected driver detail
        driverDetail()
        
        // MARK : get selected all car detail
        SelectedCarDetail()
        
        pickupdateLbl.text = selectedPickDate
        dropoffDateLbl.text = selectedDropDate
        
        pickupLocationLbl.text = selectedPickLocation
        dropOffLocationLbl.text = selectedDropLocation
        
        spTotalPrice.text = "\(selected_SpPrice)₹"
        
        driverPrice.text = "Per Hour \(selected_DriverPrice)₹"
    }
    
    
    
    
    // MARK : for get spID from the car id
    func getSpID()
    {
        let url = URL(string: "\(commConst.baseUrl)getSPid.php?car_id=\(selected_CarId)")
        
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
           // let str = String(data: data!, encoding: String.Encoding.utf8)
           // print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
              //  print(jsondata)
                
                DispatchQueue.main.async {
                    
                    let dic = jsondata[0] as! [String : Any]
                    
                    let spid = dic["sp_id"] as! String
                    self.selected_SpID = spid
                   // print(" GET SP ID: \(spid)")
                    
                    // call sp data function for get SP information based on spID
                    self.SelectedSPdata()
                    
                }
            }
            catch
            {
                print("Error in getting json data")
            }
            
        }
        dataTask.resume()
    }
    
    // MARK :  for get all sp data based on selected spID
    func SelectedSPdata()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllspdata.php?sp_id=\(selected_SpID)")
        
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
           // let str = String(data: data!, encoding: String.Encoding.utf8)
            //print(str!)
            
            do
            {
                let spJson = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    let dic = spJson[0] as! [String : Any]
                    
                    // for name
                    let spname = dic["sp_name"] as! String
                    self.spNameLbl.text = spname
                    
                    // for contact
                    let spContact  = dic["sp_mob"] as! String
                    self.spContactLbl.text = "+91\(spContact)"
                    
                    // for sp profile pic
                    
                    let spProfile = dic["sp_profilepic"] as! String
                    let fullpath = "\(commConst.baseUrl)\(spProfile)"
                    let url = URL(string: fullpath)
                    do
                    {
                        let data = try Data(contentsOf: url!)
                        self.spProfileimg.image = UIImage(data: data)
                    }
                    catch
                    {
                        print("Error in downloading error")
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
    

    // MARK : for get selected driver information
    func driverDetail()
    {
        let url = URL(string: "\(commConst.baseUrl)getSelectedDriver.php?driver_id=\(selected_DriverId)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
           // let str = String(data: data!, encoding: String.Encoding.utf8)
          //  print(str!)
            
            do
            {
                let DriverJson = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                DispatchQueue.main.async {
                    
                    let dic = DriverJson[0] as! [String : Any]
                    
                    // for name
                    let DriverName = dic["driver_name"] as! String
                    self.driverNameLbl.text = DriverName
                    self.NotificationdriverName = DriverName
                    
                    // for contact
                    let DriverCOntact = dic["driver_mob"] as! String
                    self.driverContactLbl.text = "+91\(DriverCOntact)"
                    
                    // for driver profile
                    let DriverProfile = dic["driver_profilepic"] as! String
                    let fullpath = "\(commConst.baseUrl)\(DriverProfile)"
                    let url = URL(string: fullpath)
                    do
                    {
                        let imgdata = try Data(contentsOf: url!)
                        self.driverProfileimg.image = UIImage(data: imgdata)
                    }
                    catch
                    {
                        print("error in downloading image")
                    }
                    
                    
                    
                }
            }
            catch
            {
                print("error in getting json data")
            }
        }
        dataTask.resume()
    }
    // func for getting car detail
    func SelectedCarDetail()
    {
        let url = URL(string: "\(commConst.baseUrl)getBookedCar.php?car_id=\(selected_CarId)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
           // let str = String(data: data!, encoding: String.Encoding.utf8)
           // print(str!)
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    let dic = json[0] as! [String : Any]
                    
                    let carName = dic["car_name"] as! String
                    self.carNameLbl.text = carName
                    self.NotificationcarName = carName
                }
            }
            catch
            {
                print("error in getting car data")
            }
            
        }
        dataTask.resume()
        
    }
    
 
    //MARK :  Book BUTTON ACTION
    @IBAction func bookCarAction(_ sender: Any) {
        
        // MARK : Insert data into book table
        let bookObj = BookController()
        bookObj.delegate = self
        
        // MARK : get user id from the user default
        let selected_userID = UserDefaults.standard.string(forKey: "user_id")
        let BookModelObj = BookModel(car_id: Int(selected_CarId)!, driver_id: Int(selected_DriverId)!, sp_id: Int(selected_SpID)!, user_id: Int(selected_userID!)!, toFromLocation: selectedPickLocation, toToLocation: selectedDropLocation, toFromDate: selectedPickDate, toToDate: selectedDropDate, totalKM: selectedTotalKm, spfare: String(selected_SpPrice))
        
        bookObj.BookCar(bookModel: BookModelObj)
    }
    
    // MARK : Delegate function of book car
    func BookReturnResponse(arr: [Any]) {
        
        let dic = arr[0] as! [String : Any]
        let status = dic["status"] as! String
        
        if status == "success"
        {
            print("Booking Successfull")
            
            // MARK : Update car Status
            updateCarStatus()
            
            navigateObj.navigationCommonPush(uiViewController: self, identifier: "AllInformationVC")
        }
        
    }
    
    // MARK : error handle if there is erroe in booking
    func ErrorHandle(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        alert.makeAlertTypeWarning()
        alert.delegate = self
        alert.blurBackground = true
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Something is wrong in booking.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
        
    }
    
    // MARK : func for update status of car
    func updateCarStatus()
    {
        let today = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let todayDate = formatter.string(from: today)
        print(todayDate)
        
        if todayDate == selectedPickDate
        {
            let carStatus = addCarController()
            carStatus.delegate = self
            
            let carStatusModelObj = addCarModel(bookstatus: "Booked", carid: Int(selected_CarId)!)
            
            carStatus.carBookStatus(carBook: carStatusModelObj)
        }
        else
        {
            let carStatus = addCarController()
            carStatus.delegate = self
            
            let carStatusModelObj = addCarModel(bookstatus: "Pending", carid: Int(selected_CarId)!)
            
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
            
            // MARK : update driver sttaus function calll here
            DriverStatusUpdate()

        }
        
    }
    
    // MARK : func for create notification
    func Sendnotification()
    {
        
        // MARK : content of notification
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "UserNotificationIdentifier"
        content.title = "Car-Rental System"
        content.body = "Your booking is sucessfull to \(selectedPickLocation) To \(selectedDropLocation) for date from \(selectedPickDate) To \(selectedDropDate) with car name \(NotificationcarName) and with driver \(NotificationdriverName). Happy Journey."
        
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        // MARK : trigger
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false) // timing when notification is fired
        let identifier = "Main Indentifier"
        
        // MARK : request
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        
        //MARK : action on notification alert
        let cancle = UNNotificationAction.init(identifier: "Cancle", title: "Cancle", options: .destructive)
        
        // MARK : add actiion into category
        let category = UNNotificationCategory.init(identifier: "Catoegory", actions: [cancle], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", categorySummaryFormat: "", options: [])
        usernotification.setNotificationCategories([category])
        
        usernotification.add(request) { (error) in
            
            print("\(String(describing: error?.localizedDescription))")
        }
        
    }
    
    // MARK : delegate method of user notifcation
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        completionHandler()
        UIApplication.shared.applicationIconBadgeNumber -= 1
    }
    
    // MARK : func for change driver status update
    func DriverStatusUpdate()
    {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let todayDate = formatter.string(from: today)
        
        if todayDate >= pickUpdate
        {
            let driverStatus = DriverController()
            driverStatus.delegate = self
            
            let driverObj = Drivermodel(driver_id: Int(selected_DriverId)!, driverStats: "Booked")
            
            driverStatus.bookedStatusUpdate(updateStatus: driverObj)
            
        }
        else
        {
            let driverStatus = DriverController()
            driverStatus.delegate = self
            
            let driverObj = Drivermodel(driver_id: Int(selected_DriverId)!, driverStats: "Pending")
            driverStatus.bookedStatusUpdate(updateStatus: driverObj)
        }
    }
    
    // MARK : delegate method of driver is booked status update
    func DriverBookedStatusUpdate(arr: [Any]) {
        
        let dic = arr[0] as! [String : Any]
        let status = dic["status"] as! String
        
        if status == "success"
        {
            print("Update driver status.")
            
            // mark : CALL NOTIFICATION FUNCTION HERE
            Sendnotification()
        }
    }
    @IBAction func back(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
