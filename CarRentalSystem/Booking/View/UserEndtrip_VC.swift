//
//  UserEndtrip_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 01/09/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class UserEndtrip_VC: UIViewController,UITextFieldDelegate,carDelegate,Driverdelegate {

    // MARK : outlet of view
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    // MARK : outlet of view1
    @IBOutlet weak var totalKmLbl: UILabel!
    @IBOutlet weak var extraKmView: UIView!
    @IBOutlet weak var txtextraKM: UITextField!
    @IBOutlet weak var txtMinusKM: UITextField!
    @IBOutlet weak var minusKmView: UIView!
    @IBOutlet weak var SPtotalKmPriceLbl: UILabel!
    @IBOutlet weak var calclulateBtnSP: UIButton!
    @IBOutlet weak var extraChargeLbl: UILabel!
    
    
    // MARK : outlet of view2
    @IBOutlet weak var driverPricePerHourLbl: UILabel!
    @IBOutlet weak var totalHourView: UIView!
    @IBOutlet weak var txtTotalhour: UITextField!
    @IBOutlet weak var DrivertotalAmountDriverLbl: UILabel!
    @IBOutlet weak var calculateBtnDriver: UIButton!
    
    // MARK : outlet of view3
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var spTotalPriceLbl: UILabel!
    @IBOutlet weak var driverTotalPrice: UILabel!
    @IBOutlet weak var finalBillAmount: UILabel!
    @IBOutlet weak var endTripBtn: UIButton!
    
    @IBOutlet weak var userProfileImg: UIImageView!
    
    // MARK : variable for get store value of pervious vc
    var finishcarId : String = ""
    var finishspId : String = ""
    var finishdriverId : String = ""
    var finishcarprice : String = ""
    var finishTotalSpPrice : String = ""
    var finishDriverPricePerHour : String = ""
    var finishTotalKm : String = ""
    var extraCharge : Int = 50
    
    
    // MARK : finall bill price
    var finalSpBillprice : Int = 0
    var finalDriverBillprice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtextraKM.isEnabled = false
        txtMinusKM.isEnabled = false
        design()
        fillInformation()
    }
    
    // MARK : func for design
    func design()
    {
        // MARK : view1
        view1.layer.cornerRadius = 10
        view1.clipsToBounds = true
        view1.layer.borderWidth = 1
        view1.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        // MARK : view2
        view2.layer.cornerRadius = 10
        view2.clipsToBounds = true
        view2.layer.borderWidth = 1
        view2.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        // MARK : view3
        view3.layer.cornerRadius = 10
        view3.clipsToBounds = true
        view3.layer.borderWidth = 1
        view3.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        // MARK : user profile
        userProfileImg.layer.cornerRadius = userProfileImg.frame.size.width / 2;
        userProfileImg.clipsToBounds = true
        
        // MARK : button
        calclulateBtnSP.layer.cornerRadius = 15
        calclulateBtnSP.clipsToBounds = true
        
        calculateBtnDriver.layer.cornerRadius = 15
        calculateBtnDriver.clipsToBounds = true
        
        endTripBtn.layer.cornerRadius = 15
        endTripBtn.clipsToBounds = true
        
        extraKmView.layer.cornerRadius = 10
        extraKmView.clipsToBounds = true
        
        minusKmView.layer.cornerRadius = 10
        minusKmView.clipsToBounds = true
        
        // MARK : driver total amount
        DrivertotalAmountDriverLbl.text = "00.00₹"
        
    }
    
    
    //MARK : dismiss keyborad when user click on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return self.view.endEditing(true)
    }
    
    // MARK : func for fill information which is retirive from pervious vc
    func fillInformation()
    {
        // MARK : fill infor in view 1
        totalKmLbl.text = "Total KM : \(finishTotalKm)"
        extraChargeLbl.text = "Extra Charge per Km : \(extraCharge)"
        
        // MARK : fill information in view2
        driverPricePerHourLbl.text = "Price per hour : \(finishDriverPricePerHour)"
        
        // MARK : fill information in view 3
        userInfo()
    }
    // MARK : get user information
    func userInfo()
    {
        let finishuserId = UserDefaults.standard.string(forKey: "user_id")
        
        let url = URL(string: "\(commConst.baseUrl)getAllUserData.php?user_id=\(finishuserId!)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                print(jsondata)
                if jsondata.count == 0
                {
                    alert.commonAlert(Msg: "No data Found", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        let dic = jsondata[0] as! [String :  Any]
                        
                        // MARK : user name
                        
                        let username = dic["user_name"] as! String
                        self.userNameLbl.text = "Hello \(username)"
                        
                        // MARK : user profile
                        let userprofile = dic["user_profilepic"] as! String
                        let fullpath = "\(commConst.baseUrl)\(userprofile)"
                        let imgUrl = URL(string: fullpath)
                        do
                        {
                            let imgdata = try Data(contentsOf: imgUrl!)
                            self.userProfileImg.image = UIImage(data: imgdata)
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
    
    // MARK : calcluate price for extra kilometer
    @IBAction func calcluateSpPrice(_ sender: Any) {
        
        // MARK : calculate sp price
        calculateSpPrice()
       
    }
    // MARK : action of calcluate price
    @IBAction func calculateDriverPrice(_ sender: Any) {
    
        // MARK : calcluate driver price function
        calculateDriverPrice()
    }
    @IBAction func endTripBtn(_ sender: Any) {
        
        // MARK : call function "endtrip"
        endTripCarStatus()
    }
    @IBAction func PlusBtnClick(_ sender: Any) {
        
        txtextraKM.isEnabled = true
        
    }
    @IBAction func minusBtnClikc(_ sender: Any) {
        
        txtMinusKM.isEnabled = true
    }
    
    // MARK : function for calculate price
    func calculateSpPrice()
    {
        
        let extrakm = txtextraKM.text
        print(extrakm ?? 0)
        let lessKm = txtMinusKM.text
        print(lessKm ?? 0)
        
        if txtextraKM.text == "" && txtMinusKM.text == ""
        {
            alert.commonAlert(Msg: "No extra kilometer or less kilometer", uiVC: self)
            
            SPtotalKmPriceLbl.text = "Total Amount : \(finishTotalSpPrice)₹"
            
            spTotalPriceLbl.text = "\(finishTotalSpPrice)₹"
            
            // MARK : store value
            finalSpBillprice = Int(finishTotalSpPrice)!
            
            calclulateBtnSP.setTitle("Notify Service Provider", for: .normal)
            
            
            
        }
        else if txtextraKM.text != "" && txtMinusKM.text != ""
        {
            txtextraKM.text = ""
            txtMinusKM.text = ""
            txtextraKM.isEnabled = false
            txtextraKM.isEnabled = false
            alert.commonAlert(Msg: "Please select any one choise either less or extra according to your travel", uiVC: self)
            
        }
        else if txtMinusKM.text != ""
        {
            //Int(lessKm!) != 0 && lessKm == ""
            // car price per km
            let priceCarKm = Int(finishcarprice)
            print(priceCarKm!)
            
            // decrease kilometer
            let lessKmInt = Int(lessKm!)
            print(lessKmInt!)
            
            // total fare of service provicer
            let finalValue = Int(finishTotalSpPrice)
            print(finalValue!)
            
            // CALCULATE PRICE FOR decrease kilometer
            let finallessValue = lessKmInt! * priceCarKm!
            print(finallessValue)
            
            // total value after cut kilometer
            let finalSpFare = finalValue! - finallessValue
            print(finalSpFare)
            
            SPtotalKmPriceLbl.text = "Total Amount : \(finalSpFare)₹"
            
            spTotalPriceLbl.text = "\(finalSpFare)₹"
            
            // MARK : store value
            finalSpBillprice = finalSpFare
            
            calclulateBtnSP.setTitle("Notify Service Provider", for: .normal)
            
            
        }
        else if txtextraKM.text != ""
        {
            // Int(extrakm!) != 0 && extrakm == ""
            let priceCarKm = Int(finishcarprice)
            print(priceCarKm!)
            
            let extraKmInt = Int(extrakm!)
            print(extraKmInt!)
            
            // MARK : extra charge for per km is 50rs
            let extraChargePrice = extraKmInt! * extraCharge
            print(extraChargePrice)
            
            // total fare of service provicer
            let finalValue = Int(finishTotalSpPrice)
            print(finalValue!)
            
            let finalExtraValue = extraKmInt! * priceCarKm!
            print(finalExtraValue)
            
            let totalFinal = finalValue! + finalExtraValue + extraChargePrice
            
            SPtotalKmPriceLbl.text = "Total Amount : \(totalFinal)₹"
            
            extraChargeLbl.text = "(Including extra charge : \(extraChargePrice)"
            
            spTotalPriceLbl.text = "\(totalFinal)₹"
            
            // MARK : generate final bill
            finalSpBillprice = totalFinal

            
            calclulateBtnSP.setTitle("Notify Service Provider", for: .normal)
            
        }
        else
        {
            print("You are in else part.")
        }
        
    }
    
    // MARK : calculate driver price
    func calculateDriverPrice()
    {
        if txtTotalhour.text == ""
        {
            alert.commonAlert(Msg: "Please enter total hour", uiVC: self)
        }
        else
        {
            // MARK : convert drivver total price per hour in int
            let driverHourPriceInt = Int(finishDriverPricePerHour)
            print(driverHourPriceInt!)
            
            let totalHourInt = Int(txtTotalhour.text!)
            print(totalHourInt!)
            
            let totalDriverFare = driverHourPriceInt! * totalHourInt!
            print(totalDriverFare)
            
            DrivertotalAmountDriverLbl.text = "Total Amount : \(totalDriverFare)₹"
            
            calculateBtnDriver.setTitle("Notify Driver", for: .normal)
            
            driverTotalPrice.text = "\(totalDriverFare)₹"
            
            // MARK : generate bill
            finalDriverBillprice = totalDriverFare
            
            
            // MARK : call generate bill function here
            generateBill()
        }
        
    }
    
    // MARK : generate final bill
    func generateBill()
    {
        let Value = finalDriverBillprice + finalSpBillprice
        
        let finalValue = String(Value)
        
        finalBillAmount.text = "\(finalValue)₹"
    }
    
    // MARK : update car status on click of endtrip button
    func endTripCarStatus()
    {
        let updateStatus = addCarController()
        updateStatus.delegate = self
        
        let updateCarObj = addCarModel(bookstatus: "Available", carid: Int(finishcarId)!)
        
        updateStatus.carBookStatus(carBook: updateCarObj)
    }
    
    // MARK : delegate method of upcate car status
    func UpdateStatusReturnResp(arr: [Any]) {
        
        let dic = arr[0] as! [String :  Any]
        
        let status = dic["status"] as! String
        
        if status == "success"
        {
            print("Update car status")
            
            // MARK : update driver status function call here
            self.EndtripdriverStatus()
        }
    }
    
    // MARK : change driver status update
    func EndtripdriverStatus()
    {
        let updateStatus = DriverController()
        updateStatus.delegate = self
        
        let driverObj = Drivermodel(driver_id: Int(finishdriverId)!, driverStats: "Available")
        
        updateStatus.bookedStatusUpdate(updateStatus: driverObj)
    }
    
    // MARK : delegate method of driver
    func DriverBookedStatusUpdate(arr: [Any]) {
        
        let dic = arr[0] as! [String : Any]
        let status = dic["status"] as! String
        
        if status == "success"
        {
            print("Driver Status Update")
            navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserBookVC")
        }
    }
    
    // MARK : back
    @IBAction func back(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
}
