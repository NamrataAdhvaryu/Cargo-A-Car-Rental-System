//
//  SpAddCar_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 13/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView

class SpAddCar_VC: UIViewController,carDelegate,FCAlertViewDelegate {

    
    // outlets of texyfield
    
    @IBOutlet weak var txt_Carname: UITextField!
    @IBOutlet weak var txt_Carmodel: UITextField!
    @IBOutlet weak var txt_carmodelNo: UITextField!
    @IBOutlet weak var txt_PassCapacity: UITextField!
    @IBOutlet weak var txt_RCBook: UITextField!
    @IBOutlet weak var txt_insurance: UITextField!
    @IBOutlet weak var txt_available: UITextField!
    @IBOutlet weak var txt_Isbooked: UITextField!
    @IBOutlet weak var txt_AC: UITextField!
    @IBOutlet weak var txt_Airbag: UITextField!
    @IBOutlet weak var txt_Door: UITextField!
    @IBOutlet weak var txt_SteeringType: UITextField!
    @IBOutlet weak var txt_PriceKM: UITextField!
    @IBOutlet weak var txt_paymentMode: UITextField!
    @IBOutlet weak var txt_Luggage: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txt_Isbooked.text = "Available"
        // Do any additional setup after loading the view.
    }
    
    // delegate function
    
    func CarReturnResponse(arr: [Any]) {
        
        let dic = arr[0] as? [String : Any]
        
        let status = dic!["status"] as? String
        
        
        
        if status == "success"
        {
            print(arr)
            let alert = FCAlertView()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
            alert.makeAlertTypeSuccess()
            alert.delegate = self
            alert.blurBackground = true
            alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Successfully Add Car detail.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            
        }
    }
    
    // MARK : ERROR HANDLER
    func ErrorCar(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        alert.makeAlertTypeWarning()
        alert.delegate = self
        alert.blurBackground = true
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Error in uploading car detail.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
        
    }
    
    // MARK : FCAlertView delegate function
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "Sp_viewCarVC")
    }

    @IBAction func LOGOUT(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "sp_id")
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "HomeViewController")
    }
    
    // add function for add car data
    func addCar()
    {
        
            // default image for car
        let defualtImg = UIImageView(image: UIImage(imageLiteralResourceName: "noimage"))
        let baseData = defualtImg.image?.jpegData(compressionQuality: 2.0)
        let base64Str = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        print(base64Str!)
        
        let ID = UserDefaults.standard.string(forKey: "sp_id")
        
        print(ID!)
            let carAddObj = addCarController()
            
            carAddObj.delegate = self
            
        let  carData = addCarModel(sp_id: Int(ID!)!, car_id: 101, car_name:txt_Carname.text!, car_model: txt_Carmodel.text!, car_modelNo: txt_carmodelNo.text!, car_passCapacity: txt_PassCapacity.text!, car_RCbook: txt_RCBook.text!, car_insurance: txt_insurance.text!, car_ISavailable: txt_available.text!, car_bookedStatus: txt_Isbooked.text!, car_AC: txt_AC.text!, car_Airbag: txt_Airbag.text!, car_lockDoor: txt_Door.text!, car_SteeringType: txt_SteeringType.text!, car_PriceKM: txt_PriceKM.text!, car_paymentMode: txt_paymentMode.text!, car_luggage: txt_Luggage.text!, car_image: base64Str!)
        
        
            
            carAddObj.addCar(carModel: carData)
        
    }
    @IBAction func addcarSubmit(_ sender: Any) {
        
        addCar()
    }
    
    @IBAction func backArrow(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
