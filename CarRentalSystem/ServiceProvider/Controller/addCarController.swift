//
//  addCarController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 24/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

// Create protocol for return data via delegate method

@objc protocol carDelegate{
    
    @objc optional func CarReturnResponse(arr : [Any])
    @objc optional func ADdCarImageReturnResp(arr : [Any])
    @objc optional func UpdateStatusReturnResp(arr : [Any])
    @objc optional func ErrorCar(arr : [Any])
}


class addCarController: NSObject {
    
    var delegate : carDelegate?
    
    func addCar(carModel : addCarModel)
    {
        let url = URL(string: "\(commConst.baseUrl)AddCar.php")
        
        
        let strbody = "car_name=\(carModel.car_name!)&car_model=\(carModel.car_model!)&car_modelNo=\(carModel.car_modelNo!)&car_passCapacity=\(carModel.car_passCapacity!)&car_RCbook=\(carModel.car_RCbook!)&car_insurance=\(carModel.car_insurance!)&car_ISavailable=\(carModel.car_ISavailable!)&car_bookedStatus=\(carModel.car_bookedStatus!)&car_AC=\(carModel.car_AC!)&car_Airbag=\(carModel.car_Airbag!)&car_lockDoor=\(carModel.car_lockDoor!)&car_SteeringType=\(carModel.car_SteeringType!)&car_PriceKM=\(carModel.car_PriceKM!)&car_paymentMode=\(carModel.car_paymentMode!)&car_luggage=\(carModel.car_luggage!)&car_image=\(carModel.car_image!)&sp_id=\(carModel.sp_id!)";
        /*
        CommonApiCall(url: url!, param: strbody) { (result)-> () in
            
            self.delegate?.CarReturnResponse!(arr: result)
            
        }
 */
        CommonApiCall(url: url!, param: strbody, completion: { (result) in
            
            self.delegate?.CarReturnResponse!(arr: result)
            
        }) { (error) in
            
            self.delegate?.ErrorCar!(arr: error)
        }

}
    // MARK : to add mutlitple image of car
    
    func AddCarImage(carModel : addCarModel)
    {
        let url = URL(string: "\(commConst.baseUrl)order.php")
        
       // let strBody = "car_id=\(carModel.car_id!)&car_image=\(carModel.car_image!)&sp_id=(\(carModel.sp_id!))"
        
        var request = URLRequest(url: url!)
        request.addValue(String(carModel.imgData!.count), forHTTPHeaderField: "Content-Length")
        request.httpBody = carModel.imgData
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, resp, error) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                //let json = try JSONSerialization.data(withJSONObject: ImgArray, options: [])
               // let imgArray = [Any]()
                
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    self.delegate?.ADdCarImageReturnResp!(arr: json)
                }
                
            }
            catch
            {
                DispatchQueue.main.async {
                    
                    print("error")
                    let err = [Any]()
                    self.delegate?.ErrorCar!(arr: err)
                    
                }
                
            }
        
        }
        dataTask.resume()
        
        
    }
    
    // MARK : func to update car booked staus
    func carBookStatus(carBook : addCarModel)
    {
        let url = URL(string: "\(commConst.baseUrl)UpdateCarStatus.php")
        
        // MARK : containt data
        let body = "car_bookedStatus=\(carBook.car_bookedStatus!)&car_id=\(carBook.car_id!)";
        
        var request = URLRequest(url: url!)
        request.addValue(String(body.count), forHTTPHeaderField: "Content-Length");
        request.httpBody = body.data(using: String.Encoding.utf8)
        request.httpMethod = "POST";
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonarr  = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any];
                print(jsonarr)
                
                print(jsonarr)
                
                DispatchQueue.main.async {
                    
                    self.delegate?.UpdateStatusReturnResp!(arr: jsonarr)
                }
            }
            catch
            {
                print("Error")
                DispatchQueue.main.async {
                    
                    let err = [Any]()
                    self.delegate?.ErrorCar!(arr: err)
                    
                }
            }
        }
        dataTask.resume()
        
    }
    
}
