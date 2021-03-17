//
//  DriverController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 19/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

// Create protocol for return data via delegate method

@objc protocol Driverdelegate{
    
    //for driver registration
    @objc optional func DriverReturnResponse(arr : [Any])
    
    // for driver login
    @objc optional func DriverLoginReturnResponse(arr :[Any])
    
    //for driver update data
    @objc optional func DriverUpdateReturnResponse(arr :[Any])
    
    //for driver booked status updat
    @objc optional func DriverBookedStatusUpdate(arr : [Any])
    
    //for error
    @objc optional func ErrorDriver(arr : [Any])
}

class DriverController: NSObject {
    
    var delegate : Driverdelegate?
    
    func DriverRegistration(driverModel : Drivermodel)
    {
        let url = URL(string: "\(commConst.baseUrl)DriverRegistration.php")
        
        let strBody = "driver_name=\(driverModel.driver_name!)&driver_address=\(driverModel.driver_address!)&driver_email=\(driverModel.driver_email!)&driver_password=\(driverModel.driver_password!)&driver_mob=\(driverModel.driver_mob!)&driver_status=\(driverModel.driver_status!)&driver_profilepic=\(driverModel.driver_profilepic!)";
        
        /*
        CommonApiCall(url: url!, param: strBody) { (result) -> () in
            
            self.delegate?.DriverReturnResponse!(arr: result)
            
        }
 */
        CommonApiCall(url: url!, param: strBody, completion: { (result) in
            
            self.delegate?.DriverReturnResponse!(arr: result)
            
        }) { (error) in
        
            self.delegate?.ErrorDriver!(arr: error)
        }
        
    }
        
    func DriverLogin(driverModel : Drivermodel)
    {
        let url = URL(string: "\(commConst.baseUrl)DriverLogin.php?driver_email=\(driverModel.driver_email!)&driver_password=\(driverModel.driver_password!)")
        /*
        CommonApiLogin(url: url!) { (result) -> () in
            
            self.delegate?.DriverLoginReturnResponse!(arr: result)
        }
 */
        CommonApiLogin(url: url!, completion: { (result) in
            
            self.delegate?.DriverLoginReturnResponse!(arr: result)
            
        }) { (error) in
            
            self.delegate?.ErrorDriver!(arr: error)
        }
        
        
    }
    
    func updateDriverData(driverModel : Drivermodel)
    {
        let url = URL(string: "\(commConst.baseUrl)updateDriver.php");
        
        let body = "driver_name=\(driverModel.driver_name!)&driver_email=\(driverModel.driver_email!)&driver_password=\(driverModel.driver_password!)&driver_address=\(driverModel.driver_address!)&driver_mob=\(driverModel.driver_mob!)&driver_location=\(driverModel.driver_location!)&driver_isbooked_status=\(driverModel.driver_isbooked_status!)&driver_numberOftour=\(driverModel.driver_numberOftour!)&driver_priceperHour=\(driverModel.driver_priceperHour!)&driver_status=\(driverModel.driver_status!)&driver_id=\(driverModel.driver_id!)&driver_profilepic=\(driverModel.driver_profilepic!)&driver_status=\(driverModel.driver_status!)";
        /*
        CommonApiCall(url: url!, param: body) { (result) -> () in
            
            self.delegate?.DriverUpdateReturnResponse!(arr: result)
        }
 */
        
        CommonApiCall(url: url!, param: body, completion: { (result) in
            
            self.delegate?.DriverUpdateReturnResponse!(arr: result)
            
        }) { (error) in
            
            self.delegate?.ErrorDriver!(arr: error)
        }
    }
    
    // MARK : for update driver booked status update
    func bookedStatusUpdate(updateStatus : Drivermodel)
    {
        let url = URL(string: "\(commConst.baseUrl)UpdateDriverStatus.php")
        
        let body = "driver_id=\(updateStatus.driver_id!)&driver_isbooked_status=\(updateStatus.driver_isbooked_status!)";
        
        var request = URLRequest(url: url!)
        
        request.addValue(String(body.count), forHTTPHeaderField: "Content-Length")
        request.httpBody = body.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsondata.count == 0
                {
                    DispatchQueue.main.async {
                        
                        print("No data found.")
                        let error = [Any]()
                        self.delegate?.ErrorDriver!(arr: error)
                        
                    }
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.delegate?.DriverBookedStatusUpdate!(arr: jsondata)
                    }
                }
            }
            catch
            {
                
                DispatchQueue.main.async {
                    
                    print("Error in update json data.")
                    let err = [Any]()
                    self.delegate?.ErrorDriver!(arr: err)
                }
                
            }
        }
        dataTask.resume()
    }
}
