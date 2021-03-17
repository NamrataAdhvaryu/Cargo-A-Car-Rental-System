//
//  Driver_ProfileVerification2.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 20/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView

class Driver_ProfileVerification2: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DLVerificationDelegate,FCAlertViewDelegate {
    
    
    @IBOutlet weak var licenseNoView: UIView!
    @IBOutlet weak var txtLicenseNo: TextFieldValidator!
    
    @IBOutlet weak var frontSideView: UIView!
    @IBOutlet weak var frontSideImg: UIImageView!
    @IBOutlet weak var frontSideBtn: UIButton!
    
    @IBOutlet weak var backSideView: UIView!
    @IBOutlet weak var backSideImg: UIImageView!
    @IBOutlet weak var backSideBtn: UIButton!
    
    @IBOutlet weak var disabilityView: UIView!
    @IBOutlet weak var txtdisability: TextFieldValidator!
    @IBOutlet weak var disabilityLbl: UILabel!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    // store image into array
    var DLarray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        desing()
        // Do any additional setup after loading the view.
    }
    
    func desing()
    {
        //license no view
        licenseNoView.layer.cornerRadius = 10
        licenseNoView.layer.shadowRadius = 1.0
        licenseNoView.clipsToBounds = true
        licenseNoView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        licenseNoView.layer.borderWidth = 1
        
        // front view
        frontSideView.layer.cornerRadius = 10
        frontSideView.layer.shadowRadius = 1.0
        frontSideView.clipsToBounds = true
        frontSideView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        frontSideView.layer.borderWidth = 1
        
        
        // front image
        frontSideImg.layer.cornerRadius = 10
        frontSideImg.layer.shadowRadius = 1.0
        frontSideImg.clipsToBounds = true
        
        //back image
        backSideImg.layer.cornerRadius = 10
        backSideImg.layer.shadowRadius = 1.0
        backSideImg.clipsToBounds = true
        
        // back view
        backSideView.layer.cornerRadius = 10
        backSideView.layer.shadowRadius = 1.0
        backSideView.clipsToBounds = true
        backSideView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        backSideView.layer.borderWidth = 1
        
        // disability view
        disabilityView.layer.cornerRadius = 10
        disabilityView.layer.shadowRadius = 1.0
        disabilityView.clipsToBounds = true
        disabilityView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        disabilityView.layer.borderWidth = 1
        
        // disability textfield
        
        alert.CommontextLayer(txt: (txtdisability)! , imgStr: "user.png")
        
        // license number textfield
        alert.CommontextLayer(txt: (txtLicenseNo)!, imgStr: "user.png")
        
        //done btn
        doneBtn.layer.cornerRadius = 10
        doneBtn.clipsToBounds = true
    }
    
    @IBAction func backClick(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
    @IBAction func AddFrontBtn(_ sender: Any) {
        
        chooseImage()
    }
    
    @IBAction func addBackBtn(_ sender: Any) {
        
        chooseImage()
    }
    
    // function for choose image from the gallery
    func chooseImage()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if frontSideBtn.titleLabel?.text == "Add Front Side"
        {
             let img1 = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            frontSideImg.image = img1
            self.DLarray.append(img1)
            frontSideBtn.setTitle("DONE", for: .normal)
            self.dismiss(animated: true, completion: nil)
            print(DLarray)
        }
        else
        {
            let img1 = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            backSideImg.image = img1
            self.DLarray.append(img1)
            backSideBtn.setTitle("DONE", for: .normal)
            self.dismiss(animated: true, completion: nil)
            frontSideBtn.setTitle("Add Front Side", for: .normal)
            backSideBtn.setTitle("Add Back Side", for: .normal)
            print(DLarray)
        }

    }
    
    @IBAction func verifyBtnClick(_ sender: Any) {
        
        verifyDocument()
    }
    
    func verifyDocument()
    {
        var verifyImg = [Any]()
        for item in DLarray
        {
            
            
            let driverID = UserDefaults.standard.string(forKey: "driver_id")
            
            let baseData = item.jpegData(compressionQuality: 0.5)
            let base64Char = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
            let dic = ["licence_image" : base64Char!,"driver_id" : driverID!,"verification_id":"\(101)","licence_no":"\(txtLicenseNo.text!)","disability":"\(txtdisability.text!)"]
            verifyImg.append(dic)
        }
        
        do
        {
            // for casting array into images
            
            let jsonData = try JSONSerialization.data(withJSONObject: verifyImg, options: [])
            let DLimages = DVerificationController()
            
            DLimages.delegete = self
            
            let licenseObj = DriverVerification(data: jsonData)
            
            DLimages.verificationDetail(verifyModel: licenseObj)
        }
        catch
        {
            print("Error in cast images into json")
        }
    }
    
    // delegate function
    
    func AddDLImagesReturnResp(arr: [Any]) {
        
        let dic = arr[0] as? [String : Any]
        
        let status = dic!["status"] as? String
        if status == "success"
        {
            let alert = FCAlertView()
            alert.makeAlertTypeSuccess()
            
            alert.delegate = self
            alert.blurBackground = true
            alert.showAlert(inView: self, withTitle: "", withSubtitle: "Verification Successfull", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            //print(arr)
           // print("Record Inserted")
            
        }
        
    }
    
    // MARK : error handler
    func ErrorDriverVerification(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.makeAlertTypeWarning()
        
        alert.delegate = self
        alert.blurBackground = true
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Error in uploading Driver licence.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
    }
    
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "DriverMoreVC")
        
    }
}
