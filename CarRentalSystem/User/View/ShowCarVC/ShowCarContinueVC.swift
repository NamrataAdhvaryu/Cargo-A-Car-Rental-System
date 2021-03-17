//
//  ShowCarContinueVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 09/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import CoreLocation

// MARK : for get round figure of KM
var totalKm : Int = 0

var finalPrice : Int = 0

var FinaldropOffLocation : String = ""
var FinalpickUpLocation : String = ""
var FinalCarId : String = ""

class ShowCarContinueVC: UIViewController{

    @IBOutlet weak var upperView1: UIView!
    @IBOutlet weak var upperView2: UIView!
    @IBOutlet weak var upperView3: UIView!
    @IBOutlet weak var upperView4: UIView!
   @IBOutlet weak var upperView5: UIView!
    @IBOutlet weak var uppaerView6: UIView!
    
    
    @IBOutlet weak var btnBookCar: UIButton!
    
    // outlet of view1
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carPaymentMode: UILabel!
    @IBOutlet weak var carprice: UILabel!
    
    // outlet of view2
    @IBOutlet weak var carSteering: UILabel!
    @IBOutlet weak var carInsurance: UILabel!
    @IBOutlet weak var carPassanger: UILabel!
    @IBOutlet weak var carAirbag: UILabel!
    @IBOutlet weak var carSuitcase: UILabel!
    @IBOutlet weak var carAC: UILabel!
    @IBOutlet weak var carDoor: UILabel!
    
    // outlet of view3
    @IBOutlet weak var pickupdate: UILabel!
    @IBOutlet weak var pickUpLocation: UILabel!
    @IBOutlet weak var pickUpValue: UILabel!
    
    
    // outlet of view4
    @IBOutlet weak var dropOffDate: UILabel!
    @IBOutlet weak var dropOffLocation: UILabel!
    @IBOutlet weak var dropValue: UILabel!
    
    // outlet of view 5
    @IBOutlet weak var totalLMlbl: UILabel!
    @IBOutlet weak var totalpriceLbl: UILabel!
    @IBOutlet weak var calculateKmBtn: UIButton!
    @IBOutlet weak var calculatePriceBtn: UIButton!
    
    // MARK : varibale for saving pick up location latitude and longitude
    
    var latitudePickup : Double = 0.0
    var longitudePickup : Double = 0.0
    
    // MARK : variable for saving drop off location latitude and longitude
    var latitudeDrop : Double = 0.0
    var longitudeDrop : Double = 0.0
    
    
    
    // MARK : for saved car price per KM
    var carPrice : Int = 0
    
    
    var getCarid = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
      getPerticulerCar()
        storedate()
        
        FinalCarId = getCarid

    }
    // store date
    func storedate()
    {
        pickupdate.text = "Pick-up Location - \(pickUpdate)"
        
        dropOffDate.text = "Return Location - \(dropOffdate)"
    }
    
    func design()
    {
        // upper view 1
        upperView1.layer.cornerRadius = 10
        upperView1.clipsToBounds = true
        upperView1.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
       // upperView1.layer.shadowRadius 1
        upperView1.layer.shadowOpacity = 1
        upperView1.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        upperView1.layer.borderWidth = 1
        upperView1.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        // upperview 2
        upperView2.layer.cornerRadius = 10
        upperView2.clipsToBounds = true
        upperView2.layer.borderWidth = 1
        upperView2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        //upperview 3
        upperView3.layer.cornerRadius = 10
        upperView3.clipsToBounds = true
        upperView3.layer.borderWidth = 1
        upperView3.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        //upperview 4
        upperView4.layer.cornerRadius = 10
        upperView4.clipsToBounds = true
        upperView4.layer.borderWidth = 1
        upperView4.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        //upperview 5
        upperView5.layer.cornerRadius = 10
        upperView5.clipsToBounds = true
        upperView5.layer.borderWidth = 1
        upperView5.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        //upperview 6
        uppaerView6.layer.cornerRadius = 10
        uppaerView6.clipsToBounds = true
        uppaerView6.layer.borderWidth = 1
        uppaerView6.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // btn 
        btnBookCar.layer.cornerRadius = 10
        btnBookCar.clipsToBounds = true
        
        // img
        carImage.layer.cornerRadius = 10
        carImage.clipsToBounds = true
        
        // calculate KM
        calculateKmBtn.layer.cornerRadius = 10
        calculateKmBtn.clipsToBounds = true

        // calculate Price
        calculatePriceBtn.layer.cornerRadius = 10
        calculatePriceBtn.clipsToBounds = true
        
        // total KM label
        totalLMlbl.clipsToBounds = true
        totalLMlbl.textAlignment = .center
        
        // total price
        totalpriceLbl.clipsToBounds = true
        totalpriceLbl.textAlignment = .center
        
        // car price lable
        carprice.clipsToBounds = true
        carprice.textAlignment = .center
        
        //car payment mode lable
        carPaymentMode.clipsToBounds = true
        carPaymentMode.textAlignment = .center
        

    }
    
    @IBAction func BtnBookContinue(_ sender: UIButton)
    {
        if pickUpValue.text == "" && dropValue.text == "" && totalLMlbl.text == "" && totalpriceLbl.text == ""
        {
            alert.commonAlert(Msg: "Please Select PickUp location and DropOff Location & Calculate Total KM and Total Price.", uiVC: self)
        }
        else
        {
            navigateObj.navigationCommonPush(uiViewController: self, identifier: "User_ShowAllDriver")
        }
    }
    
    
    // getAllcar
    func getPerticulerCar()
    {
        let url = URL(string: "\(commConst.baseUrl)getPerticulerCar.php?car_id=\(getCarid)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            //let str = String(data: data!, encoding: String.Encoding.utf8)
           // print(str!)
            
            
            // for view1
            do
            {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                DispatchQueue.main.async {
                    
                    let dic = jsonData[0] as! [String : Any]
                    
                    //for image
                    let imgpath = dic["car_image"] as! String
                    let fullpath = "\(commConst.baseUrl)\(imgpath)"
                    let url = URL(string: fullpath)
                    do
                    {
                        let imgData = try Data(contentsOf: url!)
                        self.carImage.image = UIImage(data: imgData)
                        
                    }
                    catch
                    {
                        print("Error in downloading error")
                    }
                    
                    
                    // for car name
                    let carName = dic["car_name"] as! String
                    self.carName.text = carName
                    
                    //for car payment option
                    let carPaymentOption = dic["car_paymentMode"] as! String
                    self.carPaymentMode.text = carPaymentOption
                    
                    // for car Price per KM
                    let carPriceKM = dic["car_PriceKM"] as! String
                    self.carprice.text = "Per KM : \(carPriceKM)₹"
                    self.carPrice = Int(carPriceKM)!
                    
                    
             // for view 2
                    
                    
                    // steering type
                    let carSteering = dic["car_SteeringType"] as! String
                    self.carSteering.text = carSteering
                    
                    // transmission (gear type)
                    //let carTransmission = dic[""]
                    
                    // insurance
                    let carInsurance = dic["car_insurance"] as! String
                    self.carInsurance.text = carInsurance
                    
                    // car passanger capacity
                    let carPassanger = dic["car_passCapacity"] as! String
                    self.carPassanger.text = carPassanger
                    
                    // car Airbag is avaible
                    let carAirbag = dic["car_Airbag"] as! String
                    self.carAirbag.text = carAirbag
                    
                    // car luggage capacity
                    let carSuitcase = dic["car_luggage"] as! String
                    self.carSuitcase.text = carSuitcase
                    
                    // car AC
                    let carAc = dic["car_AC"] as! String
                    self.carAC.text = carAc
                    
                    // car door
                    
                    let carDoor = dic["car_lockDoor"] as! String
                    self.carDoor.text = carDoor
                }
            }
            catch
            {
                print("error in getting data form json")
            }
            
        }
        dataTask.resume()
    }
    
    
    // MARK : pop to back view controller
    @IBAction func backBtnAction(_ sender: Any) {
        
    navigateObj.navigationCommonPop(uiViewController: self)
        
    }
// MARK : navigate This VC to Pickup location VC
    @IBAction func pickUpLocation(_ sender: Any) {
        
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "UserPickUpLocation") as! UserPickUpLocation
        stb.delegate = self
        self.navigationController?.pushViewController(stb, animated: true)
    }
    
    // MARK : navigate this VC to drop off location VC
    @IBAction func dropOff(_ sender: Any) {
        
            let stb = self.storyboard?.instantiateViewController(withIdentifier: "UserDropOffLocation") as! UserDropOffLocation
            stb.delegate = self
            self.navigationController?.pushViewController(stb, animated: true)
       
    }
    
    // MARK : calculate distance between two location
    
    @IBAction func calculateKm(_ sender: Any) {
        
        if pickUpValue.text == "" && dropValue.text == ""
        {
            alert.commonAlert(Msg: "Please select Pick-Up and Drop-off location", uiVC: self)
            
        }
        else
        {
            let pickUpLocation = CLLocation(latitude: latitudePickup, longitude: longitudePickup)
            let dropoffLocation = CLLocation(latitude: latitudeDrop, longitude: longitudeDrop)
            
            let distance = pickUpLocation.distance(from: dropoffLocation) / 1000
        
            let aValue = distance
            //print(aValue)
        
            totalKm = Int(round(aValue))
            //print(totalKm)
            
            
            totalLMlbl.text = "\(String(totalKm)) KM"
            
        }
        
        
    }
    
    
    // MARK : calculate total price per KM
    @IBAction func calculatePrice(_ sender: Any) {
        
        
        if carprice.text == ""
        {
            alert.commonAlert(Msg: "Error in getting Car Price.", uiVC: self)
        }
        else if totalLMlbl.text == ""
        {
            alert.commonAlert(Msg: "Error in getting Total KM.(Please Calculate Total KM.)", uiVC: self)
        }
        else
        {
            let price = carPrice
            let km = totalKm
            
            finalPrice = km * price
           // print(finalPrice)
            
            totalpriceLbl.text = "\(String(finalPrice)) ₹"
            
        }
    }
    
    
}

// MARK : inherit protocol

extension ShowCarContinueVC : pickUpLocationDelegate,dropOffLocationDelegate
{
    
   // MARK : protocol to get drop off location
    func passDataBackdropOff(dropOff: String, Dlatitude: Double, Dlongitude: Double) {
        
        dropValue.text = dropOff
        print(dropOff)
        FinaldropOffLocation = dropOff
        
        latitudeDrop = Dlatitude
        print(Dlatitude)
        
        longitudeDrop = Dlongitude
        print(Dlongitude)
    }
    
    
    // MARK : protocol to get pick up location
    func passdataBackPickUp(pickUp: String, latitude: Double, longitude: Double) {
        
        pickUpValue.text = pickUp
        print(pickUp)
        FinalpickUpLocation = pickUp
        
        latitudePickup = latitude
        print(latitude)
        
        longitudePickup = longitude
        print(longitude)
        
    }
    
    
}

