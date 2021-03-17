//
//  SpAddCarImage_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 27/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import FCAlertView


class SpAddCarImage_VC: UIViewController,carDelegate,FCAlertViewDelegate {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnChooseCar: UIButton!
    
    // for get  multiple image from gallery
    var selectedAsset = [PHAsset]()
    // for save selected image into array
    var PhotoArray = [UIImage]()
    
    // for car_id
    
    var carID = "";
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        viewCar()
    }
    
    func design()
    {
        // for view1
        view1.layer.cornerRadius = 10
        view1.clipsToBounds = true
        view1.layer.borderWidth = 1
        view1.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        // for image
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        // btn
        btnChooseCar.layer.cornerRadius = 10
        btnChooseCar.clipsToBounds = true

    }
    
    func SelectMultipleImage()
    {
        let imgPicker = ImagePickerController()
        
        self.presentImagePicker(imgPicker, animated: true, select: { (asset : PHAsset)-> Void in
            
        }, deselect: { (asset : PHAsset)-> Void in
            
        }, cancel: { (assets : [PHAsset])-> Void in
            
        }, finish: { (assets :[PHAsset])-> Void in
            
            for i in 0..<assets.count
            {
                self.selectedAsset.append(assets[i])
                
            }
            
            self.convertAssetToImages()
            
        }, completion: nil)
        
        btnChooseCar.setTitle("Upload Images", for: .normal)
    }
    
    // func convertAsset To Images
    func convertAssetToImages() -> Void {
        
        if selectedAsset.count != 0{
            
            
            for i in 0..<selectedAsset.count{
                
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                
                
                manager.requestImage(for: selectedAsset[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                    
                })
                
                self.PhotoArray.append(thumbnail)
                
            }
            
            self.imageView.animationImages = self.PhotoArray
            self.imageView.animationDuration = 5.0
            self.imageView.startAnimating()
            
        }
        
        
        print("complete photo array \(self.PhotoArray)")
    }
    
    // delegate for car image
    func ADdCarImageReturnResp(arr: [Any]) {
        
        let dic = arr[0] as! [String : Any]
        
        let status = dic["status"] as! String
        
        if status == "success"
        {
            print("Car Add")
            let alert = FCAlertView()
            alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
            alert.makeAlertTypeSuccess()
            alert.delegate = self
            alert.blurBackground = true
            alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Successfully Add Car Image.", withCustomImage: nil, withDoneButtonTitle: "OK", andButtons: nil)
            
           
        }
    }
    
    // MARK : error handler
    func ErrorCar(arr: [Any]) {
        
        let alert = FCAlertView()
        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        alert.makeAlertTypeWarning()
        alert.delegate = self
        alert.blurBackground = true
        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "Error in uploading car image.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
    }
    
    // MARK : FCAlertView delegate function
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
         navigateObj.navigationCommonPush(uiViewController: self, identifier: "Sp_viewCarVC")
    }
    
    
    
    func UploadImagesToDatabase()
    {
        var ImgArray = [Any]()
        for item in PhotoArray
        {
            let spid = UserDefaults.standard.string(forKey: "sp_id");
            let baseData = item.jpegData(compressionQuality: 0.5)
            let base64Char = baseData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
            let dic = ["car_image" : base64Char,"sp_id" : spid,"car_id":carID]
            
            ImgArray.append(dic)
            
        }
        
        
        do
        {
            let jsondata  = try JSONSerialization.data(withJSONObject: ImgArray, options: [])
            let carImgObj = addCarController()
            carImgObj.delegate = self
            
            let addCarImg = addCarModel(data: jsondata)
            carImgObj.AddCarImage(carModel: addCarImg)
        }
        catch
        {
            print("Error in casting Image array to Json.")
        }
    }
    
    
    // action of Choose Multiple Image
    @IBAction func BtnActionOfChooseImg(_ sender: Any) {
        
        if btnChooseCar.titleLabel?.text == "Choose multiple image"
        {
            SelectMultipleImage()
        }
        else
        {
            UploadImagesToDatabase()
        }
    }
    
    func viewCar()
    {
        
        let ID = UserDefaults.standard.string(forKey: "sp_id")
        
        let url = URL(string: "\(commConst.baseUrl)getSPcar.php?sp_id=\(ID!)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let readStr = String(data: data!, encoding: String.Encoding.utf8)
            print(readStr!)
            
            do
            {
                let jsonCarData = try JSONSerialization.jsonObject(with: data!, options: []) as?[Any]
                DispatchQueue.main.async {
                    
                    let dic = jsonCarData![0] as! [String : Any]
                   // let id = dic["car_id"] as? String
                    let name = dic["car_name"] as? String
                    print(name!)
                    
                  //  self.carID = id!
                }
                
            }
            catch
            {
                print("error")
            }
            
        }
        dataTask.resume()
    }
    
}
